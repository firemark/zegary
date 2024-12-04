# --
# Copyright (c) 2018, Lukasz Marcin Podkalicki <lpodkalicki@gmail.com>
# https://github.com/lpodkalicki/attiny-onewire-library/blob/master/examples/attiny13/Makefile
# --

MCU=attiny13
FUSE_L=0x3B
FUSE_H=0xFF
F_CPU=128000
CC=avr-gcc
LD=avr-ld
OBJCOPY=avr-objcopy
OBJDUMP=avr-objdump
SIZE=avr-size
AVRDUDE=avrdude
CFLAGS =-std=c99 -Wall -g -Os
CFLAGS+=-flto -fno-reorder-blocks
CFLAGS+=-Iinclude
CFLAGS+=-mmcu=${MCU} -DF_CPU=${F_CPU}
TEST_CFLAGS =${CFLAGS}
TEST_CFLAGS+=-I/include/simavr/avr -DTEST 
TEST_CFLAGS+=-Wl,--undefined=_mmcu,--section-start=.mmcu=0x910000
TEST_CFLAGS+=-Wl,--relax,--gc-sections
TARGET=pkp

SRCS = src/main.c src/i2c.c src/motor.c src/rtc.c
TESTS = test/test.c

.PHONY: all test flash fuse clean

all:
	${CC} ${CFLAGS} -o ${TARGET}.o ${SRCS}
	${LD} -o ${TARGET}.elf ${TARGET}.o
	${OBJCOPY} -j .text -j .data -O ihex ${TARGET}.o ${TARGET}.hex
	${OBJDUMP} -j .text -j .data -j .bss -d ${TARGET}.o > ${TARGET}.s
	${SIZE} -C --mcu=${MCU} ${TARGET}.elf

test:
	${CC} ${TEST_CFLAGS} -o ${TARGET}_test.o ${SRCS}
	gcc -Wall -Iinclude -I/include/simavr ${TESTS} -lsimavr -o test.o
	./test.o 12 00 12 00 0
	./test.o 12 01 12 00 1
	./test.o 01 00 12 50 10
	./test.o 02 00 01 50 10
	./test.o 03 00 02 50 10
	./test.o 04 00 03 50 10
	./test.o 05 00 04 50 10
	./test.o 06 00 05 50 10
	./test.o 07 00 06 50 10
	./test.o 08 00 07 50 10
	./test.o 09 00 08 50 10
	./test.o 10 00 09 50 10
	./test.o 11 00 10 50 10
	./test.o 12 00 11 50 10
	./test.o 12 59 12 00 59
	./test.o 12 30 12 00 30

flash:
	${AVRDUDE} -p ${MCU} -c usbasp -U flash:w:${TARGET}.hex:i -F -P usb

fuse:
	$(AVRDUDE) -p ${MCU} -c usbasp -U hfuse:w:${FUSE_H}:m -U lfuse:w:${FUSE_L}:m

clean:
	rm -f *.c~ *.o *.elf *.hex
