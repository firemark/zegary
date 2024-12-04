
pkp.o:     file format elf32-avr


Disassembly of section .text:

00000000 <__vectors>:
   0:	09 c0       	rjmp	.+18     	; 0x14 <__ctors_end>
   2:	ff c0       	rjmp	.+510    	; 0x202 <__vector_1>
   4:	18 c0       	rjmp	.+48     	; 0x36 <__bad_interrupt>
   6:	17 c0       	rjmp	.+46     	; 0x36 <__bad_interrupt>
   8:	16 c0       	rjmp	.+44     	; 0x36 <__bad_interrupt>
   a:	15 c0       	rjmp	.+42     	; 0x36 <__bad_interrupt>
   c:	14 c0       	rjmp	.+40     	; 0x36 <__bad_interrupt>
   e:	13 c0       	rjmp	.+38     	; 0x36 <__bad_interrupt>
  10:	12 c0       	rjmp	.+36     	; 0x36 <__bad_interrupt>
  12:	11 c0       	rjmp	.+34     	; 0x36 <__bad_interrupt>

00000014 <__ctors_end>:
  14:	11 24       	eor	r1, r1
  16:	1f be       	out	0x3f, r1	; 63
  18:	cf e9       	ldi	r28, 0x9F	; 159
  1a:	cd bf       	out	0x3d, r28	; 61

0000001c <__do_copy_data>:
  1c:	10 e0       	ldi	r17, 0x00	; 0
  1e:	a0 e6       	ldi	r26, 0x60	; 96
  20:	b0 e0       	ldi	r27, 0x00	; 0
  22:	e2 eb       	ldi	r30, 0xB2	; 178
  24:	f3 e0       	ldi	r31, 0x03	; 3
  26:	02 c0       	rjmp	.+4      	; 0x2c <__do_copy_data+0x10>
  28:	05 90       	lpm	r0, Z+
  2a:	0d 92       	st	X+, r0
  2c:	a6 37       	cpi	r26, 0x76	; 118
  2e:	b1 07       	cpc	r27, r17
  30:	d9 f7       	brne	.-10     	; 0x28 <__do_copy_data+0xc>
  32:	f1 d0       	rcall	.+482    	; 0x216 <main>
  34:	bc c1       	rjmp	.+888    	; 0x3ae <_exit>

00000036 <__bad_interrupt>:
  36:	e4 cf       	rjmp	.-56     	; 0x0 <__vectors>

00000038 <i2c_write_addr.constprop.2>:
  38:	c0 98       	cbi	0x18, 0	; 24
  3a:	87 e0       	ldi	r24, 0x07	; 7
  3c:	98 e6       	ldi	r25, 0x68	; 104
  3e:	c2 98       	cbi	0x18, 2	; 24
  40:	96 ff       	sbrs	r25, 6
  42:	02 c0       	rjmp	.+4      	; 0x48 <__DATA_REGION_LENGTH__+0x8>
  44:	c0 9a       	sbi	0x18, 0	; 24
  46:	01 c0       	rjmp	.+2      	; 0x4a <__DATA_REGION_LENGTH__+0xa>
  48:	c0 98       	cbi	0x18, 0	; 24
  4a:	c2 9a       	sbi	0x18, 2	; 24
  4c:	99 0f       	add	r25, r25
  4e:	81 50       	subi	r24, 0x01	; 1
  50:	b1 f7       	brne	.-20     	; 0x3e <__SP_L__+0x1>
  52:	08 95       	ret

