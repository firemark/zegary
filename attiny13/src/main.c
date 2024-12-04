#include <avr/interrupt.h>
#include <avr/io.h>
#include <avr/sleep.h>
#include <util/delay.h>

#include "i2c.h"
#include "motor.h"
#include "rtc.h"

#ifdef TEST
#include "avr_mcu_section.h"
AVR_MCU(F_CPU, "attiny13");
// AVR_MCU_VCD_FILE("main.vcd", 1000);
// AVR_MCU_EXTERNAL_PORT_PULL('B', (1 << 0), 1);
// AVR_MCU_EXTERNAL_PORT_PULL('B', (1 << 1), 0xFFF);

// const struct avr_mmcu_vcd_trace_t _mytrace[] _MMCU_ = {
//     {AVR_MCU_VCD_SYMBOL("SDA_DIR"), .mask = (1 << 0), .what = (void*)&DDRB},
//     {AVR_MCU_VCD_SYMBOL("SDA_IN"), .mask = (1 << 0), .what = (void*)&PINB},
//     {AVR_MCU_VCD_SYMBOL("SDA_OUT"), .mask = (1 << 0), .what = (void*)&PORTB},
//     {AVR_MCU_VCD_SYMBOL("SCL"), .mask = (1 << 2), .what = (void*)&PORTB},
//     {AVR_MCU_VCD_SYMBOL("INT"), .mask = (1 << 1), .what = (void*)&PINB},
//     {AVR_MCU_VCD_SYMBOL("MOTOR_A"), .mask = (1 << 3), .what = (void*)&PORTB},
//     {AVR_MCU_VCD_SYMBOL("MOTOR_B"), .mask = (1 << 4), .what = (void*)&PORTB},
// };
#endif

#define IS_INT_PIN_HIGH (PINB & (1 << PB1))

static void setup() {
  // Input pin B1 with pull-up
  PORTB = (1 << PB1) | motor_port_setup() | i2c_port_setup();
  DDRB = motor_ddr_setup() | i2c_ddr_setup();

  // Pin PB1 interrupt.
  MCUCR = (1 << PCIE);  // 1 -> 0 triggers.
  GIMSK = (1 << INT0);  // Interrupt on.

  if (rtc_lost_power()) {
    rtc_reset();
  }
}

static void motor_tick(uint16_t time) {
  if (time % 2) {
    motor_a();
  } else {
    motor_b();
  }
  _delay_ms(500);
}

static uint8_t is_manual_tick() {
  uint16_t milliseconds = 0;
  while (milliseconds++ < 500) {
    if (IS_INT_PIN_HIGH) {
      return 0;
    }
    _delay_us(1000);
  }
  return 1;
}

static void rtc_tick() {
  const uint16_t last_set_time = rtc_get_alarm1();
  const uint16_t current_time = rtc_get_time();
  uint16_t lack_minutes;
  if (last_set_time <= current_time) {
    lack_minutes = current_time - last_set_time;
  } else {
    lack_minutes = current_time + 12 * 60 - last_set_time;
  }

  uint16_t time = last_set_time;
  for (int i = 0; i < lack_minutes; i++) {
    time = ((time + 1) % 720);
    rtc_set_alarm1(time);
    motor_tick(time);
  }
  motor_off();
}

static void manual_tick() {
  uint16_t time = rtc_get_time();
  while (!IS_INT_PIN_HIGH) {
    time = ((time + 1) % 720);
    rtc_clear_alarm2();
    rtc_set_time(time);
    rtc_set_alarm1(time);
    motor_tick(time);
  }
  motor_off();
}

static void loop() {
  rtc_clear_alarm2();
  if (is_manual_tick()) {
    manual_tick();
  } else {
    rtc_tick();
  }
}

ISR(INT0_vect) {}

int main() {
  setup();
  set_sleep_mode(SLEEP_MODE_PWR_DOWN);
  sleep_enable();

  for (;;) {
    cli();
    loop();
    sei();
    if (IS_INT_PIN_HIGH) {
      sleep_cpu();
    }
  }
  return 0;
}
