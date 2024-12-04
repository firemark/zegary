#include "rtc.h"
#include "rtc_internal.h"
#include "i2c.h"

const uint8_t RESET_DATA[][2] = {
    // set time to 12:00:00AM (12h mode because of clock face).
    {TIME_SECONDS_ADDR, _rtc_60_encode(0)},
    {TIME_MINUTES_ADDR, _rtc_60_encode(0)},
    {TIME_HOURS_ADDR, _rtc_12_encode(12)},

    // set alarm1 {as last time) to 12:00:00AM
    {ALARM1_SECONDS_ADDR, _rtc_60_encode(0)},
    {ALARM1_MINUTES_ADDR, _rtc_60_encode(0)},
    {ALARM1_HOURS_ADDR, _rtc_12_encode(12)},

    // set alarm2 to 12:01PM + ALARM every minute
    {ALARM2_MINUTES_ADDR, ALARM_FLAG | _rtc_60_encode(0)},
    {ALARM2_HOURS_ADDR, ALARM_FLAG | _rtc_12_encode(12)},
    {ALARM2_DAYS_ADDR, ALARM_FLAG | 1},

    {CONTROL_ADDR, 0b00000110},  // Set INT pin + set alarm2.
    {STATUS_ADDR, 0b00000000},   // Reset oscillator stop flag.
};

static void _rtc_write(uint8_t addr, uint8_t data) {
  uint8_t buff[] = {addr, data};
  i2c_write(RTC_ADDR, buff, 2);
}

static uint8_t _rtc_read(uint8_t addr) {
  uint8_t data;
  i2c_write(RTC_ADDR, &addr, 1);
  i2c_read(RTC_ADDR, &data, 1);
  return data;
}

/// @return minutes from 0 to 719.
static uint16_t _rtc_decode(uint8_t raw_minutes, uint8_t raw_hours) {
  uint16_t minutes = _rtc_60_decode(raw_minutes);
  uint16_t hours = _rtc_12_decode(raw_hours);
  return ((hours - 1) % 12) * 60 + (minutes % 60);
}

void rtc_reset(void) {
  uint8_t i;
  for (i = 0; i < sizeof(RESET_DATA) / sizeof(RESET_DATA[0]); i++) {
    _rtc_write(RESET_DATA[i][0], RESET_DATA[i][1]);
  }
}

uint8_t rtc_lost_power(void) {
  uint8_t status = _rtc_read(STATUS_ADDR);
  return status & RTC_STATUS_FLAG;
}

uint16_t rtc_get_time(void) {
  uint16_t minutes = _rtc_read(TIME_MINUTES_ADDR);
  uint16_t hours = _rtc_read(TIME_HOURS_ADDR);
  return _rtc_decode(minutes, hours);
}

uint16_t rtc_get_alarm1(void) {
  uint16_t minutes = _rtc_read(ALARM1_MINUTES_ADDR);
  uint16_t hours = _rtc_read(ALARM1_HOURS_ADDR);
  return _rtc_decode(minutes, hours);
}

static inline uint8_t _time_to_minutes(uint16_t time) {
  return time % 60;
}

static inline uint8_t _time_to_hours(uint16_t time) {
  return (((time / 60) % 12) + 1);
}

void rtc_set_time(uint16_t time) {
  _rtc_write(TIME_MINUTES_ADDR, _rtc_60_encode(_time_to_minutes(time)));
  _rtc_write(TIME_HOURS_ADDR, _rtc_12_encode(_time_to_hours(time)));
}

void rtc_set_alarm1(uint16_t time) {
  _rtc_write(ALARM1_MINUTES_ADDR, _rtc_60_encode(_time_to_minutes(time)));
  _rtc_write(ALARM1_HOURS_ADDR, _rtc_12_encode(_time_to_hours(time)));
}

void rtc_clear_alarm2(void) {
  _rtc_write(STATUS_ADDR, _rtc_read(STATUS_ADDR) & ~0b10);
}