00000054 <_rtc_decode>:
  54:	28 2f       	mov	r18, r24
  56:	36 2f       	mov	r19, r22
  58:	64 fb       	bst	r22, 4
  5a:	88 27       	eor	r24, r24
  5c:	80 f9       	bld	r24, 0
  5e:	90 e0       	ldi	r25, 0x00	; 0
  60:	6a e0       	ldi	r22, 0x0A	; 10
  62:	70 e0       	ldi	r23, 0x00	; 0
  64:	73 d1       	rcall	.+742    	; 0x34c <__mulhi3>
  66:	3f 70       	andi	r19, 0x0F	; 15
  68:	83 0f       	add	r24, r19
  6a:	91 1d       	adc	r25, r1
  6c:	01 97       	sbiw	r24, 0x01	; 1
  6e:	6c e0       	ldi	r22, 0x0C	; 12
  70:	70 e0       	ldi	r23, 0x00	; 0
  72:	89 d1       	rcall	.+786    	; 0x386 <__udivmodhi4>
  74:	6c e3       	ldi	r22, 0x3C	; 60
  76:	70 e0       	ldi	r23, 0x00	; 0
  78:	69 d1       	rcall	.+722    	; 0x34c <__mulhi3>
  7a:	fc 01       	movw	r30, r24
  7c:	82 2f       	mov	r24, r18
  7e:	82 95       	swap	r24
  80:	87 70       	andi	r24, 0x07	; 7
  82:	90 e0       	ldi	r25, 0x00	; 0
  84:	6a e0       	ldi	r22, 0x0A	; 10
  86:	70 e0       	ldi	r23, 0x00	; 0
  88:	61 d1       	rcall	.+706    	; 0x34c <__mulhi3>
  8a:	2f 70       	andi	r18, 0x0F	; 15
  8c:	82 0f       	add	r24, r18
  8e:	91 1d       	adc	r25, r1
  90:	6c e3       	ldi	r22, 0x3C	; 60
  92:	70 e0       	ldi	r23, 0x00	; 0
  94:	78 d1       	rcall	.+752    	; 0x386 <__udivmodhi4>
  96:	8e 0f       	add	r24, r30
  98:	9f 1f       	adc	r25, r31
  9a:	08 95       	ret

0000009c <motor_b>:
  9c:	c4 98       	cbi	0x18, 4	; 24
  9e:	c3 9a       	sbi	0x18, 3	; 24
  a0:	08 95       	ret

000000a2 <motor_a>:
  a2:	c3 98       	cbi	0x18, 3	; 24
  a4:	c4 9a       	sbi	0x18, 4	; 24
  a6:	08 95       	ret

000000a8 <i2c_finish>:
  a8:	c0 98       	cbi	0x18, 0	; 24
  aa:	c2 9a       	sbi	0x18, 2	; 24
  ac:	00 00       	nop
  ae:	00 00       	nop
  b0:	00 00       	nop
  b2:	c0 9a       	sbi	0x18, 0	; 24
  b4:	08 95       	ret

000000b6 <i2c_read_ack>:
  b6:	c2 98       	cbi	0x18, 2	; 24
  b8:	b8 98       	cbi	0x17, 0	; 23
  ba:	c0 9a       	sbi	0x18, 0	; 24
  bc:	c2 9a       	sbi	0x18, 2	; 24
  be:	00 00       	nop
  c0:	00 00       	nop
  c2:	86 b3       	in	r24, 0x16	; 22
  c4:	c2 98       	cbi	0x18, 2	; 24
  c6:	81 70       	andi	r24, 0x01	; 1
  c8:	08 95       	ret

