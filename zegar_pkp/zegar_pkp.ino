#include "motor.h"
#include "rtc.h"
#include "time.h"

#include <LowPower.h>
#include <Wire.h>

#define PIN_ALARM 2
#define PIN_BTN 3
#define PIN_BTN_TURN_ON 6

#define TICK 500L
#define CLOCK_DEBUG 0
#define QUEUE_SIZE 32

enum class Event { WAIT = 0, ALARM = 1, CHANGE_TIME = 2, SYNC = 3 };
static volatile Event _events[QUEUE_SIZE] = { Event::WAIT };
static volatile byte _read_counter = 0;
static volatile byte _write_counter = 0;

void setup() {
  pinMode(PIN_ALARM, INPUT_PULLUP);
  pinMode(PIN_BTN, INPUT_PULLUP);
  pinMode(PIN_BTN_TURN_ON, INPUT_PULLUP);

  attachInterrupt(digitalPinToInterrupt(PIN_ALARM), alarm, FALLING);
  attachInterrupt(digitalPinToInterrupt(PIN_BTN), change_time, FALLING);

  Motor.begin();
  Rtc.begin();

  if (Rtc.get_status() &
      (1 << RTC_STATUS_FLAG_OSF)) { // When RTC lost the power.
    Rtc.reset();
    push_event(Event::WAIT);
  } else { // When the microcontroller was turned off but RTC was working.
    Rtc.clear_alarm2();
    push_event(Event::SYNC);
  }

#if CLOCK_DEBUG
  Serial.begin(19200);
  while (!Serial)
    ;
  Serial.println("INIT");
#endif
}

#if CLOCK_DEBUG
void print_time(byte hours, byte minutes, byte seconds) {
  if (hours < 10)
    Serial.print('0');
  Serial.print(hours);
  Serial.print(':');
  if (minutes < 10)
    Serial.print('0');
  Serial.print(minutes);
  Serial.print(':');
  if (seconds < 10)
    Serial.print('0');
  Serial.print(seconds);
}

void print_byte(byte val) {
  char a[9] = {0};
  for (byte i = 0; i < 8; i++) {
    a[7 - i] = val & 1 ? '1' : '0';
    val = val >> 1;
  }
  Serial.print(a);
}
#endif

inline void delay_tick() {
  for (int t = 0; t < 1000L; t++) {
    delayMicroseconds(TICK);
  }
}

inline Time get_time_from_rtc() { return {Rtc.get_minutes(), Rtc.get_hours()}; }

inline Time get_alarm1_from_rtc() {
  return {Rtc.get_alarm1_minutes(), Rtc.get_alarm1_hours()};
}

inline void set_time_in_rtc(const Time &t) {
  Rtc.set_minutes(t.minutes());
  Rtc.set_hours(t.hours());
}

inline void set_alarm1_in_rtc(const Time &t) {
  Rtc.set_alarm1_minutes(t.minutes());
  Rtc.set_alarm1_hours(t.hours());
}

inline void motor_tick() {
  #if CLOCK_DEBUG
    Serial.println("TICK");
  #endif
  Motor.tick();
}

inline void manage_event(Event event) {
  switch (event) {
  case Event::CHANGE_TIME: {
    while (digitalRead(PIN_BTN) == LOW) {
      motor_tick();

      Time new_time = get_time_from_rtc();
      new_time.increment_minute();

      set_time_in_rtc(new_time);
      set_alarm1_in_rtc(new_time);

      delay_tick();
    }
    Motor.turn_off();
    Rtc.clear_alarm2();
  } break;
  case Event::ALARM:
  case Event::SYNC: {
    Time last_set_time = get_alarm1_from_rtc();
    int last_set_total_minutes = last_set_time.get_total_minutes();

    Time current_time = get_time_from_rtc();
    int current_total_minutes = current_time.get_total_minutes();

    int lack_minutes;
    if (last_set_total_minutes <= current_total_minutes) {
      lack_minutes = current_total_minutes - last_set_total_minutes;
    } else {
      lack_minutes = current_total_minutes + 12 * 60 - last_set_total_minutes;
    }

    #if CLOCK_DEBUG
      Serial.print("Alarm1 minutes:  "); Serial.println(last_set_total_minutes);
      Serial.print("Current minutes: "); Serial.println(current_total_minutes);
      Serial.print("Lack minutes:    "); Serial.println(lack_minutes);
    #endif

    for (int i = 0; i < lack_minutes; i++) {
      motor_tick();
      delay_tick();
    }
    Motor.turn_off();

    set_alarm1_in_rtc(current_time);
    Rtc.clear_alarm2();
  } break;
  default: break;
  }
}

void loop() {
  noInterrupts();
  Event event = _events[_read_counter];
  interrupts();
#if CLOCK_DEBUG
  static unsigned int iii = 0;
  static unsigned char iiii = 0;
  if (iii++ == 0 && (iiii++ & 0b111) == 0) {
    Serial.print("event: ");
    switch (event) {
    case Event::WAIT:
      Serial.print("WAIT  ");
      break;
    case Event::ALARM:
      Serial.print("ALARM ");
      break;
    case Event::CHANGE_TIME:
      Serial.print("CHANGE");
      break;
    case Event::SYNC:
      Serial.print("SYNC  ");
      break;
    default:
      Serial.print("???   ");
      break;
    }
    Serial.print(" time: ");
    print_time(Rtc.get_hours(), Rtc.get_minutes(), Rtc.get_seconds());
    Serial.print(" alarm1: ");
    print_time(Rtc.get_alarm1_hours(), Rtc.get_alarm1_minutes(),
               Rtc.get_alarm1_seconds());
    Serial.print(" status: ");
    print_byte(Rtc.get_status());
    Serial.print(" control: ");
    print_byte(Rtc.get_control());
    Serial.print(" int: ");
    Serial.print(digitalRead(PIN_ALARM));
    Serial.print('\n');
    delayMicroseconds(10000L);
  }
  if (event == Event::WAIT) {
    return;
  }
#else
  if (event == Event::WAIT) {
    LowPower.powerDown(SLEEP_FOREVER, ADC_OFF, BOD_OFF);
    return;
  }
#endif
  manage_event(event);
  #if CLOCK_DEBUG
    Serial.print("Read Counter: "); Serial.println(_read_counter);
  #endif
  noInterrupts();
  _events[_read_counter] = Event::WAIT;
  _read_counter = (_read_counter + 1) % QUEUE_SIZE;
  interrupts();
}

inline volatile void push_event(Event event) {
#if CLOCK_DEBUG
  Serial.print("Write Counter: "); Serial.println(_write_counter);
#endif
  _events[_write_counter] = event;
  _write_counter = (_write_counter + 1) % QUEUE_SIZE;
}

void volatile alarm() {
#if CLOCK_DEBUG
  Serial.println("ALARM!");
#endif
  push_event(Event::ALARM); 
}

void volatile change_time() { push_event(Event::CHANGE_TIME); }
