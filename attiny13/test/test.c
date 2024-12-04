#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

#include "avr_ioport.h"
#include "sim_avr.h"
#include "sim_elf.h"
#include "sim_time.h"

#include "rtc_internal.h"

#define PORTB AVR_IOCTL_IOPORT_GETIRQ('B')
#define GETPORT(ind) avr_io_getirq(avr, PORTB, ind)

typedef struct {
  int bitcount;
  uint8_t addr;
  uint8_t data[8];
  uint8_t size;
  uint8_t last_reg;
  char addr_readed;
  char readwrite;
  char start;
  uint8_t request[256];
  uint8_t response[256];
} twi_data_t;

typedef struct {
  char name;
  int count;
} motor_t;

avr_t* avr = NULL;
avr_irq_t* irq = NULL;
motor_t motor_a = {'A', 0};
motor_t motor_b = {'B', 0};
twi_data_t twi_data = {0};

static void motor_hook(struct avr_irq_t* irq, uint32_t value, void* param) {
  motor_t* motor = param;
  if (!value) {
    return;
  }
  motor->count++;
  //   printf("MOTOR %c %d\n", motor->name, motor->count);
}

static void sda_input(uint8_t v) {
  avr_ioport_external_t io_ext;
  io_ext.name = 'B';
  io_ext.mask = (1 << 0);
  io_ext.value = v ? 1 : 0;
  avr_ioctl(avr, AVR_IOCTL_IOPORT_SET_EXTERNAL('B'), &io_ext);
}

static void int_input(uint8_t v) {
  avr_ioport_external_t io_ext;
  io_ext.name = 'B';
  io_ext.mask = (1 << 1);
  io_ext.value = v ? 1 << 1 : 0;
  avr_ioctl(avr, AVR_IOCTL_IOPORT_SET_EXTERNAL('B'), &io_ext);
}

static void sda_hook(struct avr_irq_t* irq, uint32_t sda_value, void* param) {
  static uint32_t prev_sda_value = 1;
  twi_data_t* twi = param;
  avr_irq_t* scl_irq = avr_io_getirq(avr, PORTB, IOPORT_IRQ_PIN2);
  char scl_value = scl_irq->value ? 1 : 0;
  if (scl_value) {
    if (twi->start && prev_sda_value && !sda_value) {
      twi->start = 0;
      twi->addr = 0;
      twi->size = 0;
      twi->readwrite = 0;
      twi->addr_readed = 0;
      twi->bitcount = 0;
      for (int i = 0; i < 8; i++) {
        twi->data[i] = 0;
      }
      sda_input(1);
    }
    if (!twi->start && !prev_sda_value && sda_value) {
      //   printf("ADDR %02x DATA ", twi->addr);
      //   for (int i = 0; i < twi->size; i++) {
      //     printf("%02x", twi->data[i]);
      //   }
      //   printf("; %c\n", twi->readwrite ? 'R' : 'W');

      if (!twi->readwrite && twi->size == 1) {
        twi->last_reg = twi->data[0];
      }
      if (!twi->readwrite && twi->size == 2) {
        twi->response[twi->data[0]] = twi->data[1];
      }
      twi->start = 1;
    }
  }
  prev_sda_value = sda_value;
}

static void scl_hook(struct avr_irq_t* irq, uint32_t scl_value, void* param) {
  twi_data_t* twi = param;
  avr_irq_t* sda_irq = avr_io_getirq(avr, PORTB, IOPORT_IRQ_PIN0);
  if (twi->start) {
    return;
  }
  if (!scl_value) {
    if (!twi->readwrite && twi->bitcount == 8) {
      sda_input(0);
    } else if (twi->readwrite && twi->bitcount < 8) {
      uint8_t data = twi->request[twi->last_reg];
      uint8_t mask = 1 << (7 - twi->bitcount);
      sda_input(data & mask);
    }
  } else {
    char value = sda_irq->value ? 1 : 0;
    if (twi->start && value) {
      return;
    }
    if (!twi->addr_readed) {  // Addr
      switch (twi->bitcount) {
        case 0 ... 6: {
          twi->addr = (twi->addr << 1) | value;
          twi->bitcount++;
        } break;
        case 7: {
          twi->readwrite = value;
          twi->bitcount++;
        } break;
        case 8: {  // ACK
          twi->addr_readed = 1;
          twi->bitcount = 0;
        } break;
      }
    } else if (!twi->readwrite) {  // Write
      switch (twi->bitcount) {
        case 0 ... 7: {
          uint8_t* data = &twi->data[twi->size];
          *data = (*data << 1) | value;
          twi->bitcount++;
        } break;
        case 8: {  // ACK
          twi->size++;
          twi->bitcount = 0;
        } break;
      }
    } else {  // Read
      switch (twi->bitcount) {
        case 0 ... 7: {
          uint8_t* data = &twi->data[twi->size];
          *data = (*data << 1) | value;
          twi->bitcount++;
        } break;
        case 8: {  // ACK
          sda_input(1);
          twi->size++;
          twi->bitcount = 0;
        } break;
      }
    }
  }
}