000000ca <i2c_write.constprop.1>:
  ca:	ef 92       	push	r14
  cc:	ff 92       	push	r15
  ce:	0f 93       	push	r16
  d0:	1f 93       	push	r17
  d2:	cf 93       	push	r28
  d4:	df 93       	push	r29
  d6:	08 2f       	mov	r16, r24
  d8:	e9 2e       	mov	r14, r25
  da:	f6 2e       	mov	r15, r22
  dc:	ad df       	rcall	.-166    	; 0x38 <i2c_write_addr.constprop.2>
  de:	c2 98       	cbi	0x18, 2	; 24
  e0:	c0 98       	cbi	0x18, 0	; 24
  e2:	00 00       	nop
  e4:	00 00       	nop
  e6:	c2 9a       	sbi	0x18, 2	; 24
  e8:	e6 df       	rcall	.-52     	; 0xb6 <i2c_read_ack>
  ea:	18 2f       	mov	r17, r24
  ec:	b8 9a       	sbi	0x17, 0	; 23
  ee:	c0 2f       	mov	r28, r16
  f0:	de 2d       	mov	r29, r14
  f2:	ce 01       	movw	r24, r28
  f4:	8f 0d       	add	r24, r15
  f6:	91 1d       	adc	r25, r1
  f8:	7c 01       	movw	r14, r24
  fa:	0f c0       	rjmp	.+30     	; 0x11a <i2c_write.constprop.1+0x50>
  fc:	99 91       	ld	r25, Y+
  fe:	88 e0       	ldi	r24, 0x08	; 8
 100:	c2 98       	cbi	0x18, 2	; 24
 102:	97 ff       	sbrs	r25, 7
 104:	02 c0       	rjmp	.+4      	; 0x10a <i2c_write.constprop.1+0x40>
 106:	c0 9a       	sbi	0x18, 0	; 24
 108:	01 c0       	rjmp	.+2      	; 0x10c <i2c_write.constprop.1+0x42>
 10a:	c0 98       	cbi	0x18, 0	; 24
 10c:	c2 9a       	sbi	0x18, 2	; 24
 10e:	99 0f       	add	r25, r25
 110:	81 50       	subi	r24, 0x01	; 1
 112:	b1 f7       	brne	.-20     	; 0x100 <i2c_write.constprop.1+0x36>
 114:	d0 df       	rcall	.-96     	; 0xb6 <i2c_read_ack>
 116:	18 2b       	or	r17, r24
 118:	b8 9a       	sbi	0x17, 0	; 23
 11a:	ec 16       	cp	r14, r28
 11c:	fd 06       	cpc	r15, r29
 11e:	71 f7       	brne	.-36     	; 0xfc <i2c_write.constprop.1+0x32>
 120:	c3 df       	rcall	.-122    	; 0xa8 <i2c_finish>
 122:	81 2f       	mov	r24, r17
 124:	df 91       	pop	r29
 126:	cf 91       	pop	r28
 128:	1f 91       	pop	r17
 12a:	0f 91       	pop	r16
 12c:	ff 90       	pop	r15
 12e:	ef 90       	pop	r14
 130:	08 95       	ret

00000132 <_rtc_write>:
 132:	cf 93       	push	r28
 134:	df 93       	push	r29
 136:	00 d0       	rcall	.+0      	; 0x138 <_rtc_write+0x6>
 138:	cd b7       	in	r28, 0x3d	; 61
 13a:	dd 27       	eor	r29, r29
 13c:	89 83       	std	Y+1, r24	; 0x01
 13e:	6a 83       	std	Y+2, r22	; 0x02
 140:	62 e0       	ldi	r22, 0x02	; 2
 142:	ce 01       	movw	r24, r28
 144:	01 96       	adiw	r24, 0x01	; 1
 146:	c1 df       	rcall	.-126    	; 0xca <i2c_write.constprop.1>
 148:	ce 5f       	subi	r28, 0xFE	; 254
 14a:	cd bf       	out	0x3d, r28	; 61
 14c:	df 91       	pop	r29
 14e:	cf 91       	pop	r28
 150:	08 95       	ret

