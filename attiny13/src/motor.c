#include "motor.h"
#include <avr/io.h>

uint8_t motor_ddr_setup(void) {
  return (1 << DDB3) | (1 << DDB4);
}

uint8_t motor_port_setup(void) {
  return 0;
}

void motor_a(void) {
  PORTB &= ~(1 << PB3);
  PORTB |= (1 << PB4);
}

void motor_b(void) {
  PORTB &= ~(1 << PB4);
  PORTB |= (1 << PB3);
}

void motor_off(void) {
  PORTB &= ~((1 << PB3) | (1 << PB4));
}