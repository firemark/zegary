#pragma once
#include <stdint.h>

/// @brief Resets RTC.
void rtc_reset(void);

uint8_t rtc_lost_power(void);

/// @brief Sets time in time register.
/// @param time Minutes from 0 to 719.
void rtc_set_time(uint16_t time);

/// @brief Sets time in alarm1 register.
/// @param time Minutes from 0 to 719.
void rtc_set_alarm1(uint16_t time);

/// @brief Clears interupt flag in alarm2 register.
void rtc_clear_alarm2(void);

/// @brief Returns time from time register.
/// @return Minutes from 0 to 719.
uint16_t rtc_get_time(void);

/// @brief Returns time from alarm1 register.
/// @return Minutes from 0 to 719.
uint16_t rtc_get_alarm1(void);