00000152 <rtc_set_alarm1>:
 152:	0f 93       	push	r16
 154:	1f 93       	push	r17
 156:	cf 93       	push	r28
 158:	6c e3       	ldi	r22, 0x3C	; 60
 15a:	70 e0       	ldi	r23, 0x00	; 0
 15c:	14 d1       	rcall	.+552    	; 0x386 <__udivmodhi4>
 15e:	8b 01       	movw	r16, r22
 160:	ca e0       	ldi	r28, 0x0A	; 10
 162:	6c 2f       	mov	r22, r28
 164:	04 d1       	rcall	.+520    	; 0x36e <__udivmodqi4>
 166:	68 2f       	mov	r22, r24
 168:	62 95       	swap	r22
 16a:	60 7f       	andi	r22, 0xF0	; 240
 16c:	69 2b       	or	r22, r25
 16e:	88 e0       	ldi	r24, 0x08	; 8
 170:	e0 df       	rcall	.-64     	; 0x132 <_rtc_write>
 172:	c8 01       	movw	r24, r16
 174:	6c e0       	ldi	r22, 0x0C	; 12
 176:	70 e0       	ldi	r23, 0x00	; 0
 178:	06 d1       	rcall	.+524    	; 0x386 <__udivmodhi4>
 17a:	8f 5f       	subi	r24, 0xFF	; 255
 17c:	6c 2f       	mov	r22, r28
 17e:	f7 d0       	rcall	.+494    	; 0x36e <__udivmodqi4>
 180:	90 64       	ori	r25, 0x40	; 64
 182:	68 2f       	mov	r22, r24
 184:	62 95       	swap	r22
 186:	60 7f       	andi	r22, 0xF0	; 240
 188:	69 2b       	or	r22, r25
 18a:	89 e0       	ldi	r24, 0x09	; 9
 18c:	cf 91       	pop	r28
 18e:	1f 91       	pop	r17
 190:	0f 91       	pop	r16
 192:	cf cf       	rjmp	.-98     	; 0x132 <_rtc_write>

00000194 <_rtc_read>:
 194:	1f 93       	push	r17
 196:	cf 93       	push	r28
 198:	df 93       	push	r29
 19a:	1f 92       	push	r1
 19c:	cd b7       	in	r28, 0x3d	; 61
 19e:	dd 27       	eor	r29, r29
 1a0:	89 83       	std	Y+1, r24	; 0x01
 1a2:	61 e0       	ldi	r22, 0x01	; 1
 1a4:	ce 01       	movw	r24, r28
 1a6:	01 96       	adiw	r24, 0x01	; 1
 1a8:	90 df       	rcall	.-224    	; 0xca <i2c_write.constprop.1>
 1aa:	46 df       	rcall	.-372    	; 0x38 <i2c_write_addr.constprop.2>
 1ac:	c2 98       	cbi	0x18, 2	; 24
 1ae:	c0 9a       	sbi	0x18, 0	; 24
 1b0:	c2 9a       	sbi	0x18, 2	; 24
 1b2:	81 df       	rcall	.-254    	; 0xb6 <i2c_read_ack>
 1b4:	c2 98       	cbi	0x18, 2	; 24
 1b6:	88 e0       	ldi	r24, 0x08	; 8
 1b8:	10 e0       	ldi	r17, 0x00	; 0
 1ba:	c2 9a       	sbi	0x18, 2	; 24
 1bc:	11 0f       	add	r17, r17
 1be:	b0 99       	sbic	0x16, 0	; 22
 1c0:	11 60       	ori	r17, 0x01	; 1
 1c2:	c2 98       	cbi	0x18, 2	; 24
 1c4:	81 50       	subi	r24, 0x01	; 1
 1c6:	c9 f7       	brne	.-14     	; 0x1ba <_rtc_read+0x26>
 1c8:	b8 9a       	sbi	0x17, 0	; 23
 1ca:	c0 9a       	sbi	0x18, 0	; 24
 1cc:	c2 9a       	sbi	0x18, 2	; 24
 1ce:	00 00       	nop
 1d0:	00 00       	nop
 1d2:	c2 98       	cbi	0x18, 2	; 24
 1d4:	69 df       	rcall	.-302    	; 0xa8 <i2c_finish>
 1d6:	81 2f       	mov	r24, r17
 1d8:	0f 90       	pop	r0
 1da:	df 91       	pop	r29
 1dc:	cf 91       	pop	r28
 1de:	1f 91       	pop	r17
 1e0:	08 95       	ret

000001e2 <rtc_clear_alarm2>:
 1e2:	8f e0       	ldi	r24, 0x0F	; 15
 1e4:	d7 df       	rcall	.-82     	; 0x194 <_rtc_read>
 1e6:	68 2f       	mov	r22, r24
 1e8:	6d 7f       	andi	r22, 0xFD	; 253
 1ea:	8f e0       	ldi	r24, 0x0F	; 15
 1ec:	a2 cf       	rjmp	.-188    	; 0x132 <_rtc_write>