char is_evil(int state) {
  return (state == cpu_Done) || (state == cpu_Crashed);
}

int main(int argc, char* argv[]) {
  if (argc < 6) {
    return 1;
  }
  elf_firmware_t f = {{0}};
  const char* fname = "pkp_test.o";

  //   printf("Firmware pathname is %s\n", fname);
  elf_read_firmware(fname, &f);

  //   printf("firmware %s f=%d mmcu=%s\n", fname, (int)f.frequency, f.mmcu);

  avr = avr_make_mcu_by_name(f.mmcu);
  if (!avr) {
    fprintf(stderr, "%s: AVR '%s' not known\n", argv[0], f.mmcu);
    exit(1);
  }
  avr_init(avr);
  avr_load_firmware(avr, &f);

  int current_time_h = atoi(argv[1]);
  int current_time_m = atoi(argv[2]);
  int last_time_h = atoi(argv[3]);
  int last_time_m = atoi(argv[4]);
  int motor_ticks = atoi(argv[5]);

  printf("Args: %02d:%02d %02d:%02d %d\n", current_time_h, current_time_m,
         last_time_h, last_time_m, motor_ticks);

  twi_data.start = 1;

  avr_irq_t* sda_irq = GETPORT(IOPORT_IRQ_PIN0);
  avr_irq_t* int_irq = GETPORT(IOPORT_IRQ_PIN1);

  // Pullups
  avr_raise_irq(int_irq, 1);
  avr_raise_irq(sda_irq, 1);
  avr_irq_register_notify(GETPORT(IOPORT_IRQ_PIN0), sda_hook, &twi_data);
  avr_irq_register_notify(GETPORT(IOPORT_IRQ_PIN2), scl_hook, &twi_data);
  avr_irq_register_notify(GETPORT(IOPORT_IRQ_PIN3), motor_hook, &motor_a);
  avr_irq_register_notify(GETPORT(IOPORT_IRQ_PIN4), motor_hook, &motor_b);

  twi_data.request[STATUS_ADDR] = 1 << 7;
  //   twi_data.request[0x0F] = 0;
  twi_data.request[TIME_MINUTES_ADDR] = _rtc_60_encode(current_time_m);
  twi_data.request[TIME_HOURS_ADDR] = _rtc_12_encode(current_time_h);
  twi_data.request[ALARM1_MINUTES_ADDR] = _rtc_60_encode(last_time_m);
  twi_data.request[ALARM1_HOURS_ADDR] = _rtc_12_encode(last_time_h);

  int state;
  state = cpu_Running;
  while (state != cpu_Sleeping) {
    if (is_evil(state)) {
      return 0;
    }
    state = avr_run(avr);
  }

  printf("Motor A ticks: %d\n", motor_a.count);
  printf("Motor B ticks: %d\n", motor_b.count);
  printf("Total   ticks: %d\n", motor_a.count + motor_b.count);
  if (motor_a.count + motor_b.count == motor_ticks) {
    printf("Test passed!\n");
    return 0;
  } else {
    printf("Test failed!\n");
    return 1;
  }

  //   printf("---\n");
  //   twi_data.request[0x01] = 0;
  //   twi_data.request[0x02] = 1 << 6 | 3;
  //   twi_data.request[0x08] = 0;
  //   twi_data.request[0x09] = 1 << 6 | 2;

  //   avr_cycle_count_t deadline = avr->cycle + avr_usec_to_cycles(avr, 10000l);
  //   avr_raise_irq(int_irq, 0);
  //   state = cpu_Running;
  //   while (state != cpu_Sleeping) {
  //     if (avr->cycle < deadline) {
  //       int_input(0);
  //     } else {
  //       int_input(1);
  //     }

  //     if (is_evil(state)) {
  //       return 0;
  //     }
  //     state = avr_run(avr);
  //   }
}