
BuildModel_Seq.bin:     file format binary


Disassembly of section .data:

00000000 <.data>:
       0:	2000      	movs	r0, #0
       2:	1000      	asrs	r0, r0, #32
       4:	0043      	lsls	r3, r0, #1
       6:	0000      	movs	r0, r0
       8:	0041      	lsls	r1, r0, #1
       a:	0000      	movs	r0, r0
       c:	0041      	lsls	r1, r0, #1
       e:	0000      	movs	r0, r0
      10:	0041      	lsls	r1, r0, #1
      12:	0000      	movs	r0, r0
      14:	0041      	lsls	r1, r0, #1
      16:	0000      	movs	r0, r0
      18:	0041      	lsls	r1, r0, #1
      1a:	0000      	movs	r0, r0
      1c:	0041      	lsls	r1, r0, #1
      1e:	0000      	movs	r0, r0
      20:	0041      	lsls	r1, r0, #1
      22:	0000      	movs	r0, r0
      24:	0041      	lsls	r1, r0, #1
      26:	0000      	movs	r0, r0
      28:	0041      	lsls	r1, r0, #1
      2a:	0000      	movs	r0, r0
      2c:	0041      	lsls	r1, r0, #1
      2e:	0000      	movs	r0, r0
      30:	0041      	lsls	r1, r0, #1
      32:	0000      	movs	r0, r0
      34:	0041      	lsls	r1, r0, #1
      36:	0000      	movs	r0, r0
      38:	0041      	lsls	r1, r0, #1
      3a:	0000      	movs	r0, r0
      3c:	0041      	lsls	r1, r0, #1
      3e:	0000      	movs	r0, r0
      40:	e7fe      	b.n	0x40
      42:	480b      	ldr	r0, [pc, #44]	; (0x70)
      44:	490b      	ldr	r1, [pc, #44]	; (0x74)
      46:	4a0c      	ldr	r2, [pc, #48]	; (0x78)
      48:	1a09      	subs	r1, r1, r0
      4a:	d005      	beq.n	0x58
      4c:	7813      	ldrb	r3, [r2, #0]
      4e:	7003      	strb	r3, [r0, #0]
      50:	3201      	adds	r2, #1
      52:	3001      	adds	r0, #1
      54:	3901      	subs	r1, #1
      56:	dcf9      	bgt.n	0x4c
      58:	4808      	ldr	r0, [pc, #32]	; (0x7c)
      5a:	4909      	ldr	r1, [pc, #36]	; (0x80)
      5c:	1a09      	subs	r1, r1, r0
      5e:	d004      	beq.n	0x6a
      60:	405b      	eors	r3, r3
      62:	7003      	strb	r3, [r0, #0]
      64:	3001      	adds	r0, #1
      66:	3901      	subs	r1, #1
      68:	dcfb      	bgt.n	0x62
      6a:	f001 faf7 	bl	0x165c
      6e:	e7fe      	b.n	0x6e
      70:	0000      	movs	r0, r0
      72:	1000      	asrs	r0, r0, #32
      74:	002c      	movs	r4, r5
      76:	1000      	asrs	r0, r0, #32
      78:	1670      	asrs	r0, r6, #25
      7a:	0000      	movs	r0, r0
      7c:	0030      	movs	r0, r6
      7e:	1000      	asrs	r0, r0, #32
      80:	0030      	movs	r0, r6
      82:	1000      	asrs	r0, r0, #32
      84:	16a0      	asrs	r0, r4, #26
      86:	0000      	movs	r0, r0
      88:	f000 b878 	b.w	0x17c
      8c:	b5f0      	push	{r4, r5, r6, r7, lr}
      8e:	483a      	ldr	r0, [pc, #232]	; (0x178)
      90:	b091      	sub	sp, #68	; 0x44
      92:	f001 f889 	bl	0x11a8
      96:	2800      	cmp	r0, #0
      98:	d069      	beq.n	0x16e
      9a:	2400      	movs	r4, #0
      9c:	2500      	movs	r5, #0
      9e:	2000      	movs	r0, #0
      a0:	f001 fa38 	bl	0x1514
      a4:	f80d 0005 	strb.w	r0, [sp, r5]
      a8:	3501      	adds	r5, #1
      aa:	2d20      	cmp	r5, #32
      ac:	d1f7      	bne.n	0x9e
      ae:	2210      	movs	r2, #16
      b0:	9b06      	ldr	r3, [sp, #24]
      b2:	f88d 201b 	strb.w	r2, [sp, #27]
      b6:	f403 73f8 	and.w	r3, r3, #496	; 0x1f0
      ba:	f043 5380 	orr.w	r3, r3, #268435456	; 0x10000000
      be:	f443 6320 	orr.w	r3, r3, #2560	; 0xa00
      c2:	0a1a      	lsrs	r2, r3, #8
      c4:	f88d 2019 	strb.w	r2, [sp, #25]
      c8:	f89d 201c 	ldrb.w	r2, [sp, #28]
      cc:	f88d 3018 	strb.w	r3, [sp, #24]
      d0:	f1a2 0332 	sub.w	r3, r2, #50	; 0x32
      d4:	2b31      	cmp	r3, #49	; 0x31
      d6:	bf98      	it	ls
      d8:	2301      	movls	r3, #1
      da:	f04f 0119 	mov.w	r1, #25
      de:	bf98      	it	ls
      e0:	f88d 301d 	strbls.w	r3, [sp, #29]
      e4:	fbb2 f3f1 	udiv	r3, r2, r1
      e8:	fb01 2313 	mls	r3, r1, r3, r2
      ec:	b2db      	uxtb	r3, r3
      ee:	f1a3 020a 	sub.w	r2, r3, #10
      f2:	bf88      	it	hi
      f4:	f88d 401d 	strbhi.w	r4, [sp, #29]
      f8:	2a09      	cmp	r2, #9
      fa:	bf9c      	itt	ls
      fc:	2201      	movls	r2, #1
      fe:	f88d 201e 	strbls.w	r2, [sp, #30]
     102:	f04f 0205 	mov.w	r2, #5
     106:	fbb3 f2f2 	udiv	r2, r3, r2
     10a:	eb02 0282 	add.w	r2, r2, r2, lsl #2
     10e:	eba3 0302 	sub.w	r3, r3, r2
     112:	f1a3 0302 	sub.w	r3, r3, #2
     116:	b2db      	uxtb	r3, r3
     118:	bf88      	it	hi
     11a:	f88d 401e 	strbhi.w	r4, [sp, #30]
     11e:	2b01      	cmp	r3, #1
     120:	bf98      	it	ls
     122:	2301      	movls	r3, #1
     124:	f04f 0000 	mov.w	r0, #0
     128:	f88d 401a 	strb.w	r4, [sp, #26]
     12c:	bf94      	ite	ls
     12e:	f88d 301f 	strbls.w	r3, [sp, #31]
     132:	f88d 401f 	strbhi.w	r4, [sp, #31]
     136:	f001 f9ed 	bl	0x1514
     13a:	2500      	movs	r5, #0
     13c:	4607      	mov	r7, r0
     13e:	ae08      	add	r6, sp, #32
     140:	42bd      	cmp	r5, r7
     142:	db08      	blt.n	0x156
     144:	2500      	movs	r5, #0
     146:	5d71      	ldrb	r1, [r6, r5]
     148:	2000      	movs	r0, #0
     14a:	3501      	adds	r5, #1
     14c:	f001 f9ee 	bl	0x152c
     150:	2d20      	cmp	r5, #32
     152:	d1f8      	bne.n	0x146
     154:	e7a2      	b.n	0x9c
     156:	2300      	movs	r3, #0
     158:	f81d 2003 	ldrb.w	r2, [sp, r3]
     15c:	54f2      	strb	r2, [r6, r3]
     15e:	3301      	adds	r3, #1
     160:	2b20      	cmp	r3, #32
     162:	d1f9      	bne.n	0x158
     164:	4630      	mov	r0, r6
     166:	f000 f809 	bl	0x17c
     16a:	3501      	adds	r5, #1
     16c:	e7e8      	b.n	0x140
     16e:	f04f 30ff 	mov.w	r0, #4294967295	; 0xffffffff
     172:	b011      	add	sp, #68	; 0x44
     174:	bdf0      	pop	{r4, r5, r6, r7, pc}
     176:	bf00      	nop
     178:	0000      	movs	r0, r0
     17a:	1000      	asrs	r0, r0, #32
     17c:	e92d 0fff 	stmdb	sp!, {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp}
     180:	6801      	ldr	r1, [r0, #0]
     182:	468b      	mov	fp, r1
     184:	4682      	mov	sl, r0
     186:	6847      	ldr	r7, [r0, #4]
     188:	6883      	ldr	r3, [r0, #8]
     18a:	68c4      	ldr	r4, [r0, #12]
     18c:	6905      	ldr	r5, [r0, #16]
     18e:	6946      	ldr	r6, [r0, #20]
     190:	7f01      	ldrb	r1, [r0, #28]
     192:	2220      	movs	r2, #32
     194:	4351      	muls	r1, r2
     196:	2210      	movs	r2, #16
     198:	1889      	adds	r1, r1, r2
     19a:	4689      	mov	r9, r1
     19c:	6981      	ldr	r1, [r0, #24]
     19e:	7f42      	ldrb	r2, [r0, #29]
     1a0:	2a01      	cmp	r2, #1
     1a2:	d101      	bne.n	0x1a8
     1a4:	600f      	str	r7, [r1, #0]
     1a6:	460f      	mov	r7, r1
     1a8:	7f82      	ldrb	r2, [r0, #30]
     1aa:	2a01      	cmp	r2, #1
     1ac:	d101      	bne.n	0x1b2
     1ae:	604c      	str	r4, [r1, #4]
     1b0:	460c      	mov	r4, r1
     1b2:	7fc2      	ldrb	r2, [r0, #31]
     1b4:	2a01      	cmp	r2, #1
     1b6:	d101      	bne.n	0x1bc
     1b8:	608e      	str	r6, [r1, #8]
     1ba:	460e      	mov	r6, r1
     1bc:	bf00      	nop
     1be:	bf00      	nop
     1c0:	bf00      	nop
     1c2:	bf00      	nop
     1c4:	2050      	movs	r0, #80	; 0x50
     1c6:	0600      	lsls	r0, r0, #24
     1c8:	2101      	movs	r1, #1
     1ca:	0409      	lsls	r1, r1, #16
     1cc:	4048      	eors	r0, r1
     1ce:	213f      	movs	r1, #63	; 0x3f
     1d0:	0209      	lsls	r1, r1, #8
     1d2:	4048      	eors	r0, r1
     1d4:	21fc      	movs	r1, #252	; 0xfc
     1d6:	4048      	eors	r0, r1
     1d8:	2101      	movs	r1, #1
     1da:	6802      	ldr	r2, [r0, #0]
     1dc:	4051      	eors	r1, r2
     1de:	6001      	str	r1, [r0, #0]
     1e0:	2100      	movs	r1, #0
     1e2:	4688      	mov	r8, r1
     1e4:	4649      	mov	r1, r9
     1e6:	448f      	add	pc, r1
     1e8:	bf00      	nop
     1ea:	bf00      	nop
     1ec:	bf00      	nop
     1ee:	bf00      	nop
     1f0:	bf00      	nop
     1f2:	bf00      	nop
     1f4:	bf00      	nop
     1f6:	bf00      	nop
     1f8:	bf00      	nop
     1fa:	4659      	mov	r1, fp
     1fc:	bf00      	nop
     1fe:	bf00      	nop
     200:	bf00      	nop
     202:	bf00      	nop
     204:	bf00      	nop
     206:	4079      	eors	r1, r7
     208:	4063      	eors	r3, r4
     20a:	4075      	eors	r5, r6
     20c:	bf00      	nop
     20e:	bf00      	nop
     210:	bf00      	nop
     212:	bf00      	nop
     214:	bf00      	nop
     216:	f000 bfc0 	b.w	0x119a
     21a:	4659      	mov	r1, fp
     21c:	bf00      	nop
     21e:	bf00      	nop
     220:	bf00      	nop
     222:	bf00      	nop
     224:	bf00      	nop
     226:	4079      	eors	r1, r7
     228:	4063      	eors	r3, r4
     22a:	40b5      	lsls	r5, r6
     22c:	bf00      	nop
     22e:	bf00      	nop
     230:	bf00      	nop
     232:	bf00      	nop
     234:	bf00      	nop
     236:	f000 bfb0 	b.w	0x119a
     23a:	4659      	mov	r1, fp
     23c:	bf00      	nop
     23e:	bf00      	nop
     240:	bf00      	nop
     242:	bf00      	nop
     244:	bf00      	nop
     246:	4079      	eors	r1, r7
     248:	4063      	eors	r3, r4
     24a:	60b5      	str	r5, [r6, #8]
     24c:	bf00      	nop
     24e:	bf00      	nop
     250:	bf00      	nop
     252:	bf00      	nop
     254:	f000 bfa1 	b.w	0x119a
     258:	bf00      	nop
     25a:	4659      	mov	r1, fp
     25c:	bf00      	nop
     25e:	bf00      	nop
     260:	bf00      	nop
     262:	bf00      	nop
     264:	bf00      	nop
     266:	4079      	eors	r1, r7
     268:	4063      	eors	r3, r4
     26a:	68b5      	ldr	r5, [r6, #8]
     26c:	bf00      	nop
     26e:	bf00      	nop
     270:	bf00      	nop
     272:	bf00      	nop
     274:	f000 bf91 	b.w	0x119a
     278:	bf00      	nop
     27a:	4659      	mov	r1, fp
     27c:	bf00      	nop
     27e:	bf00      	nop
     280:	bf00      	nop
     282:	bf00      	nop
     284:	bf00      	nop
     286:	4079      	eors	r1, r7
     288:	4063      	eors	r3, r4
     28a:	4375      	muls	r5, r6
     28c:	bf00      	nop
     28e:	bf00      	nop
     290:	bf00      	nop
     292:	bf00      	nop
     294:	bf00      	nop
     296:	f000 bf80 	b.w	0x119a
     29a:	4659      	mov	r1, fp
     29c:	bf00      	nop
     29e:	bf00      	nop
     2a0:	bf00      	nop
     2a2:	bf00      	nop
     2a4:	bf00      	nop
     2a6:	4079      	eors	r1, r7
     2a8:	40a3      	lsls	r3, r4
     2aa:	4075      	eors	r5, r6
     2ac:	bf00      	nop
     2ae:	bf00      	nop
     2b0:	bf00      	nop
     2b2:	bf00      	nop
     2b4:	bf00      	nop
     2b6:	f000 bf70 	b.w	0x119a
     2ba:	4659      	mov	r1, fp
     2bc:	bf00      	nop
     2be:	bf00      	nop
     2c0:	bf00      	nop
     2c2:	bf00      	nop
     2c4:	bf00      	nop
     2c6:	4079      	eors	r1, r7
     2c8:	40a3      	lsls	r3, r4
     2ca:	40b5      	lsls	r5, r6
     2cc:	bf00      	nop
     2ce:	bf00      	nop
     2d0:	bf00      	nop
     2d2:	bf00      	nop
     2d4:	bf00      	nop
     2d6:	f000 bf60 	b.w	0x119a
     2da:	4659      	mov	r1, fp
     2dc:	bf00      	nop
     2de:	bf00      	nop
     2e0:	bf00      	nop
     2e2:	bf00      	nop
     2e4:	bf00      	nop
     2e6:	4079      	eors	r1, r7
     2e8:	40a3      	lsls	r3, r4
     2ea:	60b5      	str	r5, [r6, #8]
     2ec:	bf00      	nop
     2ee:	bf00      	nop
     2f0:	bf00      	nop
     2f2:	bf00      	nop
     2f4:	f000 bf51 	b.w	0x119a
     2f8:	bf00      	nop
     2fa:	4659      	mov	r1, fp
     2fc:	bf00      	nop
     2fe:	bf00      	nop
     300:	bf00      	nop
     302:	bf00      	nop
     304:	bf00      	nop
     306:	4079      	eors	r1, r7
     308:	40a3      	lsls	r3, r4
     30a:	68b5      	ldr	r5, [r6, #8]
     30c:	bf00      	nop
     30e:	bf00      	nop
     310:	bf00      	nop
     312:	bf00      	nop
     314:	f000 bf41 	b.w	0x119a
     318:	bf00      	nop
     31a:	4659      	mov	r1, fp
     31c:	bf00      	nop
     31e:	bf00      	nop
     320:	bf00      	nop
     322:	bf00      	nop
     324:	bf00      	nop
     326:	4079      	eors	r1, r7
     328:	40a3      	lsls	r3, r4
     32a:	4375      	muls	r5, r6
     32c:	bf00      	nop
     32e:	bf00      	nop
     330:	bf00      	nop
     332:	bf00      	nop
     334:	bf00      	nop
     336:	f000 bf30 	b.w	0x119a
     33a:	4659      	mov	r1, fp
     33c:	bf00      	nop
     33e:	bf00      	nop
     340:	bf00      	nop
     342:	bf00      	nop
     344:	bf00      	nop
     346:	4079      	eors	r1, r7
     348:	6063      	str	r3, [r4, #4]
     34a:	4075      	eors	r5, r6
     34c:	bf00      	nop
     34e:	bf00      	nop
     350:	bf00      	nop
     352:	bf00      	nop
     354:	f000 bf21 	b.w	0x119a
     358:	bf00      	nop
     35a:	4659      	mov	r1, fp
     35c:	bf00      	nop
     35e:	bf00      	nop
     360:	bf00      	nop
     362:	bf00      	nop
     364:	bf00      	nop
     366:	4079      	eors	r1, r7
     368:	6063      	str	r3, [r4, #4]
     36a:	40b5      	lsls	r5, r6
     36c:	bf00      	nop
     36e:	bf00      	nop
     370:	bf00      	nop
     372:	bf00      	nop
     374:	f000 bf11 	b.w	0x119a
     378:	bf00      	nop
     37a:	4659      	mov	r1, fp
     37c:	bf00      	nop
     37e:	bf00      	nop
     380:	bf00      	nop
     382:	bf00      	nop
     384:	bf00      	nop
     386:	4079      	eors	r1, r7
     388:	6063      	str	r3, [r4, #4]
     38a:	60b5      	str	r5, [r6, #8]
     38c:	bf00      	nop
     38e:	bf00      	nop
     390:	bf00      	nop
     392:	f000 bf02 	b.w	0x119a
     396:	bf00      	nop
     398:	bf00      	nop
     39a:	4659      	mov	r1, fp
     39c:	bf00      	nop
     39e:	bf00      	nop
     3a0:	bf00      	nop
     3a2:	bf00      	nop
     3a4:	bf00      	nop
     3a6:	4079      	eors	r1, r7
     3a8:	6063      	str	r3, [r4, #4]
     3aa:	68b5      	ldr	r5, [r6, #8]
     3ac:	bf00      	nop
     3ae:	bf00      	nop
     3b0:	bf00      	nop
     3b2:	f000 bef2 	b.w	0x119a
     3b6:	bf00      	nop
     3b8:	bf00      	nop
     3ba:	4659      	mov	r1, fp
     3bc:	bf00      	nop
     3be:	bf00      	nop
     3c0:	bf00      	nop
     3c2:	bf00      	nop
     3c4:	bf00      	nop
     3c6:	4079      	eors	r1, r7
     3c8:	6063      	str	r3, [r4, #4]
     3ca:	4375      	muls	r5, r6
     3cc:	bf00      	nop
     3ce:	bf00      	nop
     3d0:	bf00      	nop
     3d2:	bf00      	nop
     3d4:	f000 bee1 	b.w	0x119a
     3d8:	bf00      	nop
     3da:	4659      	mov	r1, fp
     3dc:	bf00      	nop
     3de:	bf00      	nop
     3e0:	bf00      	nop
     3e2:	bf00      	nop
     3e4:	bf00      	nop
     3e6:	4079      	eors	r1, r7
     3e8:	6863      	ldr	r3, [r4, #4]
     3ea:	4075      	eors	r5, r6
     3ec:	bf00      	nop
     3ee:	bf00      	nop
     3f0:	bf00      	nop
     3f2:	bf00      	nop
     3f4:	f000 bed1 	b.w	0x119a
     3f8:	bf00      	nop
     3fa:	4659      	mov	r1, fp
     3fc:	bf00      	nop
     3fe:	bf00      	nop
     400:	bf00      	nop
     402:	bf00      	nop
     404:	bf00      	nop
     406:	4079      	eors	r1, r7
     408:	6863      	ldr	r3, [r4, #4]
     40a:	40b5      	lsls	r5, r6
     40c:	bf00      	nop
     40e:	bf00      	nop
     410:	bf00      	nop
     412:	bf00      	nop
     414:	f000 bec1 	b.w	0x119a
     418:	bf00      	nop
     41a:	4659      	mov	r1, fp
     41c:	bf00      	nop
     41e:	bf00      	nop
     420:	bf00      	nop
     422:	bf00      	nop
     424:	bf00      	nop
     426:	4079      	eors	r1, r7
     428:	6863      	ldr	r3, [r4, #4]
     42a:	60b5      	str	r5, [r6, #8]
     42c:	bf00      	nop
     42e:	bf00      	nop
     430:	bf00      	nop
     432:	f000 beb2 	b.w	0x119a
     436:	bf00      	nop
     438:	bf00      	nop
     43a:	4659      	mov	r1, fp
     43c:	bf00      	nop
     43e:	bf00      	nop
     440:	bf00      	nop
     442:	bf00      	nop
     444:	bf00      	nop
     446:	4079      	eors	r1, r7
     448:	6863      	ldr	r3, [r4, #4]
     44a:	68b5      	ldr	r5, [r6, #8]
     44c:	bf00      	nop
     44e:	bf00      	nop
     450:	bf00      	nop
     452:	f000 bea2 	b.w	0x119a
     456:	bf00      	nop
     458:	bf00      	nop
     45a:	4659      	mov	r1, fp
     45c:	bf00      	nop
     45e:	bf00      	nop
     460:	bf00      	nop
     462:	bf00      	nop
     464:	bf00      	nop
     466:	4079      	eors	r1, r7
     468:	6863      	ldr	r3, [r4, #4]
     46a:	4375      	muls	r5, r6
     46c:	bf00      	nop
     46e:	bf00      	nop
     470:	bf00      	nop
     472:	bf00      	nop
     474:	f000 be91 	b.w	0x119a
     478:	bf00      	nop
     47a:	4659      	mov	r1, fp
     47c:	bf00      	nop
     47e:	bf00      	nop
     480:	bf00      	nop
     482:	bf00      	nop
     484:	bf00      	nop
     486:	4079      	eors	r1, r7
     488:	4363      	muls	r3, r4
     48a:	4075      	eors	r5, r6
     48c:	bf00      	nop
     48e:	bf00      	nop
     490:	bf00      	nop
     492:	bf00      	nop
     494:	bf00      	nop
     496:	f000 be80 	b.w	0x119a
     49a:	4659      	mov	r1, fp
     49c:	bf00      	nop
     49e:	bf00      	nop
     4a0:	bf00      	nop
     4a2:	bf00      	nop
     4a4:	bf00      	nop
     4a6:	4079      	eors	r1, r7
     4a8:	4363      	muls	r3, r4
     4aa:	40b5      	lsls	r5, r6
     4ac:	bf00      	nop
     4ae:	bf00      	nop
     4b0:	bf00      	nop
     4b2:	bf00      	nop
     4b4:	bf00      	nop
     4b6:	f000 be70 	b.w	0x119a
     4ba:	4659      	mov	r1, fp
     4bc:	bf00      	nop
     4be:	bf00      	nop
     4c0:	bf00      	nop
     4c2:	bf00      	nop
     4c4:	bf00      	nop
     4c6:	4079      	eors	r1, r7
     4c8:	4363      	muls	r3, r4
     4ca:	60b5      	str	r5, [r6, #8]
     4cc:	bf00      	nop
     4ce:	bf00      	nop
     4d0:	bf00      	nop
     4d2:	bf00      	nop
     4d4:	f000 be61 	b.w	0x119a
     4d8:	bf00      	nop
     4da:	4659      	mov	r1, fp
     4dc:	bf00      	nop
     4de:	bf00      	nop
     4e0:	bf00      	nop
     4e2:	bf00      	nop
     4e4:	bf00      	nop
     4e6:	4079      	eors	r1, r7
     4e8:	4363      	muls	r3, r4
     4ea:	68b5      	ldr	r5, [r6, #8]
     4ec:	bf00      	nop
     4ee:	bf00      	nop
     4f0:	bf00      	nop
     4f2:	bf00      	nop
     4f4:	f000 be51 	b.w	0x119a
     4f8:	bf00      	nop
     4fa:	4659      	mov	r1, fp
     4fc:	bf00      	nop
     4fe:	bf00      	nop
     500:	bf00      	nop
     502:	bf00      	nop
     504:	bf00      	nop
     506:	4079      	eors	r1, r7
     508:	4363      	muls	r3, r4
     50a:	4375      	muls	r5, r6
     50c:	bf00      	nop
     50e:	bf00      	nop
     510:	bf00      	nop
     512:	bf00      	nop
     514:	bf00      	nop
     516:	f000 be40 	b.w	0x119a
     51a:	4659      	mov	r1, fp
     51c:	bf00      	nop
     51e:	bf00      	nop
     520:	bf00      	nop
     522:	bf00      	nop
     524:	bf00      	nop
     526:	40b9      	lsls	r1, r7
     528:	4063      	eors	r3, r4
     52a:	4075      	eors	r5, r6
     52c:	bf00      	nop
     52e:	bf00      	nop
     530:	bf00      	nop
     532:	bf00      	nop
     534:	bf00      	nop
     536:	f000 be30 	b.w	0x119a
     53a:	4659      	mov	r1, fp
     53c:	bf00      	nop
     53e:	bf00      	nop
     540:	bf00      	nop
     542:	bf00      	nop
     544:	bf00      	nop
     546:	40b9      	lsls	r1, r7
     548:	4063      	eors	r3, r4
     54a:	40b5      	lsls	r5, r6
     54c:	bf00      	nop
     54e:	bf00      	nop
     550:	bf00      	nop
     552:	bf00      	nop
     554:	bf00      	nop
     556:	f000 be20 	b.w	0x119a
     55a:	4659      	mov	r1, fp
     55c:	bf00      	nop
     55e:	bf00      	nop
     560:	bf00      	nop
     562:	bf00      	nop
     564:	bf00      	nop
     566:	40b9      	lsls	r1, r7
     568:	4063      	eors	r3, r4
     56a:	60b5      	str	r5, [r6, #8]
     56c:	bf00      	nop
     56e:	bf00      	nop
     570:	bf00      	nop
     572:	bf00      	nop
     574:	f000 be11 	b.w	0x119a
     578:	bf00      	nop
     57a:	4659      	mov	r1, fp
     57c:	bf00      	nop
     57e:	bf00      	nop
     580:	bf00      	nop
     582:	bf00      	nop
     584:	bf00      	nop
     586:	40b9      	lsls	r1, r7
     588:	4063      	eors	r3, r4
     58a:	68b5      	ldr	r5, [r6, #8]
     58c:	bf00      	nop
     58e:	bf00      	nop
     590:	bf00      	nop
     592:	bf00      	nop
     594:	f000 be01 	b.w	0x119a
     598:	bf00      	nop
     59a:	4659      	mov	r1, fp
     59c:	bf00      	nop
     59e:	bf00      	nop
     5a0:	bf00      	nop
     5a2:	bf00      	nop
     5a4:	bf00      	nop
     5a6:	40b9      	lsls	r1, r7
     5a8:	4063      	eors	r3, r4
     5aa:	4375      	muls	r5, r6
     5ac:	bf00      	nop
     5ae:	bf00      	nop
     5b0:	bf00      	nop
     5b2:	bf00      	nop
     5b4:	bf00      	nop
     5b6:	f000 bdf0 	b.w	0x119a
     5ba:	4659      	mov	r1, fp
     5bc:	bf00      	nop
     5be:	bf00      	nop
     5c0:	bf00      	nop
     5c2:	bf00      	nop
     5c4:	bf00      	nop
     5c6:	40b9      	lsls	r1, r7
     5c8:	40a3      	lsls	r3, r4
     5ca:	4075      	eors	r5, r6
     5cc:	bf00      	nop
     5ce:	bf00      	nop
     5d0:	bf00      	nop
     5d2:	bf00      	nop
     5d4:	bf00      	nop
     5d6:	f000 bde0 	b.w	0x119a
     5da:	4659      	mov	r1, fp
     5dc:	bf00      	nop
     5de:	bf00      	nop
     5e0:	bf00      	nop
     5e2:	bf00      	nop
     5e4:	bf00      	nop
     5e6:	40b9      	lsls	r1, r7
     5e8:	40a3      	lsls	r3, r4
     5ea:	40b5      	lsls	r5, r6
     5ec:	bf00      	nop
     5ee:	bf00      	nop
     5f0:	bf00      	nop
     5f2:	bf00      	nop
     5f4:	bf00      	nop
     5f6:	f000 bdd0 	b.w	0x119a
     5fa:	4659      	mov	r1, fp
     5fc:	bf00      	nop
     5fe:	bf00      	nop
     600:	bf00      	nop
     602:	bf00      	nop
     604:	bf00      	nop
     606:	40b9      	lsls	r1, r7
     608:	40a3      	lsls	r3, r4
     60a:	60b5      	str	r5, [r6, #8]
     60c:	bf00      	nop
     60e:	bf00      	nop
     610:	bf00      	nop
     612:	bf00      	nop
     614:	f000 bdc1 	b.w	0x119a
     618:	bf00      	nop
     61a:	4659      	mov	r1, fp
     61c:	bf00      	nop
     61e:	bf00      	nop
     620:	bf00      	nop
     622:	bf00      	nop
     624:	bf00      	nop
     626:	40b9      	lsls	r1, r7
     628:	40a3      	lsls	r3, r4
     62a:	68b5      	ldr	r5, [r6, #8]
     62c:	bf00      	nop
     62e:	bf00      	nop
     630:	bf00      	nop
     632:	bf00      	nop
     634:	f000 bdb1 	b.w	0x119a
     638:	bf00      	nop
     63a:	4659      	mov	r1, fp
     63c:	bf00      	nop
     63e:	bf00      	nop
     640:	bf00      	nop
     642:	bf00      	nop
     644:	bf00      	nop
     646:	40b9      	lsls	r1, r7
     648:	40a3      	lsls	r3, r4
     64a:	4375      	muls	r5, r6
     64c:	bf00      	nop
     64e:	bf00      	nop
     650:	bf00      	nop
     652:	bf00      	nop
     654:	bf00      	nop
     656:	f000 bda0 	b.w	0x119a
     65a:	4659      	mov	r1, fp
     65c:	bf00      	nop
     65e:	bf00      	nop
     660:	bf00      	nop
     662:	bf00      	nop
     664:	bf00      	nop
     666:	40b9      	lsls	r1, r7
     668:	6063      	str	r3, [r4, #4]
     66a:	4075      	eors	r5, r6
     66c:	bf00      	nop
     66e:	bf00      	nop
     670:	bf00      	nop
     672:	bf00      	nop
     674:	f000 bd91 	b.w	0x119a
     678:	bf00      	nop
     67a:	4659      	mov	r1, fp
     67c:	bf00      	nop
     67e:	bf00      	nop
     680:	bf00      	nop
     682:	bf00      	nop
     684:	bf00      	nop
     686:	40b9      	lsls	r1, r7
     688:	6063      	str	r3, [r4, #4]
     68a:	40b5      	lsls	r5, r6
     68c:	bf00      	nop
     68e:	bf00      	nop
     690:	bf00      	nop
     692:	bf00      	nop
     694:	f000 bd81 	b.w	0x119a
     698:	bf00      	nop
     69a:	4659      	mov	r1, fp
     69c:	bf00      	nop
     69e:	bf00      	nop
     6a0:	bf00      	nop
     6a2:	bf00      	nop
     6a4:	bf00      	nop
     6a6:	40b9      	lsls	r1, r7
     6a8:	6063      	str	r3, [r4, #4]
     6aa:	60b5      	str	r5, [r6, #8]
     6ac:	bf00      	nop
     6ae:	bf00      	nop
     6b0:	bf00      	nop
     6b2:	f000 bd72 	b.w	0x119a
     6b6:	bf00      	nop
     6b8:	bf00      	nop
     6ba:	4659      	mov	r1, fp
     6bc:	bf00      	nop
     6be:	bf00      	nop
     6c0:	bf00      	nop
     6c2:	bf00      	nop
     6c4:	bf00      	nop
     6c6:	40b9      	lsls	r1, r7
     6c8:	6063      	str	r3, [r4, #4]
     6ca:	68b5      	ldr	r5, [r6, #8]
     6cc:	bf00      	nop
     6ce:	bf00      	nop
     6d0:	bf00      	nop
     6d2:	f000 bd62 	b.w	0x119a
     6d6:	bf00      	nop
     6d8:	bf00      	nop
     6da:	4659      	mov	r1, fp
     6dc:	bf00      	nop
     6de:	bf00      	nop
     6e0:	bf00      	nop
     6e2:	bf00      	nop
     6e4:	bf00      	nop
     6e6:	40b9      	lsls	r1, r7
     6e8:	6063      	str	r3, [r4, #4]
     6ea:	4375      	muls	r5, r6
     6ec:	bf00      	nop
     6ee:	bf00      	nop
     6f0:	bf00      	nop
     6f2:	bf00      	nop
     6f4:	f000 bd51 	b.w	0x119a
     6f8:	bf00      	nop
     6fa:	4659      	mov	r1, fp
     6fc:	bf00      	nop
     6fe:	bf00      	nop
     700:	bf00      	nop
     702:	bf00      	nop
     704:	bf00      	nop
     706:	40b9      	lsls	r1, r7
     708:	6863      	ldr	r3, [r4, #4]
     70a:	4075      	eors	r5, r6
     70c:	bf00      	nop
     70e:	bf00      	nop
     710:	bf00      	nop
     712:	bf00      	nop
     714:	f000 bd41 	b.w	0x119a
     718:	bf00      	nop
     71a:	4659      	mov	r1, fp
     71c:	bf00      	nop
     71e:	bf00      	nop
     720:	bf00      	nop
     722:	bf00      	nop
     724:	bf00      	nop
     726:	40b9      	lsls	r1, r7
     728:	6863      	ldr	r3, [r4, #4]
     72a:	40b5      	lsls	r5, r6
     72c:	bf00      	nop
     72e:	bf00      	nop
     730:	bf00      	nop
     732:	bf00      	nop
     734:	f000 bd31 	b.w	0x119a
     738:	bf00      	nop
     73a:	4659      	mov	r1, fp
     73c:	bf00      	nop
     73e:	bf00      	nop
     740:	bf00      	nop
     742:	bf00      	nop
     744:	bf00      	nop
     746:	40b9      	lsls	r1, r7
     748:	6863      	ldr	r3, [r4, #4]
     74a:	60b5      	str	r5, [r6, #8]
     74c:	bf00      	nop
     74e:	bf00      	nop
     750:	bf00      	nop
     752:	f000 bd22 	b.w	0x119a
     756:	bf00      	nop
     758:	bf00      	nop
     75a:	4659      	mov	r1, fp
     75c:	bf00      	nop
     75e:	bf00      	nop
     760:	bf00      	nop
     762:	bf00      	nop
     764:	bf00      	nop
     766:	40b9      	lsls	r1, r7
     768:	6863      	ldr	r3, [r4, #4]
     76a:	68b5      	ldr	r5, [r6, #8]
     76c:	bf00      	nop
     76e:	bf00      	nop
     770:	bf00      	nop
     772:	f000 bd12 	b.w	0x119a
     776:	bf00      	nop
     778:	bf00      	nop
     77a:	4659      	mov	r1, fp
     77c:	bf00      	nop
     77e:	bf00      	nop
     780:	bf00      	nop
     782:	bf00      	nop
     784:	bf00      	nop
     786:	40b9      	lsls	r1, r7
     788:	6863      	ldr	r3, [r4, #4]
     78a:	4375      	muls	r5, r6
     78c:	bf00      	nop
     78e:	bf00      	nop
     790:	bf00      	nop
     792:	bf00      	nop
     794:	f000 bd01 	b.w	0x119a
     798:	bf00      	nop
     79a:	4659      	mov	r1, fp
     79c:	bf00      	nop
     79e:	bf00      	nop
     7a0:	bf00      	nop
     7a2:	bf00      	nop
     7a4:	bf00      	nop
     7a6:	40b9      	lsls	r1, r7
     7a8:	4363      	muls	r3, r4
     7aa:	4075      	eors	r5, r6
     7ac:	bf00      	nop
     7ae:	bf00      	nop
     7b0:	bf00      	nop
     7b2:	bf00      	nop
     7b4:	bf00      	nop
     7b6:	f000 bcf0 	b.w	0x119a
     7ba:	4659      	mov	r1, fp
     7bc:	bf00      	nop
     7be:	bf00      	nop
     7c0:	bf00      	nop
     7c2:	bf00      	nop
     7c4:	bf00      	nop
     7c6:	40b9      	lsls	r1, r7
     7c8:	4363      	muls	r3, r4
     7ca:	40b5      	lsls	r5, r6
     7cc:	bf00      	nop
     7ce:	bf00      	nop
     7d0:	bf00      	nop
     7d2:	bf00      	nop
     7d4:	bf00      	nop
     7d6:	f000 bce0 	b.w	0x119a
     7da:	4659      	mov	r1, fp
     7dc:	bf00      	nop
     7de:	bf00      	nop
     7e0:	bf00      	nop
     7e2:	bf00      	nop
     7e4:	bf00      	nop
     7e6:	40b9      	lsls	r1, r7
     7e8:	4363      	muls	r3, r4
     7ea:	60b5      	str	r5, [r6, #8]
     7ec:	bf00      	nop
     7ee:	bf00      	nop
     7f0:	bf00      	nop
     7f2:	bf00      	nop
     7f4:	f000 bcd1 	b.w	0x119a
     7f8:	bf00      	nop
     7fa:	4659      	mov	r1, fp
     7fc:	bf00      	nop
     7fe:	bf00      	nop
     800:	bf00      	nop
     802:	bf00      	nop
     804:	bf00      	nop
     806:	40b9      	lsls	r1, r7
     808:	4363      	muls	r3, r4
     80a:	68b5      	ldr	r5, [r6, #8]
     80c:	bf00      	nop
     80e:	bf00      	nop
     810:	bf00      	nop
     812:	bf00      	nop
     814:	f000 bcc1 	b.w	0x119a
     818:	bf00      	nop
     81a:	4659      	mov	r1, fp
     81c:	bf00      	nop
     81e:	bf00      	nop
     820:	bf00      	nop
     822:	bf00      	nop
     824:	bf00      	nop
     826:	40b9      	lsls	r1, r7
     828:	4363      	muls	r3, r4
     82a:	4375      	muls	r5, r6
     82c:	bf00      	nop
     82e:	bf00      	nop
     830:	bf00      	nop
     832:	bf00      	nop
     834:	bf00      	nop
     836:	f000 bcb0 	b.w	0x119a
     83a:	4659      	mov	r1, fp
     83c:	bf00      	nop
     83e:	bf00      	nop
     840:	bf00      	nop
     842:	bf00      	nop
     844:	bf00      	nop
     846:	6039      	str	r1, [r7, #0]
     848:	4063      	eors	r3, r4
     84a:	4075      	eors	r5, r6
     84c:	bf00      	nop
     84e:	bf00      	nop
     850:	bf00      	nop
     852:	bf00      	nop
     854:	bf00      	nop
     856:	f000 bca0 	b.w	0x119a
     85a:	4659      	mov	r1, fp
     85c:	bf00      	nop
     85e:	bf00      	nop
     860:	bf00      	nop
     862:	bf00      	nop
     864:	bf00      	nop
     866:	6039      	str	r1, [r7, #0]
     868:	4063      	eors	r3, r4
     86a:	40b5      	lsls	r5, r6
     86c:	bf00      	nop
     86e:	bf00      	nop
     870:	bf00      	nop
     872:	bf00      	nop
     874:	bf00      	nop
     876:	f000 bc90 	b.w	0x119a
     87a:	4659      	mov	r1, fp
     87c:	bf00      	nop
     87e:	bf00      	nop
     880:	bf00      	nop
     882:	bf00      	nop
     884:	bf00      	nop
     886:	6039      	str	r1, [r7, #0]
     888:	4063      	eors	r3, r4
     88a:	60b5      	str	r5, [r6, #8]
     88c:	bf00      	nop
     88e:	bf00      	nop
     890:	bf00      	nop
     892:	bf00      	nop
     894:	f000 bc81 	b.w	0x119a
     898:	bf00      	nop
     89a:	4659      	mov	r1, fp
     89c:	bf00      	nop
     89e:	bf00      	nop
     8a0:	bf00      	nop
     8a2:	bf00      	nop
     8a4:	bf00      	nop
     8a6:	6039      	str	r1, [r7, #0]
     8a8:	4063      	eors	r3, r4
     8aa:	68b5      	ldr	r5, [r6, #8]
     8ac:	bf00      	nop
     8ae:	bf00      	nop
     8b0:	bf00      	nop
     8b2:	bf00      	nop
     8b4:	f000 bc71 	b.w	0x119a
     8b8:	bf00      	nop
     8ba:	4659      	mov	r1, fp
     8bc:	bf00      	nop
     8be:	bf00      	nop
     8c0:	bf00      	nop
     8c2:	bf00      	nop
     8c4:	bf00      	nop
     8c6:	6039      	str	r1, [r7, #0]
     8c8:	4063      	eors	r3, r4
     8ca:	4375      	muls	r5, r6
     8cc:	bf00      	nop
     8ce:	bf00      	nop
     8d0:	bf00      	nop
     8d2:	bf00      	nop
     8d4:	bf00      	nop
     8d6:	f000 bc60 	b.w	0x119a
     8da:	4659      	mov	r1, fp
     8dc:	bf00      	nop
     8de:	bf00      	nop
     8e0:	bf00      	nop
     8e2:	bf00      	nop
     8e4:	bf00      	nop
     8e6:	6039      	str	r1, [r7, #0]
     8e8:	40a3      	lsls	r3, r4
     8ea:	4075      	eors	r5, r6
     8ec:	bf00      	nop
     8ee:	bf00      	nop
     8f0:	bf00      	nop
     8f2:	bf00      	nop
     8f4:	bf00      	nop
     8f6:	f000 bc50 	b.w	0x119a
     8fa:	4659      	mov	r1, fp
     8fc:	bf00      	nop
     8fe:	bf00      	nop
     900:	bf00      	nop
     902:	bf00      	nop
     904:	bf00      	nop
     906:	6039      	str	r1, [r7, #0]
     908:	40a3      	lsls	r3, r4
     90a:	40b5      	lsls	r5, r6
     90c:	bf00      	nop
     90e:	bf00      	nop
     910:	bf00      	nop
     912:	bf00      	nop
     914:	bf00      	nop
     916:	f000 bc40 	b.w	0x119a
     91a:	4659      	mov	r1, fp
     91c:	bf00      	nop
     91e:	bf00      	nop
     920:	bf00      	nop
     922:	bf00      	nop
     924:	bf00      	nop
     926:	6039      	str	r1, [r7, #0]
     928:	40a3      	lsls	r3, r4
     92a:	60b5      	str	r5, [r6, #8]
     92c:	bf00      	nop
     92e:	bf00      	nop
     930:	bf00      	nop
     932:	bf00      	nop
     934:	f000 bc31 	b.w	0x119a
     938:	bf00      	nop
     93a:	4659      	mov	r1, fp
     93c:	bf00      	nop
     93e:	bf00      	nop
     940:	bf00      	nop
     942:	bf00      	nop
     944:	bf00      	nop
     946:	6039      	str	r1, [r7, #0]
     948:	40a3      	lsls	r3, r4
     94a:	68b5      	ldr	r5, [r6, #8]
     94c:	bf00      	nop
     94e:	bf00      	nop
     950:	bf00      	nop
     952:	bf00      	nop
     954:	f000 bc21 	b.w	0x119a
     958:	bf00      	nop
     95a:	4659      	mov	r1, fp
     95c:	bf00      	nop
     95e:	bf00      	nop
     960:	bf00      	nop
     962:	bf00      	nop
     964:	bf00      	nop
     966:	6039      	str	r1, [r7, #0]
     968:	40a3      	lsls	r3, r4
     96a:	4375      	muls	r5, r6
     96c:	bf00      	nop
     96e:	bf00      	nop
     970:	bf00      	nop
     972:	bf00      	nop
     974:	bf00      	nop
     976:	f000 bc10 	b.w	0x119a
     97a:	4659      	mov	r1, fp
     97c:	bf00      	nop
     97e:	bf00      	nop
     980:	bf00      	nop
     982:	bf00      	nop
     984:	bf00      	nop
     986:	6039      	str	r1, [r7, #0]
     988:	6063      	str	r3, [r4, #4]
     98a:	4075      	eors	r5, r6
     98c:	bf00      	nop
     98e:	bf00      	nop
     990:	bf00      	nop
     992:	bf00      	nop
     994:	f000 bc01 	b.w	0x119a
     998:	bf00      	nop
     99a:	4659      	mov	r1, fp
     99c:	bf00      	nop
     99e:	bf00      	nop
     9a0:	bf00      	nop
     9a2:	bf00      	nop
     9a4:	bf00      	nop
     9a6:	6039      	str	r1, [r7, #0]
     9a8:	6063      	str	r3, [r4, #4]
     9aa:	40b5      	lsls	r5, r6
     9ac:	bf00      	nop
     9ae:	bf00      	nop
     9b0:	bf00      	nop
     9b2:	bf00      	nop
     9b4:	f000 bbf1 	b.w	0x119a
     9b8:	bf00      	nop
     9ba:	4659      	mov	r1, fp
     9bc:	bf00      	nop
     9be:	bf00      	nop
     9c0:	bf00      	nop
     9c2:	bf00      	nop
     9c4:	bf00      	nop
     9c6:	6039      	str	r1, [r7, #0]
     9c8:	6063      	str	r3, [r4, #4]
     9ca:	60b5      	str	r5, [r6, #8]
     9cc:	bf00      	nop
     9ce:	bf00      	nop
     9d0:	bf00      	nop
     9d2:	f000 bbe2 	b.w	0x119a
     9d6:	bf00      	nop
     9d8:	bf00      	nop
     9da:	4659      	mov	r1, fp
     9dc:	bf00      	nop
     9de:	bf00      	nop
     9e0:	bf00      	nop
     9e2:	bf00      	nop
     9e4:	bf00      	nop
     9e6:	6039      	str	r1, [r7, #0]
     9e8:	6063      	str	r3, [r4, #4]
     9ea:	68b5      	ldr	r5, [r6, #8]
     9ec:	bf00      	nop
     9ee:	bf00      	nop
     9f0:	bf00      	nop
     9f2:	f000 bbd2 	b.w	0x119a
     9f6:	bf00      	nop
     9f8:	bf00      	nop
     9fa:	4659      	mov	r1, fp
     9fc:	bf00      	nop
     9fe:	bf00      	nop
     a00:	bf00      	nop
     a02:	bf00      	nop
     a04:	bf00      	nop
     a06:	6039      	str	r1, [r7, #0]
     a08:	6063      	str	r3, [r4, #4]
     a0a:	4375      	muls	r5, r6
     a0c:	bf00      	nop
     a0e:	bf00      	nop
     a10:	bf00      	nop
     a12:	bf00      	nop
     a14:	f000 bbc1 	b.w	0x119a
     a18:	bf00      	nop
     a1a:	4659      	mov	r1, fp
     a1c:	bf00      	nop
     a1e:	bf00      	nop
     a20:	bf00      	nop
     a22:	bf00      	nop
     a24:	bf00      	nop
     a26:	6039      	str	r1, [r7, #0]
     a28:	6863      	ldr	r3, [r4, #4]
     a2a:	4075      	eors	r5, r6
     a2c:	bf00      	nop
     a2e:	bf00      	nop
     a30:	bf00      	nop
     a32:	bf00      	nop
     a34:	f000 bbb1 	b.w	0x119a
     a38:	bf00      	nop
     a3a:	4659      	mov	r1, fp
     a3c:	bf00      	nop
     a3e:	bf00      	nop
     a40:	bf00      	nop
     a42:	bf00      	nop
     a44:	bf00      	nop
     a46:	6039      	str	r1, [r7, #0]
     a48:	6863      	ldr	r3, [r4, #4]
     a4a:	40b5      	lsls	r5, r6
     a4c:	bf00      	nop
     a4e:	bf00      	nop
     a50:	bf00      	nop
     a52:	bf00      	nop
     a54:	f000 bba1 	b.w	0x119a
     a58:	bf00      	nop
     a5a:	4659      	mov	r1, fp
     a5c:	bf00      	nop
     a5e:	bf00      	nop
     a60:	bf00      	nop
     a62:	bf00      	nop
     a64:	bf00      	nop
     a66:	6039      	str	r1, [r7, #0]
     a68:	6863      	ldr	r3, [r4, #4]
     a6a:	60b5      	str	r5, [r6, #8]
     a6c:	bf00      	nop
     a6e:	bf00      	nop
     a70:	bf00      	nop
     a72:	f000 bb92 	b.w	0x119a
     a76:	bf00      	nop
     a78:	bf00      	nop
     a7a:	4659      	mov	r1, fp
     a7c:	bf00      	nop
     a7e:	bf00      	nop
     a80:	bf00      	nop
     a82:	bf00      	nop
     a84:	bf00      	nop
     a86:	6039      	str	r1, [r7, #0]
     a88:	6863      	ldr	r3, [r4, #4]
     a8a:	68b5      	ldr	r5, [r6, #8]
     a8c:	bf00      	nop
     a8e:	bf00      	nop
     a90:	bf00      	nop
     a92:	f000 bb82 	b.w	0x119a
     a96:	bf00      	nop
     a98:	bf00      	nop
     a9a:	4659      	mov	r1, fp
     a9c:	bf00      	nop
     a9e:	bf00      	nop
     aa0:	bf00      	nop
     aa2:	bf00      	nop
     aa4:	bf00      	nop
     aa6:	6039      	str	r1, [r7, #0]
     aa8:	6863      	ldr	r3, [r4, #4]
     aaa:	4375      	muls	r5, r6
     aac:	bf00      	nop
     aae:	bf00      	nop
     ab0:	bf00      	nop
     ab2:	bf00      	nop
     ab4:	f000 bb71 	b.w	0x119a
     ab8:	bf00      	nop
     aba:	4659      	mov	r1, fp
     abc:	bf00      	nop
     abe:	bf00      	nop
     ac0:	bf00      	nop
     ac2:	bf00      	nop
     ac4:	bf00      	nop
     ac6:	6039      	str	r1, [r7, #0]
     ac8:	4363      	muls	r3, r4
     aca:	4075      	eors	r5, r6
     acc:	bf00      	nop
     ace:	bf00      	nop
     ad0:	bf00      	nop
     ad2:	bf00      	nop
     ad4:	bf00      	nop
     ad6:	f000 bb60 	b.w	0x119a
     ada:	4659      	mov	r1, fp
     adc:	bf00      	nop
     ade:	bf00      	nop
     ae0:	bf00      	nop
     ae2:	bf00      	nop
     ae4:	bf00      	nop
     ae6:	6039      	str	r1, [r7, #0]
     ae8:	4363      	muls	r3, r4
     aea:	40b5      	lsls	r5, r6
     aec:	bf00      	nop
     aee:	bf00      	nop
     af0:	bf00      	nop
     af2:	bf00      	nop
     af4:	bf00      	nop
     af6:	f000 bb50 	b.w	0x119a
     afa:	4659      	mov	r1, fp
     afc:	bf00      	nop
     afe:	bf00      	nop
     b00:	bf00      	nop
     b02:	bf00      	nop
     b04:	bf00      	nop
     b06:	6039      	str	r1, [r7, #0]
     b08:	4363      	muls	r3, r4
     b0a:	60b5      	str	r5, [r6, #8]
     b0c:	bf00      	nop
     b0e:	bf00      	nop
     b10:	bf00      	nop
     b12:	bf00      	nop
     b14:	f000 bb41 	b.w	0x119a
     b18:	bf00      	nop
     b1a:	4659      	mov	r1, fp
     b1c:	bf00      	nop
     b1e:	bf00      	nop
     b20:	bf00      	nop
     b22:	bf00      	nop
     b24:	bf00      	nop
     b26:	6039      	str	r1, [r7, #0]
     b28:	4363      	muls	r3, r4
     b2a:	68b5      	ldr	r5, [r6, #8]
     b2c:	bf00      	nop
     b2e:	bf00      	nop
     b30:	bf00      	nop
     b32:	bf00      	nop
     b34:	f000 bb31 	b.w	0x119a
     b38:	bf00      	nop
     b3a:	4659      	mov	r1, fp
     b3c:	bf00      	nop
     b3e:	bf00      	nop
     b40:	bf00      	nop
     b42:	bf00      	nop
     b44:	bf00      	nop
     b46:	6039      	str	r1, [r7, #0]
     b48:	4363      	muls	r3, r4
     b4a:	4375      	muls	r5, r6
     b4c:	bf00      	nop
     b4e:	bf00      	nop
     b50:	bf00      	nop
     b52:	bf00      	nop
     b54:	bf00      	nop
     b56:	f000 bb20 	b.w	0x119a
     b5a:	4659      	mov	r1, fp
     b5c:	bf00      	nop
     b5e:	bf00      	nop
     b60:	bf00      	nop
     b62:	bf00      	nop
     b64:	6839      	ldr	r1, [r7, #0]
     b66:	4063      	eors	r3, r4
     b68:	4075      	eors	r5, r6
     b6a:	bf00      	nop
     b6c:	bf00      	nop
     b6e:	bf00      	nop
     b70:	bf00      	nop
     b72:	bf00      	nop
     b74:	f000 bb11 	b.w	0x119a
     b78:	bf00      	nop
     b7a:	4659      	mov	r1, fp
     b7c:	bf00      	nop
     b7e:	bf00      	nop
     b80:	bf00      	nop
     b82:	bf00      	nop
     b84:	6839      	ldr	r1, [r7, #0]
     b86:	4063      	eors	r3, r4
     b88:	40b5      	lsls	r5, r6
     b8a:	bf00      	nop
     b8c:	bf00      	nop
     b8e:	bf00      	nop
     b90:	bf00      	nop
     b92:	bf00      	nop
     b94:	f000 bb01 	b.w	0x119a
     b98:	bf00      	nop
     b9a:	4659      	mov	r1, fp
     b9c:	bf00      	nop
     b9e:	bf00      	nop
     ba0:	bf00      	nop
     ba2:	bf00      	nop
     ba4:	6839      	ldr	r1, [r7, #0]
     ba6:	4063      	eors	r3, r4
     ba8:	60b5      	str	r5, [r6, #8]
     baa:	bf00      	nop
     bac:	bf00      	nop
     bae:	bf00      	nop
     bb0:	bf00      	nop
     bb2:	f000 baf2 	b.w	0x119a
     bb6:	bf00      	nop
     bb8:	bf00      	nop
     bba:	4659      	mov	r1, fp
     bbc:	bf00      	nop
     bbe:	bf00      	nop
     bc0:	bf00      	nop
     bc2:	bf00      	nop
     bc4:	6839      	ldr	r1, [r7, #0]
     bc6:	4063      	eors	r3, r4
     bc8:	68b5      	ldr	r5, [r6, #8]
     bca:	bf00      	nop
     bcc:	bf00      	nop
     bce:	bf00      	nop
     bd0:	bf00      	nop
     bd2:	f000 bae2 	b.w	0x119a
     bd6:	bf00      	nop
     bd8:	bf00      	nop
     bda:	4659      	mov	r1, fp
     bdc:	bf00      	nop
     bde:	bf00      	nop
     be0:	bf00      	nop
     be2:	bf00      	nop
     be4:	6839      	ldr	r1, [r7, #0]
     be6:	4063      	eors	r3, r4
     be8:	4375      	muls	r5, r6
     bea:	bf00      	nop
     bec:	bf00      	nop
     bee:	bf00      	nop
     bf0:	bf00      	nop
     bf2:	bf00      	nop
     bf4:	f000 bad1 	b.w	0x119a
     bf8:	bf00      	nop
     bfa:	4659      	mov	r1, fp
     bfc:	bf00      	nop
     bfe:	bf00      	nop
     c00:	bf00      	nop
     c02:	bf00      	nop
     c04:	6839      	ldr	r1, [r7, #0]
     c06:	40a3      	lsls	r3, r4
     c08:	4075      	eors	r5, r6
     c0a:	bf00      	nop
     c0c:	bf00      	nop
     c0e:	bf00      	nop
     c10:	bf00      	nop
     c12:	bf00      	nop
     c14:	f000 bac1 	b.w	0x119a
     c18:	bf00      	nop
     c1a:	4659      	mov	r1, fp
     c1c:	bf00      	nop
     c1e:	bf00      	nop
     c20:	bf00      	nop
     c22:	bf00      	nop
     c24:	6839      	ldr	r1, [r7, #0]
     c26:	40a3      	lsls	r3, r4
     c28:	40b5      	lsls	r5, r6
     c2a:	bf00      	nop
     c2c:	bf00      	nop
     c2e:	bf00      	nop
     c30:	bf00      	nop
     c32:	bf00      	nop
     c34:	f000 bab1 	b.w	0x119a
     c38:	bf00      	nop
     c3a:	4659      	mov	r1, fp
     c3c:	bf00      	nop
     c3e:	bf00      	nop
     c40:	bf00      	nop
     c42:	bf00      	nop
     c44:	6839      	ldr	r1, [r7, #0]
     c46:	40a3      	lsls	r3, r4
     c48:	60b5      	str	r5, [r6, #8]
     c4a:	bf00      	nop
     c4c:	bf00      	nop
     c4e:	bf00      	nop
     c50:	bf00      	nop
     c52:	f000 baa2 	b.w	0x119a
     c56:	bf00      	nop
     c58:	bf00      	nop
     c5a:	4659      	mov	r1, fp
     c5c:	bf00      	nop
     c5e:	bf00      	nop
     c60:	bf00      	nop
     c62:	bf00      	nop
     c64:	6839      	ldr	r1, [r7, #0]
     c66:	40a3      	lsls	r3, r4
     c68:	68b5      	ldr	r5, [r6, #8]
     c6a:	bf00      	nop
     c6c:	bf00      	nop
     c6e:	bf00      	nop
     c70:	bf00      	nop
     c72:	f000 ba92 	b.w	0x119a
     c76:	bf00      	nop
     c78:	bf00      	nop
     c7a:	4659      	mov	r1, fp
     c7c:	bf00      	nop
     c7e:	bf00      	nop
     c80:	bf00      	nop
     c82:	bf00      	nop
     c84:	6839      	ldr	r1, [r7, #0]
     c86:	40a3      	lsls	r3, r4
     c88:	4375      	muls	r5, r6
     c8a:	bf00      	nop
     c8c:	bf00      	nop
     c8e:	bf00      	nop
     c90:	bf00      	nop
     c92:	bf00      	nop
     c94:	f000 ba81 	b.w	0x119a
     c98:	bf00      	nop
     c9a:	4659      	mov	r1, fp
     c9c:	bf00      	nop
     c9e:	bf00      	nop
     ca0:	bf00      	nop
     ca2:	bf00      	nop
     ca4:	6839      	ldr	r1, [r7, #0]
     ca6:	6063      	str	r3, [r4, #4]
     ca8:	4075      	eors	r5, r6
     caa:	bf00      	nop
     cac:	bf00      	nop
     cae:	bf00      	nop
     cb0:	bf00      	nop
     cb2:	f000 ba72 	b.w	0x119a
     cb6:	bf00      	nop
     cb8:	bf00      	nop
     cba:	4659      	mov	r1, fp
     cbc:	bf00      	nop
     cbe:	bf00      	nop
     cc0:	bf00      	nop
     cc2:	bf00      	nop
     cc4:	6839      	ldr	r1, [r7, #0]
     cc6:	6063      	str	r3, [r4, #4]
     cc8:	40b5      	lsls	r5, r6
     cca:	bf00      	nop
     ccc:	bf00      	nop
     cce:	bf00      	nop
     cd0:	bf00      	nop
     cd2:	f000 ba62 	b.w	0x119a
     cd6:	bf00      	nop
     cd8:	bf00      	nop
     cda:	4659      	mov	r1, fp
     cdc:	bf00      	nop
     cde:	bf00      	nop
     ce0:	bf00      	nop
     ce2:	bf00      	nop
     ce4:	6839      	ldr	r1, [r7, #0]
     ce6:	6063      	str	r3, [r4, #4]
     ce8:	60b5      	str	r5, [r6, #8]
     cea:	bf00      	nop
     cec:	bf00      	nop
     cee:	bf00      	nop
     cf0:	f000 ba53 	b.w	0x119a
     cf4:	bf00      	nop
     cf6:	bf00      	nop
     cf8:	bf00      	nop
     cfa:	4659      	mov	r1, fp
     cfc:	bf00      	nop
     cfe:	bf00      	nop
     d00:	bf00      	nop
     d02:	bf00      	nop
     d04:	6839      	ldr	r1, [r7, #0]
     d06:	6063      	str	r3, [r4, #4]
     d08:	68b5      	ldr	r5, [r6, #8]
     d0a:	bf00      	nop
     d0c:	bf00      	nop
     d0e:	bf00      	nop
     d10:	f000 ba43 	b.w	0x119a
     d14:	bf00      	nop
     d16:	bf00      	nop
     d18:	bf00      	nop
     d1a:	4659      	mov	r1, fp
     d1c:	bf00      	nop
     d1e:	bf00      	nop
     d20:	bf00      	nop
     d22:	bf00      	nop
     d24:	6839      	ldr	r1, [r7, #0]
     d26:	6063      	str	r3, [r4, #4]
     d28:	4375      	muls	r5, r6
     d2a:	bf00      	nop
     d2c:	bf00      	nop
     d2e:	bf00      	nop
     d30:	bf00      	nop
     d32:	f000 ba32 	b.w	0x119a
     d36:	bf00      	nop
     d38:	bf00      	nop
     d3a:	4659      	mov	r1, fp
     d3c:	bf00      	nop
     d3e:	bf00      	nop
     d40:	bf00      	nop
     d42:	bf00      	nop
     d44:	6839      	ldr	r1, [r7, #0]
     d46:	6863      	ldr	r3, [r4, #4]
     d48:	4075      	eors	r5, r6
     d4a:	bf00      	nop
     d4c:	bf00      	nop
     d4e:	bf00      	nop
     d50:	bf00      	nop
     d52:	f000 ba22 	b.w	0x119a
     d56:	bf00      	nop
     d58:	bf00      	nop
     d5a:	4659      	mov	r1, fp
     d5c:	bf00      	nop
     d5e:	bf00      	nop
     d60:	bf00      	nop
     d62:	bf00      	nop
     d64:	6839      	ldr	r1, [r7, #0]
     d66:	6863      	ldr	r3, [r4, #4]
     d68:	40b5      	lsls	r5, r6
     d6a:	bf00      	nop
     d6c:	bf00      	nop
     d6e:	bf00      	nop
     d70:	bf00      	nop
     d72:	f000 ba12 	b.w	0x119a
     d76:	bf00      	nop
     d78:	bf00      	nop
     d7a:	4659      	mov	r1, fp
     d7c:	bf00      	nop
     d7e:	bf00      	nop
     d80:	bf00      	nop
     d82:	bf00      	nop
     d84:	6839      	ldr	r1, [r7, #0]
     d86:	6863      	ldr	r3, [r4, #4]
     d88:	60b5      	str	r5, [r6, #8]
     d8a:	bf00      	nop
     d8c:	bf00      	nop
     d8e:	bf00      	nop
     d90:	f000 ba03 	b.w	0x119a
     d94:	bf00      	nop
     d96:	bf00      	nop
     d98:	bf00      	nop
     d9a:	4659      	mov	r1, fp
     d9c:	bf00      	nop
     d9e:	bf00      	nop
     da0:	bf00      	nop
     da2:	bf00      	nop
     da4:	6839      	ldr	r1, [r7, #0]
     da6:	6863      	ldr	r3, [r4, #4]
     da8:	68b5      	ldr	r5, [r6, #8]
     daa:	bf00      	nop
     dac:	bf00      	nop
     dae:	bf00      	nop
     db0:	f000 b9f3 	b.w	0x119a
     db4:	bf00      	nop
     db6:	bf00      	nop
     db8:	bf00      	nop
     dba:	4659      	mov	r1, fp
     dbc:	bf00      	nop
     dbe:	bf00      	nop
     dc0:	bf00      	nop
     dc2:	bf00      	nop
     dc4:	6839      	ldr	r1, [r7, #0]
     dc6:	6863      	ldr	r3, [r4, #4]
     dc8:	4375      	muls	r5, r6
     dca:	bf00      	nop
     dcc:	bf00      	nop
     dce:	bf00      	nop
     dd0:	bf00      	nop
     dd2:	f000 b9e2 	b.w	0x119a
     dd6:	bf00      	nop
     dd8:	bf00      	nop
     dda:	4659      	mov	r1, fp
     ddc:	bf00      	nop
     dde:	bf00      	nop
     de0:	bf00      	nop
     de2:	bf00      	nop
     de4:	6839      	ldr	r1, [r7, #0]
     de6:	4363      	muls	r3, r4
     de8:	4075      	eors	r5, r6
     dea:	bf00      	nop
     dec:	bf00      	nop
     dee:	bf00      	nop
     df0:	bf00      	nop
     df2:	bf00      	nop
     df4:	f000 b9d1 	b.w	0x119a
     df8:	bf00      	nop
     dfa:	4659      	mov	r1, fp
     dfc:	bf00      	nop
     dfe:	bf00      	nop
     e00:	bf00      	nop
     e02:	bf00      	nop
     e04:	6839      	ldr	r1, [r7, #0]
     e06:	4363      	muls	r3, r4
     e08:	40b5      	lsls	r5, r6
     e0a:	bf00      	nop
     e0c:	bf00      	nop
     e0e:	bf00      	nop
     e10:	bf00      	nop
     e12:	bf00      	nop
     e14:	f000 b9c1 	b.w	0x119a
     e18:	bf00      	nop
     e1a:	4659      	mov	r1, fp
     e1c:	bf00      	nop
     e1e:	bf00      	nop
     e20:	bf00      	nop
     e22:	bf00      	nop
     e24:	6839      	ldr	r1, [r7, #0]
     e26:	4363      	muls	r3, r4
     e28:	60b5      	str	r5, [r6, #8]
     e2a:	bf00      	nop
     e2c:	bf00      	nop
     e2e:	bf00      	nop
     e30:	bf00      	nop
     e32:	f000 b9b2 	b.w	0x119a
     e36:	bf00      	nop
     e38:	bf00      	nop
     e3a:	4659      	mov	r1, fp
     e3c:	bf00      	nop
     e3e:	bf00      	nop
     e40:	bf00      	nop
     e42:	bf00      	nop
     e44:	6839      	ldr	r1, [r7, #0]
     e46:	4363      	muls	r3, r4
     e48:	68b5      	ldr	r5, [r6, #8]
     e4a:	bf00      	nop
     e4c:	bf00      	nop
     e4e:	bf00      	nop
     e50:	bf00      	nop
     e52:	f000 b9a2 	b.w	0x119a
     e56:	bf00      	nop
     e58:	bf00      	nop
     e5a:	4659      	mov	r1, fp
     e5c:	bf00      	nop
     e5e:	bf00      	nop
     e60:	bf00      	nop
     e62:	bf00      	nop
     e64:	6839      	ldr	r1, [r7, #0]
     e66:	4363      	muls	r3, r4
     e68:	4375      	muls	r5, r6
     e6a:	bf00      	nop
     e6c:	bf00      	nop
     e6e:	bf00      	nop
     e70:	bf00      	nop
     e72:	bf00      	nop
     e74:	f000 b991 	b.w	0x119a
     e78:	bf00      	nop
     e7a:	4659      	mov	r1, fp
     e7c:	bf00      	nop
     e7e:	bf00      	nop
     e80:	bf00      	nop
     e82:	bf00      	nop
     e84:	bf00      	nop
     e86:	4379      	muls	r1, r7
     e88:	4063      	eors	r3, r4
     e8a:	4075      	eors	r5, r6
     e8c:	bf00      	nop
     e8e:	bf00      	nop
     e90:	bf00      	nop
     e92:	bf00      	nop
     e94:	bf00      	nop
     e96:	f000 b980 	b.w	0x119a
     e9a:	4659      	mov	r1, fp
     e9c:	bf00      	nop
     e9e:	bf00      	nop
     ea0:	bf00      	nop
     ea2:	bf00      	nop
     ea4:	bf00      	nop
     ea6:	4379      	muls	r1, r7
     ea8:	4063      	eors	r3, r4
     eaa:	40b5      	lsls	r5, r6
     eac:	bf00      	nop
     eae:	bf00      	nop
     eb0:	bf00      	nop
     eb2:	bf00      	nop
     eb4:	bf00      	nop
     eb6:	f000 b970 	b.w	0x119a
     eba:	4659      	mov	r1, fp
     ebc:	bf00      	nop
     ebe:	bf00      	nop
     ec0:	bf00      	nop
     ec2:	bf00      	nop
     ec4:	bf00      	nop
     ec6:	4379      	muls	r1, r7
     ec8:	4063      	eors	r3, r4
     eca:	60b5      	str	r5, [r6, #8]
     ecc:	bf00      	nop
     ece:	bf00      	nop
     ed0:	bf00      	nop
     ed2:	bf00      	nop
     ed4:	f000 b961 	b.w	0x119a
     ed8:	bf00      	nop
     eda:	4659      	mov	r1, fp
     edc:	bf00      	nop
     ede:	bf00      	nop
     ee0:	bf00      	nop
     ee2:	bf00      	nop
     ee4:	bf00      	nop
     ee6:	4379      	muls	r1, r7
     ee8:	4063      	eors	r3, r4
     eea:	68b5      	ldr	r5, [r6, #8]
     eec:	bf00      	nop
     eee:	bf00      	nop
     ef0:	bf00      	nop
     ef2:	bf00      	nop
     ef4:	f000 b951 	b.w	0x119a
     ef8:	bf00      	nop
     efa:	4659      	mov	r1, fp
     efc:	bf00      	nop
     efe:	bf00      	nop
     f00:	bf00      	nop
     f02:	bf00      	nop
     f04:	bf00      	nop
     f06:	4379      	muls	r1, r7
     f08:	4063      	eors	r3, r4
     f0a:	4375      	muls	r5, r6
     f0c:	bf00      	nop
     f0e:	bf00      	nop
     f10:	bf00      	nop
     f12:	bf00      	nop
     f14:	bf00      	nop
     f16:	f000 b940 	b.w	0x119a
     f1a:	4659      	mov	r1, fp
     f1c:	bf00      	nop
     f1e:	bf00      	nop
     f20:	bf00      	nop
     f22:	bf00      	nop
     f24:	bf00      	nop
     f26:	4379      	muls	r1, r7
     f28:	40a3      	lsls	r3, r4
     f2a:	4075      	eors	r5, r6
     f2c:	bf00      	nop
     f2e:	bf00      	nop
     f30:	bf00      	nop
     f32:	bf00      	nop
     f34:	bf00      	nop
     f36:	f000 b930 	b.w	0x119a
     f3a:	4659      	mov	r1, fp
     f3c:	bf00      	nop
     f3e:	bf00      	nop
     f40:	bf00      	nop
     f42:	bf00      	nop
     f44:	bf00      	nop
     f46:	4379      	muls	r1, r7
     f48:	40a3      	lsls	r3, r4
     f4a:	40b5      	lsls	r5, r6
     f4c:	bf00      	nop
     f4e:	bf00      	nop
     f50:	bf00      	nop
     f52:	bf00      	nop
     f54:	bf00      	nop
     f56:	f000 b920 	b.w	0x119a
     f5a:	4659      	mov	r1, fp
     f5c:	bf00      	nop
     f5e:	bf00      	nop
     f60:	bf00      	nop
     f62:	bf00      	nop
     f64:	bf00      	nop
     f66:	4379      	muls	r1, r7
     f68:	40a3      	lsls	r3, r4
     f6a:	60b5      	str	r5, [r6, #8]
     f6c:	bf00      	nop
     f6e:	bf00      	nop
     f70:	bf00      	nop
     f72:	bf00      	nop
     f74:	f000 b911 	b.w	0x119a
     f78:	bf00      	nop
     f7a:	4659      	mov	r1, fp
     f7c:	bf00      	nop
     f7e:	bf00      	nop
     f80:	bf00      	nop
     f82:	bf00      	nop
     f84:	bf00      	nop
     f86:	4379      	muls	r1, r7
     f88:	40a3      	lsls	r3, r4
     f8a:	68b5      	ldr	r5, [r6, #8]
     f8c:	bf00      	nop
     f8e:	bf00      	nop
     f90:	bf00      	nop
     f92:	bf00      	nop
     f94:	f000 b901 	b.w	0x119a
     f98:	bf00      	nop
     f9a:	4659      	mov	r1, fp
     f9c:	bf00      	nop
     f9e:	bf00      	nop
     fa0:	bf00      	nop
     fa2:	bf00      	nop
     fa4:	bf00      	nop
     fa6:	4379      	muls	r1, r7
     fa8:	40a3      	lsls	r3, r4
     faa:	4375      	muls	r5, r6
     fac:	bf00      	nop
     fae:	bf00      	nop
     fb0:	bf00      	nop
     fb2:	bf00      	nop
     fb4:	bf00      	nop
     fb6:	f000 b8f0 	b.w	0x119a
     fba:	4659      	mov	r1, fp
     fbc:	bf00      	nop
     fbe:	bf00      	nop
     fc0:	bf00      	nop
     fc2:	bf00      	nop
     fc4:	bf00      	nop
     fc6:	4379      	muls	r1, r7
     fc8:	6063      	str	r3, [r4, #4]
     fca:	4075      	eors	r5, r6
     fcc:	bf00      	nop
     fce:	bf00      	nop
     fd0:	bf00      	nop
     fd2:	bf00      	nop
     fd4:	f000 b8e1 	b.w	0x119a
     fd8:	bf00      	nop
     fda:	4659      	mov	r1, fp
     fdc:	bf00      	nop
     fde:	bf00      	nop
     fe0:	bf00      	nop
     fe2:	bf00      	nop
     fe4:	bf00      	nop
     fe6:	4379      	muls	r1, r7
     fe8:	6063      	str	r3, [r4, #4]
     fea:	40b5      	lsls	r5, r6
     fec:	bf00      	nop
     fee:	bf00      	nop
     ff0:	bf00      	nop
     ff2:	bf00      	nop
     ff4:	f000 b8d1 	b.w	0x119a
     ff8:	bf00      	nop
     ffa:	4659      	mov	r1, fp
     ffc:	bf00      	nop
     ffe:	bf00      	nop
    1000:	bf00      	nop
    1002:	bf00      	nop
    1004:	bf00      	nop
    1006:	4379      	muls	r1, r7
    1008:	6063      	str	r3, [r4, #4]
    100a:	60b5      	str	r5, [r6, #8]
    100c:	bf00      	nop
    100e:	bf00      	nop
    1010:	bf00      	nop
    1012:	f000 b8c2 	b.w	0x119a
    1016:	bf00      	nop
    1018:	bf00      	nop
    101a:	4659      	mov	r1, fp
    101c:	bf00      	nop
    101e:	bf00      	nop
    1020:	bf00      	nop
    1022:	bf00      	nop
    1024:	bf00      	nop
    1026:	4379      	muls	r1, r7
    1028:	6063      	str	r3, [r4, #4]
    102a:	68b5      	ldr	r5, [r6, #8]
    102c:	bf00      	nop
    102e:	bf00      	nop
    1030:	bf00      	nop
    1032:	f000 b8b2 	b.w	0x119a
    1036:	bf00      	nop
    1038:	bf00      	nop
    103a:	4659      	mov	r1, fp
    103c:	bf00      	nop
    103e:	bf00      	nop
    1040:	bf00      	nop
    1042:	bf00      	nop
    1044:	bf00      	nop
    1046:	4379      	muls	r1, r7
    1048:	6063      	str	r3, [r4, #4]
    104a:	4375      	muls	r5, r6
    104c:	bf00      	nop
    104e:	bf00      	nop
    1050:	bf00      	nop
    1052:	bf00      	nop
    1054:	f000 b8a1 	b.w	0x119a
    1058:	bf00      	nop
    105a:	4659      	mov	r1, fp
    105c:	bf00      	nop
    105e:	bf00      	nop
    1060:	bf00      	nop
    1062:	bf00      	nop
    1064:	bf00      	nop
    1066:	4379      	muls	r1, r7
    1068:	6863      	ldr	r3, [r4, #4]
    106a:	4075      	eors	r5, r6
    106c:	bf00      	nop
    106e:	bf00      	nop
    1070:	bf00      	nop
    1072:	bf00      	nop
    1074:	f000 b891 	b.w	0x119a
    1078:	bf00      	nop
    107a:	4659      	mov	r1, fp
    107c:	bf00      	nop
    107e:	bf00      	nop
    1080:	bf00      	nop
    1082:	bf00      	nop
    1084:	bf00      	nop
    1086:	4379      	muls	r1, r7
    1088:	6863      	ldr	r3, [r4, #4]
    108a:	40b5      	lsls	r5, r6
    108c:	bf00      	nop
    108e:	bf00      	nop
    1090:	bf00      	nop
    1092:	bf00      	nop
    1094:	f000 b881 	b.w	0x119a
    1098:	bf00      	nop
    109a:	4659      	mov	r1, fp
    109c:	bf00      	nop
    109e:	bf00      	nop
    10a0:	bf00      	nop
    10a2:	bf00      	nop
    10a4:	bf00      	nop
    10a6:	4379      	muls	r1, r7
    10a8:	6863      	ldr	r3, [r4, #4]
    10aa:	60b5      	str	r5, [r6, #8]
    10ac:	bf00      	nop
    10ae:	bf00      	nop
    10b0:	bf00      	nop
    10b2:	f000 b872 	b.w	0x119a
    10b6:	bf00      	nop
    10b8:	bf00      	nop
    10ba:	4659      	mov	r1, fp
    10bc:	bf00      	nop
    10be:	bf00      	nop
    10c0:	bf00      	nop
    10c2:	bf00      	nop
    10c4:	bf00      	nop
    10c6:	4379      	muls	r1, r7
    10c8:	6863      	ldr	r3, [r4, #4]
    10ca:	68b5      	ldr	r5, [r6, #8]
    10cc:	bf00      	nop
    10ce:	bf00      	nop
    10d0:	bf00      	nop
    10d2:	f000 b862 	b.w	0x119a
    10d6:	bf00      	nop
    10d8:	bf00      	nop
    10da:	4659      	mov	r1, fp
    10dc:	bf00      	nop
    10de:	bf00      	nop
    10e0:	bf00      	nop
    10e2:	bf00      	nop
    10e4:	bf00      	nop
    10e6:	4379      	muls	r1, r7
    10e8:	6863      	ldr	r3, [r4, #4]
    10ea:	4375      	muls	r5, r6
    10ec:	bf00      	nop
    10ee:	bf00      	nop
    10f0:	bf00      	nop
    10f2:	bf00      	nop
    10f4:	f000 b851 	b.w	0x119a
    10f8:	bf00      	nop
    10fa:	4659      	mov	r1, fp
    10fc:	bf00      	nop
    10fe:	bf00      	nop
    1100:	bf00      	nop
    1102:	bf00      	nop
    1104:	bf00      	nop
    1106:	4379      	muls	r1, r7
    1108:	4363      	muls	r3, r4
    110a:	4075      	eors	r5, r6
    110c:	bf00      	nop
    110e:	bf00      	nop
    1110:	bf00      	nop
    1112:	bf00      	nop
    1114:	bf00      	nop
    1116:	f000 b840 	b.w	0x119a
    111a:	4659      	mov	r1, fp
    111c:	bf00      	nop
    111e:	bf00      	nop
    1120:	bf00      	nop
    1122:	bf00      	nop
    1124:	bf00      	nop
    1126:	4379      	muls	r1, r7
    1128:	4363      	muls	r3, r4
    112a:	40b5      	lsls	r5, r6
    112c:	bf00      	nop
    112e:	bf00      	nop
    1130:	bf00      	nop
    1132:	bf00      	nop
    1134:	bf00      	nop
    1136:	f000 b830 	b.w	0x119a
    113a:	4659      	mov	r1, fp
    113c:	bf00      	nop
    113e:	bf00      	nop
    1140:	bf00      	nop
    1142:	bf00      	nop
    1144:	bf00      	nop
    1146:	4379      	muls	r1, r7
    1148:	4363      	muls	r3, r4
    114a:	60b5      	str	r5, [r6, #8]
    114c:	bf00      	nop
    114e:	bf00      	nop
    1150:	bf00      	nop
    1152:	bf00      	nop
    1154:	f000 b821 	b.w	0x119a
    1158:	bf00      	nop
    115a:	4659      	mov	r1, fp
    115c:	bf00      	nop
    115e:	bf00      	nop
    1160:	bf00      	nop
    1162:	bf00      	nop
    1164:	bf00      	nop
    1166:	4379      	muls	r1, r7
    1168:	4363      	muls	r3, r4
    116a:	68b5      	ldr	r5, [r6, #8]
    116c:	bf00      	nop
    116e:	bf00      	nop
    1170:	bf00      	nop
    1172:	bf00      	nop
    1174:	f000 b811 	b.w	0x119a
    1178:	bf00      	nop
    117a:	4659      	mov	r1, fp
    117c:	bf00      	nop
    117e:	bf00      	nop
    1180:	bf00      	nop
    1182:	bf00      	nop
    1184:	bf00      	nop
    1186:	4379      	muls	r1, r7
    1188:	4363      	muls	r3, r4
    118a:	4375      	muls	r5, r6
    118c:	bf00      	nop
    118e:	bf00      	nop
    1190:	bf00      	nop
    1192:	bf00      	nop
    1194:	bf00      	nop
    1196:	f000 b800 	b.w	0x119a
    119a:	6002      	str	r2, [r0, #0]
    119c:	4650      	mov	r0, sl
    119e:	6003      	str	r3, [r0, #0]
    11a0:	e8bd 0fff 	ldmia.w	sp!, {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp}
    11a4:	4770      	bx	lr
    11a6:	0000      	movs	r0, r0
    11a8:	e92d 47f0 	stmdb	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
    11ac:	4c92      	ldr	r4, [pc, #584]	; (0x13f8)
    11ae:	6803      	ldr	r3, [r0, #0]
    11b0:	2510      	movs	r5, #16
    11b2:	6023      	str	r3, [r4, #0]
    11b4:	4b91      	ldr	r3, [pc, #580]	; (0x13fc)
    11b6:	f894 c000 	ldrb.w	ip, [r4]
    11ba:	681b      	ldr	r3, [r3, #0]
    11bc:	f8d3 2080 	ldr.w	r2, [r3, #128]	; 0x80
    11c0:	f442 3280 	orr.w	r2, r2, #65536	; 0x10000
    11c4:	f8c3 2080 	str.w	r2, [r3, #128]	; 0x80
    11c8:	4a8d      	ldr	r2, [pc, #564]	; (0x1400)
    11ca:	6811      	ldr	r1, [r2, #0]
    11cc:	2201      	movs	r2, #1
    11ce:	678a      	str	r2, [r1, #120]	; 0x78
    11d0:	67ca      	str	r2, [r1, #124]	; 0x7c
    11d2:	610d      	str	r5, [r1, #16]
    11d4:	f240 2501 	movw	r5, #513	; 0x201
    11d8:	f8c1 20a4 	str.w	r2, [r1, #164]	; 0xa4
    11dc:	f8c1 20a8 	str.w	r2, [r1, #168]	; 0xa8
    11e0:	630d      	str	r5, [r1, #48]	; 0x30
    11e2:	634d      	str	r5, [r1, #52]	; 0x34
    11e4:	f8d3 1080 	ldr.w	r1, [r3, #128]	; 0x80
    11e8:	4594      	cmp	ip, r2
    11ea:	f041 0120 	orr.w	r1, r1, #32
    11ee:	f8c3 1080 	str.w	r1, [r3, #128]	; 0x80
    11f2:	f8d3 1080 	ldr.w	r1, [r3, #128]	; 0x80
    11f6:	f041 0140 	orr.w	r1, r1, #64	; 0x40
    11fa:	f8c3 1080 	str.w	r1, [r3, #128]	; 0x80
    11fe:	f8d3 1080 	ldr.w	r1, [r3, #128]	; 0x80
    1202:	f441 5180 	orr.w	r1, r1, #4096	; 0x1000
    1206:	f8c3 1080 	str.w	r1, [r3, #128]	; 0x80
    120a:	6859      	ldr	r1, [r3, #4]
    120c:	f021 0102 	bic.w	r1, r1, #2
    1210:	6059      	str	r1, [r3, #4]
    1212:	6859      	ldr	r1, [r3, #4]
    1214:	f041 0102 	orr.w	r1, r1, #2
    1218:	6059      	str	r1, [r3, #4]
    121a:	d006      	beq.n	0x122a
    121c:	d323      	bcc.n	0x1266
    121e:	f1bc 0f02 	cmp.w	ip, #2
    1222:	d006      	beq.n	0x1232
    1224:	2000      	movs	r0, #0
    1226:	e8bd 87f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
    122a:	4662      	mov	r2, ip
    122c:	f04f 0803 	mov.w	r8, #3
    1230:	e000      	b.n	0x1234
    1232:	4690      	mov	r8, r2
    1234:	7867      	ldrb	r7, [r4, #1]
    1236:	f04f 0a00 	mov.w	sl, #0
    123a:	463d      	mov	r5, r7
    123c:	78a1      	ldrb	r1, [r4, #2]
    123e:	2601      	movs	r6, #1
    1240:	f10a 0901 	add.w	r9, sl, #1
    1244:	fbb5 fef6 	udiv	lr, r5, r6
    1248:	fb06 541e 	mls	r4, r6, lr, r5
    124c:	b90c      	cbnz	r4, 0x1252
    124e:	458e      	cmp	lr, r1
    1250:	d00b      	beq.n	0x126a
    1252:	3601      	adds	r6, #1
    1254:	f5b6 7f80 	cmp.w	r6, #256	; 0x100
    1258:	d1f4      	bne.n	0x1244
    125a:	f1b9 0f20 	cmp.w	r9, #32
    125e:	443d      	add	r5, r7
    1260:	46ca      	mov	sl, r9
    1262:	d1ec      	bne.n	0x123e
    1264:	e7de      	b.n	0x1224
    1266:	2200      	movs	r2, #0
    1268:	e7e0      	b.n	0x122c
    126a:	f04f 0902 	mov.w	r9, #2
    126e:	fa09 fe04 	lsl.w	lr, r9, r4
    1272:	fb05 fe0e 	mul.w	lr, r5, lr
    1276:	f1ae 0e9c 	sub.w	lr, lr, #156	; 0x9c
    127a:	f1be 0fa4 	cmp.w	lr, #164	; 0xa4
    127e:	d903      	bls.n	0x1288
    1280:	3401      	adds	r4, #1
    1282:	2c04      	cmp	r4, #4
    1284:	d1f3      	bne.n	0x126e
    1286:	e7cd      	b.n	0x1224
    1288:	f107 3eff 	add.w	lr, r7, #4294967295	; 0xffffffff
    128c:	f1be 0f13 	cmp.w	lr, #19
    1290:	ea4a 1444 	orr.w	r4, sl, r4, lsl #5
    1294:	f200 8098 	bhi.w	0x13c8
    1298:	2700      	movs	r7, #0
    129a:	621f      	str	r7, [r3, #32]
    129c:	f8d3 7238 	ldr.w	r7, [r3, #568]	; 0x238
    12a0:	f1bc 0f00 	cmp.w	ip, #0
    12a4:	f040 8096 	bne.w	0x13d4
    12a8:	f047 0720 	orr.w	r7, r7, #32
    12ac:	f8c3 7238 	str.w	r7, [r3, #568]	; 0x238
    12b0:	27c8      	movs	r7, #200	; 0xc8
    12b2:	bf00      	nop
    12b4:	3f01      	subs	r7, #1
    12b6:	d1fc      	bne.n	0x12b2
    12b8:	641a      	str	r2, [r3, #64]	; 0x40
    12ba:	6c5a      	ldr	r2, [r3, #68]	; 0x44
    12bc:	f042 0201 	orr.w	r2, r2, #1
    12c0:	645a      	str	r2, [r3, #68]	; 0x44
    12c2:	6c5a      	ldr	r2, [r3, #68]	; 0x44
    12c4:	f022 0201 	bic.w	r2, r2, #1
    12c8:	645a      	str	r2, [r3, #68]	; 0x44
    12ca:	6c5a      	ldr	r2, [r3, #68]	; 0x44
    12cc:	f042 0201 	orr.w	r2, r2, #1
    12d0:	645a      	str	r2, [r3, #68]	; 0x44
    12d2:	6c5a      	ldr	r2, [r3, #68]	; 0x44
    12d4:	07d7      	lsls	r7, r2, #31
    12d6:	d5fc      	bpl.n	0x12d2
    12d8:	609c      	str	r4, [r3, #8]
    12da:	f8d3 2238 	ldr.w	r2, [r3, #568]	; 0x238
    12de:	f022 0280 	bic.w	r2, r2, #128	; 0x80
    12e2:	f8c3 2238 	str.w	r2, [r3, #568]	; 0x238
    12e6:	68da      	ldr	r2, [r3, #12]
    12e8:	07d4      	lsls	r4, r2, #31
    12ea:	d5fc      	bpl.n	0x12e6
    12ec:	f8c3 8070 	str.w	r8, [r3, #112]	; 0x70
    12f0:	6f5a      	ldr	r2, [r3, #116]	; 0x74
    12f2:	f042 0201 	orr.w	r2, r2, #1
    12f6:	675a      	str	r2, [r3, #116]	; 0x74
    12f8:	6f5a      	ldr	r2, [r3, #116]	; 0x74
    12fa:	f022 0201 	bic.w	r2, r2, #1
    12fe:	675a      	str	r2, [r3, #116]	; 0x74
    1300:	6f5a      	ldr	r2, [r3, #116]	; 0x74
    1302:	f042 0201 	orr.w	r2, r2, #1
    1306:	675a      	str	r2, [r3, #116]	; 0x74
    1308:	6f5a      	ldr	r2, [r3, #116]	; 0x74
    130a:	07d2      	lsls	r2, r2, #31
    130c:	d5fc      	bpl.n	0x1308
    130e:	2914      	cmp	r1, #20
    1310:	679e      	str	r6, [r3, #120]	; 0x78
    1312:	d862      	bhi.n	0x13da
    1314:	2400      	movs	r4, #0
    1316:	4a3b      	ldr	r2, [pc, #236]	; (0x1404)
    1318:	6812      	ldr	r2, [r2, #0]
    131a:	6114      	str	r4, [r2, #16]
    131c:	4a3a      	ldr	r2, [pc, #232]	; (0x1408)
    131e:	eb01 0181 	add.w	r1, r1, r1, lsl #2
    1322:	6812      	ldr	r2, [r2, #0]
    1324:	f502 4400 	add.w	r4, r2, #32768	; 0x8000
    1328:	6826      	ldr	r6, [r4, #0]
    132a:	f046 0601 	orr.w	r6, r6, #1
    132e:	6026      	str	r6, [r4, #0]
    1330:	6826      	ldr	r6, [r4, #0]
    1332:	f046 0602 	orr.w	r6, r6, #2
    1336:	6026      	str	r6, [r4, #0]
    1338:	4c34      	ldr	r4, [pc, #208]	; (0x140c)
    133a:	6824      	ldr	r4, [r4, #0]
    133c:	f504 4400 	add.w	r4, r4, #32768	; 0x8000
    1340:	6826      	ldr	r6, [r4, #0]
    1342:	f026 0602 	bic.w	r6, r6, #2
    1346:	6026      	str	r6, [r4, #0]
    1348:	f643 74fc 	movw	r4, #16380	; 0x3ffc
    134c:	5916      	ldr	r6, [r2, r4]
    134e:	f026 0601 	bic.w	r6, r6, #1
    1352:	5116      	str	r6, [r2, r4]
    1354:	5916      	ldr	r6, [r2, r4]
    1356:	f026 0602 	bic.w	r6, r6, #2
    135a:	5116      	str	r6, [r2, r4]
    135c:	f8c3 5098 	str.w	r5, [r3, #152]	; 0x98
    1360:	2505      	movs	r5, #5
    1362:	4b2b      	ldr	r3, [pc, #172]	; (0x1410)
    1364:	2404      	movs	r4, #4
    1366:	681b      	ldr	r3, [r3, #0]
    1368:	68da      	ldr	r2, [r3, #12]
    136a:	f042 0280 	orr.w	r2, r2, #128	; 0x80
    136e:	60da      	str	r2, [r3, #12]
    1370:	629d      	str	r5, [r3, #40]	; 0x28
    1372:	6a9a      	ldr	r2, [r3, #40]	; 0x28
    1374:	f042 0280 	orr.w	r2, r2, #128	; 0x80
    1378:	629a      	str	r2, [r3, #40]	; 0x28
    137a:	2200      	movs	r2, #0
    137c:	605a      	str	r2, [r3, #4]
    137e:	601c      	str	r4, [r3, #0]
    1380:	68da      	ldr	r2, [r3, #12]
    1382:	f022 0280 	bic.w	r2, r2, #128	; 0x80
    1386:	60da      	str	r2, [r3, #12]
    1388:	68da      	ldr	r2, [r3, #12]
    138a:	f042 0203 	orr.w	r2, r2, #3
    138e:	60da      	str	r2, [r3, #12]
    1390:	68da      	ldr	r2, [r3, #12]
    1392:	f022 0208 	bic.w	r2, r2, #8
    1396:	60da      	str	r2, [r3, #12]
    1398:	68da      	ldr	r2, [r3, #12]
    139a:	f022 0204 	bic.w	r2, r2, #4
    139e:	60da      	str	r2, [r3, #12]
    13a0:	2240      	movs	r2, #64	; 0x40
    13a2:	4b1c      	ldr	r3, [pc, #112]	; (0x1414)
    13a4:	681b      	ldr	r3, [r3, #0]
    13a6:	6159      	str	r1, [r3, #20]
    13a8:	6119      	str	r1, [r3, #16]
    13aa:	601a      	str	r2, [r3, #0]
    13ac:	f06f 427f 	mvn.w	r2, #4278190080	; 0xff000000
    13b0:	4b19      	ldr	r3, [pc, #100]	; (0x1418)
    13b2:	681b      	ldr	r3, [r3, #0]
    13b4:	615a      	str	r2, [r3, #20]
    13b6:	619a      	str	r2, [r3, #24]
    13b8:	78c2      	ldrb	r2, [r0, #3]
    13ba:	b1d2      	cbz	r2, 0x13f2
    13bc:	611d      	str	r5, [r3, #16]
    13be:	f000 f949 	bl	0x1654
    13c2:	2001      	movs	r0, #1
    13c4:	e8bd 87f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
    13c8:	3f0f      	subs	r7, #15
    13ca:	2f0a      	cmp	r7, #10
    13cc:	bf98      	it	ls
    13ce:	f8c3 9020 	strls.w	r9, [r3, #32]
    13d2:	e763      	b.n	0x129c
    13d4:	f027 0720 	bic.w	r7, r7, #32
    13d8:	e768      	b.n	0x12ac
    13da:	2928      	cmp	r1, #40	; 0x28
    13dc:	d803      	bhi.n	0x13e6
    13de:	4a09      	ldr	r2, [pc, #36]	; (0x1404)
    13e0:	2401      	movs	r4, #1
    13e2:	6812      	ldr	r2, [r2, #0]
    13e4:	e799      	b.n	0x131a
    13e6:	2932      	cmp	r1, #50	; 0x32
    13e8:	d898      	bhi.n	0x131c
    13ea:	4a06      	ldr	r2, [pc, #24]	; (0x1404)
    13ec:	2402      	movs	r4, #2
    13ee:	6812      	ldr	r2, [r2, #0]
    13f0:	e793      	b.n	0x131a
    13f2:	611c      	str	r4, [r3, #16]
    13f4:	e7e3      	b.n	0x13be
    13f6:	bf00      	nop
    13f8:	0030      	movs	r0, r6
    13fa:	1000      	asrs	r0, r0, #32
    13fc:	0004      	movs	r4, r0
    13fe:	1000      	asrs	r0, r0, #32
    1400:	0008      	movs	r0, r1
    1402:	1000      	asrs	r0, r0, #32
    1404:	0024      	movs	r4, r4
    1406:	1000      	asrs	r0, r0, #32
    1408:	0010      	movs	r0, r2
    140a:	1000      	asrs	r0, r0, #32
    140c:	000c      	movs	r4, r1
    140e:	1000      	asrs	r0, r0, #32
    1410:	001c      	movs	r4, r3
    1412:	1000      	asrs	r0, r0, #32
    1414:	0020      	movs	r0, r4
    1416:	1000      	asrs	r0, r0, #32
    1418:	0028      	movs	r0, r5
    141a:	1000      	asrs	r0, r0, #32
    141c:	4b05      	ldr	r3, [pc, #20]	; (0x1434)
    141e:	789b      	ldrb	r3, [r3, #2]
    1420:	4358      	muls	r0, r3
    1422:	2303      	movs	r3, #3
    1424:	fb90 f0f3 	sdiv	r0, r0, r3
    1428:	2800      	cmp	r0, #0
    142a:	dd01      	ble.n	0x1430
    142c:	3801      	subs	r0, #1
    142e:	d1fd      	bne.n	0x142c
    1430:	4770      	bx	lr
    1432:	bf00      	nop
    1434:	0030      	movs	r0, r6
    1436:	1000      	asrs	r0, r0, #32
    1438:	4601      	mov	r1, r0
    143a:	2200      	movs	r2, #0
    143c:	b508      	push	{r3, lr}
    143e:	428a      	cmp	r2, r1
    1440:	db00      	blt.n	0x1444
    1442:	bd08      	pop	{r3, pc}
    1444:	f44f 707a 	mov.w	r0, #1000	; 0x3e8
    1448:	f7ff ffe8 	bl	0x141c
    144c:	3201      	adds	r2, #1
    144e:	e7f6      	b.n	0x143e
    1450:	4b02      	ldr	r3, [pc, #8]	; (0x145c)
    1452:	2100      	movs	r1, #0
    1454:	681b      	ldr	r3, [r3, #0]
    1456:	6998      	ldr	r0, [r3, #24]
    1458:	4770      	bx	lr
    145a:	bf00      	nop
    145c:	0028      	movs	r0, r5
    145e:	1000      	asrs	r0, r0, #32
    1460:	2801      	cmp	r0, #1
    1462:	d00c      	beq.n	0x147e
    1464:	d303      	bcc.n	0x146e
    1466:	2802      	cmp	r0, #2
    1468:	d011      	beq.n	0x148e
    146a:	2000      	movs	r0, #0
    146c:	4770      	bx	lr
    146e:	4b09      	ldr	r3, [pc, #36]	; (0x1494)
    1470:	681a      	ldr	r2, [r3, #0]
    1472:	f643 73fc 	movw	r3, #16380	; 0x3ffc
    1476:	58d0      	ldr	r0, [r2, r3]
    1478:	f000 0001 	and.w	r0, r0, #1
    147c:	4770      	bx	lr
    147e:	4b05      	ldr	r3, [pc, #20]	; (0x1494)
    1480:	681a      	ldr	r2, [r3, #0]
    1482:	f643 73fc 	movw	r3, #16380	; 0x3ffc
    1486:	58d0      	ldr	r0, [r2, r3]
    1488:	f3c0 0040 	ubfx	r0, r0, #1, #1
    148c:	4770      	bx	lr
    148e:	4b02      	ldr	r3, [pc, #8]	; (0x1498)
    1490:	e7f6      	b.n	0x1480
    1492:	bf00      	nop
    1494:	0010      	movs	r0, r2
    1496:	1000      	asrs	r0, r0, #32
    1498:	000c      	movs	r4, r1
    149a:	1000      	asrs	r0, r0, #32
    149c:	2801      	cmp	r0, #1
    149e:	d012      	beq.n	0x14c6
    14a0:	d302      	bcc.n	0x14a8
    14a2:	2802      	cmp	r0, #2
    14a4:	d018      	beq.n	0x14d8
    14a6:	4770      	bx	lr
    14a8:	4a10      	ldr	r2, [pc, #64]	; (0x14ec)
    14aa:	f643 73fc 	movw	r3, #16380	; 0x3ffc
    14ae:	b129      	cbz	r1, 0x14bc
    14b0:	6811      	ldr	r1, [r2, #0]
    14b2:	58ca      	ldr	r2, [r1, r3]
    14b4:	f042 0201 	orr.w	r2, r2, #1
    14b8:	50ca      	str	r2, [r1, r3]
    14ba:	4770      	bx	lr
    14bc:	6811      	ldr	r1, [r2, #0]
    14be:	58ca      	ldr	r2, [r1, r3]
    14c0:	f022 0201 	bic.w	r2, r2, #1
    14c4:	e7f8      	b.n	0x14b8
    14c6:	f643 73fc 	movw	r3, #16380	; 0x3ffc
    14ca:	4a08      	ldr	r2, [pc, #32]	; (0x14ec)
    14cc:	b141      	cbz	r1, 0x14e0
    14ce:	6811      	ldr	r1, [r2, #0]
    14d0:	58ca      	ldr	r2, [r1, r3]
    14d2:	f042 0202 	orr.w	r2, r2, #2
    14d6:	e7ef      	b.n	0x14b8
    14d8:	f643 73fc 	movw	r3, #16380	; 0x3ffc
    14dc:	4a04      	ldr	r2, [pc, #16]	; (0x14f0)
    14de:	e7f5      	b.n	0x14cc
    14e0:	6811      	ldr	r1, [r2, #0]
    14e2:	58ca      	ldr	r2, [r1, r3]
    14e4:	f022 0202 	bic.w	r2, r2, #2
    14e8:	e7e6      	b.n	0x14b8
    14ea:	bf00      	nop
    14ec:	0010      	movs	r0, r2
    14ee:	1000      	asrs	r0, r0, #32
    14f0:	000c      	movs	r4, r1
    14f2:	1000      	asrs	r0, r0, #32
    14f4:	4b02      	ldr	r3, [pc, #8]	; (0x1500)
    14f6:	681b      	ldr	r3, [r3, #0]
    14f8:	6958      	ldr	r0, [r3, #20]
    14fa:	f000 0001 	and.w	r0, r0, #1
    14fe:	4770      	bx	lr
    1500:	001c      	movs	r4, r3
    1502:	1000      	asrs	r0, r0, #32
    1504:	4b02      	ldr	r3, [pc, #8]	; (0x1510)
    1506:	681b      	ldr	r3, [r3, #0]
    1508:	6958      	ldr	r0, [r3, #20]
    150a:	f3c0 1040 	ubfx	r0, r0, #5, #1
    150e:	4770      	bx	lr
    1510:	001c      	movs	r4, r3
    1512:	1000      	asrs	r0, r0, #32
    1514:	b508      	push	{r3, lr}
    1516:	b910      	cbnz	r0, 0x151e
    1518:	f7ff ffec 	bl	0x14f4
    151c:	e7fb      	b.n	0x1516
    151e:	4b02      	ldr	r3, [pc, #8]	; (0x1528)
    1520:	681b      	ldr	r3, [r3, #0]
    1522:	6818      	ldr	r0, [r3, #0]
    1524:	b2c0      	uxtb	r0, r0
    1526:	bd08      	pop	{r3, pc}
    1528:	001c      	movs	r4, r3
    152a:	1000      	asrs	r0, r0, #32
    152c:	b508      	push	{r3, lr}
    152e:	b118      	cbz	r0, 0x1538
    1530:	4b03      	ldr	r3, [pc, #12]	; (0x1540)
    1532:	681b      	ldr	r3, [r3, #0]
    1534:	6019      	str	r1, [r3, #0]
    1536:	bd08      	pop	{r3, pc}
    1538:	f7ff ffe4 	bl	0x1504
    153c:	e7f7      	b.n	0x152e
    153e:	bf00      	nop
    1540:	001c      	movs	r4, r3
    1542:	1000      	asrs	r0, r0, #32
    1544:	e92d 41f0 	stmdb	sp!, {r4, r5, r6, r7, r8, lr}
    1548:	2520      	movs	r5, #32
    154a:	ea41 0e40 	orr.w	lr, r1, r0, lsl #1
    154e:	f04f 0c3c 	mov.w	ip, #60	; 0x3c
    1552:	2704      	movs	r7, #4
    1554:	2138      	movs	r1, #56	; 0x38
    1556:	f04f 0824 	mov.w	r8, #36	; 0x24
    155a:	2018      	movs	r0, #24
    155c:	4e37      	ldr	r6, [pc, #220]	; (0x163c)
    155e:	6834      	ldr	r4, [r6, #0]
    1560:	6025      	str	r5, [r4, #0]
    1562:	6834      	ldr	r4, [r6, #0]
    1564:	6865      	ldr	r5, [r4, #4]
    1566:	f005 05f8 	and.w	r5, r5, #248	; 0xf8
    156a:	2d28      	cmp	r5, #40	; 0x28
    156c:	d03b      	beq.n	0x15e6
    156e:	d815      	bhi.n	0x159c
    1570:	2d10      	cmp	r5, #16
    1572:	d003      	beq.n	0x157c
    1574:	d807      	bhi.n	0x1586
    1576:	b30d      	cbz	r5, 0x15bc
    1578:	2d08      	cmp	r5, #8
    157a:	d1f3      	bne.n	0x1564
    157c:	f8c4 e008 	str.w	lr, [r4, #8]
    1580:	6027      	str	r7, [r4, #0]
    1582:	61a0      	str	r0, [r4, #24]
    1584:	e7ed      	b.n	0x1562
    1586:	2d18      	cmp	r5, #24
    1588:	d01f      	beq.n	0x15ca
    158a:	2d20      	cmp	r5, #32
    158c:	d1ea      	bne.n	0x1564
    158e:	2314      	movs	r3, #20
    1590:	6023      	str	r3, [r4, #0]
    1592:	2328      	movs	r3, #40	; 0x28
    1594:	2002      	movs	r0, #2
    1596:	61a3      	str	r3, [r4, #24]
    1598:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
    159c:	2d40      	cmp	r5, #64	; 0x40
    159e:	d02f      	beq.n	0x1600
    15a0:	d806      	bhi.n	0x15b0
    15a2:	2d30      	cmp	r5, #48	; 0x30
    15a4:	d025      	beq.n	0x15f2
    15a6:	2d38      	cmp	r5, #56	; 0x38
    15a8:	d1dc      	bne.n	0x1564
    15aa:	f8c4 8000 	str.w	r8, [r4]
    15ae:	e7e8      	b.n	0x1582
    15b0:	2d50      	cmp	r5, #80	; 0x50
    15b2:	d02c      	beq.n	0x160e
    15b4:	2d58      	cmp	r5, #88	; 0x58
    15b6:	d037      	beq.n	0x1628
    15b8:	2d48      	cmp	r5, #72	; 0x48
    15ba:	e7e7      	b.n	0x158c
    15bc:	2314      	movs	r3, #20
    15be:	6023      	str	r3, [r4, #0]
    15c0:	2328      	movs	r3, #40	; 0x28
    15c2:	2001      	movs	r0, #1
    15c4:	61a3      	str	r3, [r4, #24]
    15c6:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
    15ca:	b12b      	cbz	r3, 0x15d8
    15cc:	7815      	ldrb	r5, [r2, #0]
    15ce:	3201      	adds	r2, #1
    15d0:	60a5      	str	r5, [r4, #8]
    15d2:	6027      	str	r7, [r4, #0]
    15d4:	61a1      	str	r1, [r4, #24]
    15d6:	e7c4      	b.n	0x1562
    15d8:	2214      	movs	r2, #20
    15da:	6022      	str	r2, [r4, #0]
    15dc:	2228      	movs	r2, #40	; 0x28
    15de:	61a2      	str	r2, [r4, #24]
    15e0:	2000      	movs	r0, #0
    15e2:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
    15e6:	3b01      	subs	r3, #1
    15e8:	d1f0      	bne.n	0x15cc
    15ea:	2214      	movs	r2, #20
    15ec:	6022      	str	r2, [r4, #0]
    15ee:	61a5      	str	r5, [r4, #24]
    15f0:	e7f6      	b.n	0x15e0
    15f2:	2314      	movs	r3, #20
    15f4:	6023      	str	r3, [r4, #0]
    15f6:	2328      	movs	r3, #40	; 0x28
    15f8:	2003      	movs	r0, #3
    15fa:	61a3      	str	r3, [r4, #24]
    15fc:	e8bd 81f0 	ldmia.w	sp!, {r4, r5, r6, r7, r8, pc}
    1600:	2b01      	cmp	r3, #1
    1602:	bf8a      	itet	hi
    1604:	6027      	strhi	r7, [r4, #0]
    1606:	f8c4 c018 	strls.w	ip, [r4, #24]
    160a:	61a1      	strhi	r1, [r4, #24]
    160c:	e7a9      	b.n	0x1562
    160e:	68a4      	ldr	r4, [r4, #8]
    1610:	1c55      	adds	r5, r2, #1
    1612:	7014      	strb	r4, [r2, #0]
    1614:	6832      	ldr	r2, [r6, #0]
    1616:	3b01      	subs	r3, #1
    1618:	2b01      	cmp	r3, #1
    161a:	bf8a      	itet	hi
    161c:	6017      	strhi	r7, [r2, #0]
    161e:	f8c2 c018 	strls.w	ip, [r2, #24]
    1622:	6191      	strhi	r1, [r2, #24]
    1624:	462a      	mov	r2, r5
    1626:	e79c      	b.n	0x1562
    1628:	b10b      	cbz	r3, 0x162e
    162a:	68a3      	ldr	r3, [r4, #8]
    162c:	7013      	strb	r3, [r2, #0]
    162e:	2214      	movs	r2, #20
    1630:	6833      	ldr	r3, [r6, #0]
    1632:	601a      	str	r2, [r3, #0]
    1634:	2228      	movs	r2, #40	; 0x28
    1636:	619a      	str	r2, [r3, #24]
    1638:	e7d2      	b.n	0x15e0
    163a:	bf00      	nop
    163c:	0020      	movs	r0, r4
    163e:	1000      	asrs	r0, r0, #32
    1640:	4613      	mov	r3, r2
    1642:	460a      	mov	r2, r1
    1644:	2101      	movs	r1, #1
    1646:	f7ff bf7d 	b.w	0x1544
    164a:	4613      	mov	r3, r2
    164c:	460a      	mov	r2, r1
    164e:	2100      	movs	r1, #0
    1650:	f7ff bf78 	b.w	0x1544
    1654:	b662      	cpsie	i
    1656:	4770      	bx	lr
    1658:	b672      	cpsid	i
    165a:	4770      	bx	lr
    165c:	4040      	eors	r0, r0
    165e:	4049      	eors	r1, r1
    1660:	f7fe fd14 	bl	0x8c
    1664:	e7fe      	b.n	0x1664
	...
    166e:	0000      	movs	r0, r0
    1670:	0c00      	lsrs	r0, r0, #16
    1672:	0108      	lsls	r0, r1, #4
    1674:	8000      	strh	r0, [r0, #0]
    1676:	4004      	ands	r4, r0
    1678:	4000      	ands	r0, r0
    167a:	4004      	ands	r4, r0
    167c:	0000      	movs	r0, r0
    167e:	5000      	str	r0, [r0, r0]
    1680:	0000      	movs	r0, r0
    1682:	5001      	str	r1, [r0, r0]
    1684:	0000      	movs	r0, r0
    1686:	5002      	str	r2, [r0, r0]
    1688:	0000      	movs	r0, r0
    168a:	5003      	str	r3, [r0, r0]
    168c:	8000      	strh	r0, [r0, #0]
    168e:	4000      	ands	r0, r0
    1690:	0000      	movs	r0, r0
    1692:	4000      	ands	r0, r0
    1694:	c000      	stmia	r0!, {}
    1696:	4003      	ands	r3, r0
    1698:	e000      	b.n	0x169c
    169a:	e000      	b.n	0x169e