000001ee <rtc_get_time>:
 1ee:	cf 93       	push	r28
 1f0:	81 e0       	ldi	r24, 0x01	; 1
 1f2:	d0 df       	rcall	.-96     	; 0x194 <_rtc_read>
 1f4:	c8 2f       	mov	r28, r24
 1f6:	82 e0       	ldi	r24, 0x02	; 2
 1f8:	cd df       	rcall	.-102    	; 0x194 <_rtc_read>
 1fa:	68 2f       	mov	r22, r24
 1fc:	8c 2f       	mov	r24, r28
 1fe:	cf 91       	pop	r28
 200:	29 cf       	rjmp	.-430    	; 0x54 <_rtc_decode>

00000202 <__vector_1>:
 202:	1f 92       	push	r1
 204:	0f 92       	push	r0
 206:	0f b6       	in	r0, 0x3f	; 63
 208:	0f 92       	push	r0
 20a:	11 24       	eor	r1, r1
 20c:	0f 90       	pop	r0
 20e:	0f be       	out	0x3f, r0	; 63
 210:	0f 90       	pop	r0
 212:	1f 90       	pop	r1
 214:	18 95       	reti

00000216 <main>:
 216:	87 e0       	ldi	r24, 0x07	; 7
 218:	88 bb       	out	0x18, r24	; 24
 21a:	8d e1       	ldi	r24, 0x1D	; 29
 21c:	87 bb       	out	0x17, r24	; 23
 21e:	80 e2       	ldi	r24, 0x20	; 32
 220:	85 bf       	out	0x35, r24	; 53
 222:	80 e4       	ldi	r24, 0x40	; 64
 224:	8b bf       	out	0x3b, r24	; 59
 226:	8f e0       	ldi	r24, 0x0F	; 15
 228:	b5 df       	rcall	.-150    	; 0x194 <_rtc_read>
 22a:	87 fd       	sbrc	r24, 7
 22c:	11 c0       	rjmp	.+34     	; 0x250 <main+0x3a>
 22e:	85 b7       	in	r24, 0x35	; 53
 230:	87 7e       	andi	r24, 0xE7	; 231
 232:	80 61       	ori	r24, 0x10	; 16
 234:	85 bf       	out	0x35, r24	; 53
 236:	85 b7       	in	r24, 0x35	; 53
 238:	80 62       	ori	r24, 0x20	; 32
 23a:	85 bf       	out	0x35, r24	; 53
 23c:	80 ed       	ldi	r24, 0xD0	; 208
 23e:	e8 2e       	mov	r14, r24
 240:	82 e0       	ldi	r24, 0x02	; 2
 242:	f8 2e       	mov	r15, r24
 244:	9c e3       	ldi	r25, 0x3C	; 60
 246:	c9 2e       	mov	r12, r25
 248:	d1 2c       	mov	r13, r1
 24a:	2a e0       	ldi	r18, 0x0A	; 10
 24c:	b2 2e       	mov	r11, r18
 24e:	0b c0       	rjmp	.+22     	; 0x266 <main+0x50>
 250:	c0 e6       	ldi	r28, 0x60	; 96
 252:	d0 e0       	ldi	r29, 0x00	; 0
 254:	69 81       	ldd	r22, Y+1	; 0x01
 256:	88 81       	ld	r24, Y
 258:	6c df       	rcall	.-296    	; 0x132 <_rtc_write>
 25a:	22 96       	adiw	r28, 0x02	; 2
 25c:	20 e0       	ldi	r18, 0x00	; 0
 25e:	c6 37       	cpi	r28, 0x76	; 118
 260:	d2 07       	cpc	r29, r18
 262:	c1 f7       	brne	.-16     	; 0x254 <main+0x3e>
 264:	e4 cf       	rjmp	.-56     	; 0x22e <main+0x18>
 266:	f8 94       	cli
 268:	bc df       	rcall	.-136    	; 0x1e2 <rtc_clear_alarm2>
 26a:	85 ef       	ldi	r24, 0xF5	; 245
 26c:	91 e0       	ldi	r25, 0x01	; 1
 26e:	06 c0       	rjmp	.+12     	; 0x27c <main+0x66>
 270:	b1 99       	sbic	0x16, 1	; 22
 272:	5e c0       	rjmp	.+188    	; 0x330 <main+0x11a>
 274:	2a e2       	ldi	r18, 0x2A	; 42
 276:	2a 95       	dec	r18
 278:	f1 f7       	brne	.-4      	; 0x276 <main+0x60>
 27a:	00 c0       	rjmp	.+0      	; 0x27c <main+0x66>
 27c:	01 97       	sbiw	r24, 0x01	; 1
 27e:	c1 f7       	brne	.-16     	; 0x270 <main+0x5a>
 280:	54 c0       	rjmp	.+168    	; 0x32a <main+0x114>
 282:	ce 01       	movw	r24, r28
 284:	01 96       	adiw	r24, 0x01	; 1
 286:	b7 01       	movw	r22, r14
 288:	7e d0       	rcall	.+252    	; 0x386 <__udivmodhi4>
 28a:	ec 01       	movw	r28, r24
 28c:	aa df       	rcall	.-172    	; 0x1e2 <rtc_clear_alarm2>
 28e:	ce 01       	movw	r24, r28
 290:	b6 01       	movw	r22, r12
 292:	79 d0       	rcall	.+242    	; 0x386 <__udivmodhi4>
 294:	16 2f       	mov	r17, r22
 296:	6b 2d       	mov	r22, r11
 298:	6a d0       	rcall	.+212    	; 0x36e <__udivmodqi4>
 29a:	68 2f       	mov	r22, r24
 29c:	62 95       	swap	r22
 29e:	60 7f       	andi	r22, 0xF0	; 240
 2a0:	69 2b       	or	r22, r25
 2a2:	81 e0       	ldi	r24, 0x01	; 1
 2a4:	46 df       	rcall	.-372    	; 0x132 <_rtc_write>
 2a6:	81 e0       	ldi	r24, 0x01	; 1
 2a8:	81 0f       	add	r24, r17
 2aa:	6b 2d       	mov	r22, r11
 2ac:	60 d0       	rcall	.+192    	; 0x36e <__udivmodqi4>
 2ae:	90 64       	ori	r25, 0x40	; 64
 2b0:	68 2f       	mov	r22, r24
 2b2:	62 95       	swap	r22
 2b4:	60 7f       	andi	r22, 0xF0	; 240
 2b6:	69 2b       	or	r22, r25
 2b8:	82 e0       	ldi	r24, 0x02	; 2
 2ba:	3b df       	rcall	.-394    	; 0x132 <_rtc_write>
 2bc:	ce 01       	movw	r24, r28
 2be:	49 df       	rcall	.-366    	; 0x152 <rtc_set_alarm1>
 2c0:	c0 ff       	sbrs	r28, 0
 2c2:	02 c0       	rjmp	.+4      	; 0x2c8 <main+0xb2>
 2c4:	ee de       	rcall	.-548    	; 0xa2 <motor_a>
 2c6:	01 c0       	rjmp	.+2      	; 0x2ca <main+0xb4>
 2c8:	e9 de       	rcall	.-558    	; 0x9c <motor_b>
 2ca:	8f e7       	ldi	r24, 0x7F	; 127
 2cc:	9e e3       	ldi	r25, 0x3E	; 62
 2ce:	01 97       	sbiw	r24, 0x01	; 1
 2d0:	f1 f7       	brne	.-4      	; 0x2ce <main+0xb8>
 2d2:	00 c0       	rjmp	.+0      	; 0x2d4 <main+0xbe>
 2d4:	00 00       	nop
 2d6:	b1 9b       	sbis	0x16, 1	; 22
 2d8:	d4 cf       	rjmp	.-88     	; 0x282 <main+0x6c>
 2da:	1f c0       	rjmp	.+62     	; 0x31a <main+0x104>
 2dc:	80 53       	subi	r24, 0x30	; 48
 2de:	9d 4f       	sbci	r25, 0xFD	; 253
 2e0:	8c 01       	movw	r16, r24
 2e2:	0c 1b       	sub	r16, r28
 2e4:	1d 0b       	sbc	r17, r29
 2e6:	81 2c       	mov	r8, r1
 2e8:	91 2c       	mov	r9, r1
 2ea:	14 c0       	rjmp	.+40     	; 0x314 <main+0xfe>
 2ec:	ce 01       	movw	r24, r28
 2ee:	01 96       	adiw	r24, 0x01	; 1
 2f0:	b7 01       	movw	r22, r14
 2f2:	49 d0       	rcall	.+146    	; 0x386 <__udivmodhi4>
 2f4:	ec 01       	movw	r28, r24
 2f6:	2d df       	rcall	.-422    	; 0x152 <rtc_set_alarm1>
 2f8:	c0 ff       	sbrs	r28, 0
 2fa:	02 c0       	rjmp	.+4      	; 0x300 <main+0xea>
 2fc:	d2 de       	rcall	.-604    	; 0xa2 <motor_a>
 2fe:	01 c0       	rjmp	.+2      	; 0x302 <main+0xec>
 300:	cd de       	rcall	.-614    	; 0x9c <motor_b>
 302:	8f e7       	ldi	r24, 0x7F	; 127
 304:	9e e3       	ldi	r25, 0x3E	; 62
 306:	01 97       	sbiw	r24, 0x01	; 1
 308:	f1 f7       	brne	.-4      	; 0x306 <main+0xf0>
 30a:	00 c0       	rjmp	.+0      	; 0x30c <main+0xf6>
 30c:	00 00       	nop
 30e:	9f ef       	ldi	r25, 0xFF	; 255
 310:	89 1a       	sub	r8, r25
 312:	99 0a       	sbc	r9, r25
 314:	08 15       	cp	r16, r8
 316:	19 05       	cpc	r17, r9
 318:	49 f7       	brne	.-46     	; 0x2ec <main+0xd6>
 31a:	88 b3       	in	r24, 0x18	; 24
 31c:	87 7e       	andi	r24, 0xE7	; 231
 31e:	88 bb       	out	0x18, r24	; 24
 320:	78 94       	sei
 322:	b1 9b       	sbis	0x16, 1	; 22
 324:	a0 cf       	rjmp	.-192    	; 0x266 <main+0x50>
 326:	88 95       	sleep
 328:	9e cf       	rjmp	.-196    	; 0x266 <main+0x50>
 32a:	61 df       	rcall	.-318    	; 0x1ee <rtc_get_time>
 32c:	ec 01       	movw	r28, r24
 32e:	d3 cf       	rjmp	.-90     	; 0x2d6 <main+0xc0>
 330:	88 e0       	ldi	r24, 0x08	; 8
 332:	30 df       	rcall	.-416    	; 0x194 <_rtc_read>
 334:	c8 2f       	mov	r28, r24
 336:	89 e0       	ldi	r24, 0x09	; 9
 338:	2d df       	rcall	.-422    	; 0x194 <_rtc_read>
 33a:	68 2f       	mov	r22, r24
 33c:	8c 2f       	mov	r24, r28
 33e:	8a de       	rcall	.-748    	; 0x54 <_rtc_decode>
 340:	ec 01       	movw	r28, r24
 342:	55 df       	rcall	.-342    	; 0x1ee <rtc_get_time>
 344:	8c 17       	cp	r24, r28
 346:	9d 07       	cpc	r25, r29
 348:	58 f6       	brcc	.-106    	; 0x2e0 <main+0xca>
 34a:	c8 cf       	rjmp	.-112    	; 0x2dc <main+0xc6>

0000034c <__mulhi3>:
 34c:	00 24       	eor	r0, r0
 34e:	55 27       	eor	r21, r21
 350:	04 c0       	rjmp	.+8      	; 0x35a <__mulhi3+0xe>
 352:	08 0e       	add	r0, r24
 354:	59 1f       	adc	r21, r25
 356:	88 0f       	add	r24, r24
 358:	99 1f       	adc	r25, r25
 35a:	00 97       	sbiw	r24, 0x00	; 0
 35c:	29 f0       	breq	.+10     	; 0x368 <__mulhi3+0x1c>
 35e:	76 95       	lsr	r23
 360:	67 95       	ror	r22
 362:	b8 f3       	brcs	.-18     	; 0x352 <__mulhi3+0x6>
 364:	71 05       	cpc	r23, r1
 366:	b9 f7       	brne	.-18     	; 0x356 <__mulhi3+0xa>
 368:	80 2d       	mov	r24, r0
 36a:	95 2f       	mov	r25, r21
 36c:	08 95       	ret

0000036e <__udivmodqi4>:
 36e:	99 1b       	sub	r25, r25
 370:	79 e0       	ldi	r23, 0x09	; 9
 372:	04 c0       	rjmp	.+8      	; 0x37c <__udivmodqi4_ep>

00000374 <__udivmodqi4_loop>:
 374:	99 1f       	adc	r25, r25
 376:	96 17       	cp	r25, r22
 378:	08 f0       	brcs	.+2      	; 0x37c <__udivmodqi4_ep>
 37a:	96 1b       	sub	r25, r22

0000037c <__udivmodqi4_ep>:
 37c:	88 1f       	adc	r24, r24
 37e:	7a 95       	dec	r23
 380:	c9 f7       	brne	.-14     	; 0x374 <__udivmodqi4_loop>
 382:	80 95       	com	r24
 384:	08 95       	ret

00000386 <__udivmodhi4>:
 386:	aa 1b       	sub	r26, r26
 388:	bb 1b       	sub	r27, r27
 38a:	51 e1       	ldi	r21, 0x11	; 17
 38c:	07 c0       	rjmp	.+14     	; 0x39c <__udivmodhi4_ep>

0000038e <__udivmodhi4_loop>:
 38e:	aa 1f       	adc	r26, r26
 390:	bb 1f       	adc	r27, r27
 392:	a6 17       	cp	r26, r22
 394:	b7 07       	cpc	r27, r23
 396:	10 f0       	brcs	.+4      	; 0x39c <__udivmodhi4_ep>
 398:	a6 1b       	sub	r26, r22
 39a:	b7 0b       	sbc	r27, r23

0000039c <__udivmodhi4_ep>:
 39c:	88 1f       	adc	r24, r24
 39e:	99 1f       	adc	r25, r25
 3a0:	5a 95       	dec	r21
 3a2:	a9 f7       	brne	.-22     	; 0x38e <__udivmodhi4_loop>
 3a4:	80 95       	com	r24
 3a6:	90 95       	com	r25
 3a8:	bc 01       	movw	r22, r24
 3aa:	cd 01       	movw	r24, r26
 3ac:	08 95       	ret

000003ae <_exit>:
 3ae:	f8 94       	cli

000003b0 <__stop_program>:
 3b0:	ff cf       	rjmp	.-2      	; 0x3b0 <__stop_program>

Disassembly of section .data:

00800060 <__data_start>:
  800060:	00 00       	nop
  800062:	01 00       	.word	0x0001	; ????
  800064:	02 52       	subi	r16, 0x22	; 34
  800066:	07 00       	.word	0x0007	; ????
  800068:	08 00       	.word	0x0008	; ????
  80006a:	09 52       	subi	r16, 0x29	; 41
  80006c:	0b 80       	ldd	r0, Y+3	; 0x03
  80006e:	0c d2       	rcall	.+1048   	; 0x800488 <__data_end+0x412>
  800070:	0d 81       	ldd	r16, Y+5	; 0x05
  800072:	0e 06       	cpc	r0, r30
  800074:	0f 00       	.word	0x000f	; ????
