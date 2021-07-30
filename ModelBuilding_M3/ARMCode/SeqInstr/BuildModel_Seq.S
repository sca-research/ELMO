@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Mov-Instr-Mov Model Building
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

.syntax unified
.text
.thumb

.global Intro

.func Intro
Intro:
     push {r0-r11}
   @Load and prepare the data
   @Use r1 in trigger, so store r1 in r11 first
   ldr r1, [r0, #0]
   mov r11, r1
   mov r10, r0
   ldr r7, [r0, #4]
   ldr r3, [r0, #8]
   ldr r4, [r0, #12]
   ldr r5, [r0, #16]
   ldr r6, [r0, #20]
   ldrb r1, [r0, #28]	@Get Instr Code
   movs r2,#32
   muls r1,r2            @Transfer Instr Code to offset
   movs r2,#16           @Add 16 to offset so that jump won't different time
   adds r1,r2
   mov r9,r1	        @Get Store Instr Offset in r9

   ldr r1, [r0, #24]	@@@r1=addr
   ldrb r2, [r0, #29]	@@@load flag for instr1:1 str/ldr, 0 normal
   cmp r2,#1
   bne next
   str r7, [r1]		@@@instr1=LDR/STR
   mov r7, r1		@@@instr1=LDR/STR
next:
   ldrb r2, [r0, #30]	@@@load flag for instr2:1 str/ldr, 0 normal
   cmp r2,#1
   bne next1
   str r4, [r1,#4]	@@@instr2=LDR/STR
   mov r4, r1		@@@instr2=LDR/STR
next1:
   ldrb r2, [r0, #31]	@@@load flag for instr3:1 str/ldr, 0 normal
   cmp r2,#1
   bne next2
   str r6, [r1,#8]		@@@extra lines for LDR/STR
   mov r6, r1		@@@extra lines for LDR/STR
next2:
   nop
   nop
   nop
   nop
Mid:
   @Start of trigger
   @Trigger address: 0x50013FFC
  movs r0, #80
   lsls r0, r0, #24
   movs r1, #1
   lsls r1, #16
   eors r0, r1
   movs r1, #63
   lsls r1,r1,#8
   eors r0,r1
   movs r1, #252
   eors r0,r1
   movs r1,#1
   ldr  r2, [r0, #0]
   eors r1, r2
   @trigger up
   str  r1, [r0, #0]
   @Zero r8 for nop
   movs r1, #0
   mov r8, r1
   @Get the entrance point
   mov r1, r9
   add PC,r1    
   nop
   @move first operand of instruction 1 back into r1
      nop
      nop
      nop
      nop
      nop
      nop
      nop
      nop
@Triplets_0_0_0
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      eors r1, r7
      eors r3, r4
      eors r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_0_0_0
@Triplets_0_0_1
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      eors r1, r7
      eors r3, r4
      lsls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_0_0_1
@Triplets_0_0_2
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      eors r1, r7
      eors r3, r4
      str r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_0_0_2
@Triplets_0_0_3
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      eors r1, r7
      eors r3, r4
      ldr r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_0_0_3
@Triplets_0_0_4
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      eors r1, r7
      eors r3, r4
      muls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_0_0_4
@Triplets_0_1_0
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      eors r1, r7
      lsls r3, r4
      eors r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_0_1_0
@Triplets_0_1_1
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      eors r1, r7
      lsls r3, r4
      lsls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_0_1_1
@Triplets_0_1_2
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      eors r1, r7
      lsls r3, r4
      str r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_0_1_2
@Triplets_0_1_3
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      eors r1, r7
      lsls r3, r4
      ldr r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_0_1_3
@Triplets_0_1_4
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      eors r1, r7
      lsls r3, r4
      muls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_0_1_4
@Triplets_0_2_0
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      eors r1, r7
      str r3, [r4,#4]
      eors r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_0_2_0
@Triplets_0_2_1
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      eors r1, r7
      str r3, [r4,#4]
      lsls r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_0_2_1
@Triplets_0_2_2
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      eors r1, r7
      str r3, [r4,#4]
      str r5, [r6,#8]
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_0_2_2
@Triplets_0_2_3
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      eors r1, r7
      str r3, [r4,#4]
      ldr r5, [r6,#8]
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_0_2_3
@Triplets_0_2_4
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      eors r1, r7
      str r3, [r4,#4]
      muls r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_0_2_4
@Triplets_0_3_0
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      eors r1, r7
      ldr r3, [r4,#4]
      eors r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_0_3_0
@Triplets_0_3_1
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      eors r1, r7
      ldr r3, [r4,#4]
      lsls r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_0_3_1
@Triplets_0_3_2
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      eors r1, r7
      ldr r3, [r4,#4]
      str r5, [r6,#8]
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_0_3_2
@Triplets_0_3_3
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      eors r1, r7
      ldr r3, [r4,#4]
      ldr r5, [r6,#8]
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_0_3_3
@Triplets_0_3_4
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      eors r1, r7
      ldr r3, [r4,#4]
      muls r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_0_3_4
@Triplets_0_4_0
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      eors r1, r7
      muls r3, r4
      eors r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_0_4_0
@Triplets_0_4_1
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      eors r1, r7
      muls r3, r4
      lsls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_0_4_1
@Triplets_0_4_2
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      eors r1, r7
      muls r3, r4
      str r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_0_4_2
@Triplets_0_4_3
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      eors r1, r7
      muls r3, r4
      ldr r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_0_4_3
@Triplets_0_4_4
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      eors r1, r7
      muls r3, r4
      muls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_0_4_4
@Triplets_1_0_0
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      lsls r1, r7
      eors r3, r4
      eors r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_1_0_0
@Triplets_1_0_1
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      lsls r1, r7
      eors r3, r4
      lsls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_1_0_1
@Triplets_1_0_2
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      lsls r1, r7
      eors r3, r4
      str r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_1_0_2
@Triplets_1_0_3
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      lsls r1, r7
      eors r3, r4
      ldr r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_1_0_3
@Triplets_1_0_4
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      lsls r1, r7
      eors r3, r4
      muls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_1_0_4
@Triplets_1_1_0
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      lsls r1, r7
      lsls r3, r4
      eors r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_1_1_0
@Triplets_1_1_1
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      lsls r1, r7
      lsls r3, r4
      lsls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_1_1_1
@Triplets_1_1_2
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      lsls r1, r7
      lsls r3, r4
      str r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_1_1_2
@Triplets_1_1_3
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      lsls r1, r7
      lsls r3, r4
      ldr r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_1_1_3
@Triplets_1_1_4
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      lsls r1, r7
      lsls r3, r4
      muls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_1_1_4
@Triplets_1_2_0
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      lsls r1, r7
      str r3, [r4,#4]
      eors r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_1_2_0
@Triplets_1_2_1
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      lsls r1, r7
      str r3, [r4,#4]
      lsls r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_1_2_1
@Triplets_1_2_2
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      lsls r1, r7
      str r3, [r4,#4]
      str r5, [r6,#8]
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_1_2_2
@Triplets_1_2_3
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      lsls r1, r7
      str r3, [r4,#4]
      ldr r5, [r6,#8]
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_1_2_3
@Triplets_1_2_4
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      lsls r1, r7
      str r3, [r4,#4]
      muls r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_1_2_4
@Triplets_1_3_0
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      lsls r1, r7
      ldr r3, [r4,#4]
      eors r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_1_3_0
@Triplets_1_3_1
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      lsls r1, r7
      ldr r3, [r4,#4]
      lsls r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_1_3_1
@Triplets_1_3_2
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      lsls r1, r7
      ldr r3, [r4,#4]
      str r5, [r6,#8]
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_1_3_2
@Triplets_1_3_3
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      lsls r1, r7
      ldr r3, [r4,#4]
      ldr r5, [r6,#8]
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_1_3_3
@Triplets_1_3_4
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      lsls r1, r7
      ldr r3, [r4,#4]
      muls r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_1_3_4
@Triplets_1_4_0
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      lsls r1, r7
      muls r3, r4
      eors r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_1_4_0
@Triplets_1_4_1
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      lsls r1, r7
      muls r3, r4
      lsls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_1_4_1
@Triplets_1_4_2
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      lsls r1, r7
      muls r3, r4
      str r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_1_4_2
@Triplets_1_4_3
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      lsls r1, r7
      muls r3, r4
      ldr r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_1_4_3
@Triplets_1_4_4
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      lsls r1, r7
      muls r3, r4
      muls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_1_4_4
@Triplets_2_0_0
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      str r1, [r7]
      eors r3, r4
      eors r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_2_0_0
@Triplets_2_0_1
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      str r1, [r7]
      eors r3, r4
      lsls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_2_0_1
@Triplets_2_0_2
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      str r1, [r7]
      eors r3, r4
      str r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_2_0_2
@Triplets_2_0_3
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      str r1, [r7]
      eors r3, r4
      ldr r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_2_0_3
@Triplets_2_0_4
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      str r1, [r7]
      eors r3, r4
      muls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_2_0_4
@Triplets_2_1_0
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      str r1, [r7]
      lsls r3, r4
      eors r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_2_1_0
@Triplets_2_1_1
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      str r1, [r7]
      lsls r3, r4
      lsls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_2_1_1
@Triplets_2_1_2
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      str r1, [r7]
      lsls r3, r4
      str r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_2_1_2
@Triplets_2_1_3
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      str r1, [r7]
      lsls r3, r4
      ldr r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_2_1_3
@Triplets_2_1_4
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      str r1, [r7]
      lsls r3, r4
      muls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_2_1_4
@Triplets_2_2_0
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      str r1, [r7]
      str r3, [r4,#4]
      eors r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_2_2_0
@Triplets_2_2_1
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      str r1, [r7]
      str r3, [r4,#4]
      lsls r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_2_2_1
@Triplets_2_2_2
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      str r1, [r7]
      str r3, [r4,#4]
      str r5, [r6,#8]
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_2_2_2
@Triplets_2_2_3
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      str r1, [r7]
      str r3, [r4,#4]
      ldr r5, [r6,#8]
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_2_2_3
@Triplets_2_2_4
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      str r1, [r7]
      str r3, [r4,#4]
      muls r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_2_2_4
@Triplets_2_3_0
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      str r1, [r7]
      ldr r3, [r4,#4]
      eors r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_2_3_0
@Triplets_2_3_1
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      str r1, [r7]
      ldr r3, [r4,#4]
      lsls r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_2_3_1
@Triplets_2_3_2
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      str r1, [r7]
      ldr r3, [r4,#4]
      str r5, [r6,#8]
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_2_3_2
@Triplets_2_3_3
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      str r1, [r7]
      ldr r3, [r4,#4]
      ldr r5, [r6,#8]
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_2_3_3
@Triplets_2_3_4
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      str r1, [r7]
      ldr r3, [r4,#4]
      muls r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_2_3_4
@Triplets_2_4_0
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      str r1, [r7]
      muls r3, r4
      eors r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_2_4_0
@Triplets_2_4_1
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      str r1, [r7]
      muls r3, r4
      lsls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_2_4_1
@Triplets_2_4_2
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      str r1, [r7]
      muls r3, r4
      str r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_2_4_2
@Triplets_2_4_3
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      str r1, [r7]
      muls r3, r4
      ldr r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_2_4_3
@Triplets_2_4_4
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      str r1, [r7]
      muls r3, r4
      muls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_2_4_4
@Triplets_3_0_0
      mov r1, r11
      nop
      nop
      nop
      nop
      ldr r1, [r7]
      eors r3, r4
      eors r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_3_0_0
@Triplets_3_0_1
      mov r1, r11
      nop
      nop
      nop
      nop
      ldr r1, [r7]
      eors r3, r4
      lsls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_3_0_1
@Triplets_3_0_2
      mov r1, r11
      nop
      nop
      nop
      nop
      ldr r1, [r7]
      eors r3, r4
      str r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_3_0_2
@Triplets_3_0_3
      mov r1, r11
      nop
      nop
      nop
      nop
      ldr r1, [r7]
      eors r3, r4
      ldr r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_3_0_3
@Triplets_3_0_4
      mov r1, r11
      nop
      nop
      nop
      nop
      ldr r1, [r7]
      eors r3, r4
      muls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_3_0_4
@Triplets_3_1_0
      mov r1, r11
      nop
      nop
      nop
      nop
      ldr r1, [r7]
      lsls r3, r4
      eors r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_3_1_0
@Triplets_3_1_1
      mov r1, r11
      nop
      nop
      nop
      nop
      ldr r1, [r7]
      lsls r3, r4
      lsls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_3_1_1
@Triplets_3_1_2
      mov r1, r11
      nop
      nop
      nop
      nop
      ldr r1, [r7]
      lsls r3, r4
      str r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_3_1_2
@Triplets_3_1_3
      mov r1, r11
      nop
      nop
      nop
      nop
      ldr r1, [r7]
      lsls r3, r4
      ldr r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_3_1_3
@Triplets_3_1_4
      mov r1, r11
      nop
      nop
      nop
      nop
      ldr r1, [r7]
      lsls r3, r4
      muls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_3_1_4
@Triplets_3_2_0
      mov r1, r11
      nop
      nop
      nop
      nop
      ldr r1, [r7]
      str r3, [r4,#4]
      eors r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_3_2_0
@Triplets_3_2_1
      mov r1, r11
      nop
      nop
      nop
      nop
      ldr r1, [r7]
      str r3, [r4,#4]
      lsls r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_3_2_1
@Triplets_3_2_2
      mov r1, r11
      nop
      nop
      nop
      nop
      ldr r1, [r7]
      str r3, [r4,#4]
      str r5, [r6,#8]
      nop
      nop
      nop
      b.w Finish
      nop
      nop
      nop
@Triplets_3_2_2
@Triplets_3_2_3
      mov r1, r11
      nop
      nop
      nop
      nop
      ldr r1, [r7]
      str r3, [r4,#4]
      ldr r5, [r6,#8]
      nop
      nop
      nop
      b.w Finish
      nop
      nop
      nop
@Triplets_3_2_3
@Triplets_3_2_4
      mov r1, r11
      nop
      nop
      nop
      nop
      ldr r1, [r7]
      str r3, [r4,#4]
      muls r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_3_2_4
@Triplets_3_3_0
      mov r1, r11
      nop
      nop
      nop
      nop
      ldr r1, [r7]
      ldr r3, [r4,#4]
      eors r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_3_3_0
@Triplets_3_3_1
      mov r1, r11
      nop
      nop
      nop
      nop
      ldr r1, [r7]
      ldr r3, [r4,#4]
      lsls r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_3_3_1
@Triplets_3_3_2
      mov r1, r11
      nop
      nop
      nop
      nop
      ldr r1, [r7]
      ldr r3, [r4,#4]
      str r5, [r6,#8]
      nop
      nop
      nop
      b.w Finish
      nop
      nop
      nop
@Triplets_3_3_2
@Triplets_3_3_3
      mov r1, r11
      nop
      nop
      nop
      nop
      ldr r1, [r7]
      ldr r3, [r4,#4]
      ldr r5, [r6,#8]
      nop
      nop
      nop
      b.w Finish
      nop
      nop
      nop
@Triplets_3_3_3
@Triplets_3_3_4
      mov r1, r11
      nop
      nop
      nop
      nop
      ldr r1, [r7]
      ldr r3, [r4,#4]
      muls r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_3_3_4
@Triplets_3_4_0
      mov r1, r11
      nop
      nop
      nop
      nop
      ldr r1, [r7]
      muls r3, r4
      eors r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_3_4_0
@Triplets_3_4_1
      mov r1, r11
      nop
      nop
      nop
      nop
      ldr r1, [r7]
      muls r3, r4
      lsls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_3_4_1
@Triplets_3_4_2
      mov r1, r11
      nop
      nop
      nop
      nop
      ldr r1, [r7]
      muls r3, r4
      str r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_3_4_2
@Triplets_3_4_3
      mov r1, r11
      nop
      nop
      nop
      nop
      ldr r1, [r7]
      muls r3, r4
      ldr r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_3_4_3
@Triplets_3_4_4
      mov r1, r11
      nop
      nop
      nop
      nop
      ldr r1, [r7]
      muls r3, r4
      muls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_3_4_4
@Triplets_4_0_0
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      muls r1, r7
      eors r3, r4
      eors r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_4_0_0
@Triplets_4_0_1
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      muls r1, r7
      eors r3, r4
      lsls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_4_0_1
@Triplets_4_0_2
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      muls r1, r7
      eors r3, r4
      str r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_4_0_2
@Triplets_4_0_3
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      muls r1, r7
      eors r3, r4
      ldr r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_4_0_3
@Triplets_4_0_4
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      muls r1, r7
      eors r3, r4
      muls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_4_0_4
@Triplets_4_1_0
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      muls r1, r7
      lsls r3, r4
      eors r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_4_1_0
@Triplets_4_1_1
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      muls r1, r7
      lsls r3, r4
      lsls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_4_1_1
@Triplets_4_1_2
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      muls r1, r7
      lsls r3, r4
      str r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_4_1_2
@Triplets_4_1_3
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      muls r1, r7
      lsls r3, r4
      ldr r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_4_1_3
@Triplets_4_1_4
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      muls r1, r7
      lsls r3, r4
      muls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_4_1_4
@Triplets_4_2_0
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      muls r1, r7
      str r3, [r4,#4]
      eors r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_4_2_0
@Triplets_4_2_1
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      muls r1, r7
      str r3, [r4,#4]
      lsls r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_4_2_1
@Triplets_4_2_2
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      muls r1, r7
      str r3, [r4,#4]
      str r5, [r6,#8]
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_4_2_2
@Triplets_4_2_3
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      muls r1, r7
      str r3, [r4,#4]
      ldr r5, [r6,#8]
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_4_2_3
@Triplets_4_2_4
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      muls r1, r7
      str r3, [r4,#4]
      muls r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_4_2_4
@Triplets_4_3_0
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      muls r1, r7
      ldr r3, [r4,#4]
      eors r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_4_3_0
@Triplets_4_3_1
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      muls r1, r7
      ldr r3, [r4,#4]
      lsls r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_4_3_1
@Triplets_4_3_2
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      muls r1, r7
      ldr r3, [r4,#4]
      str r5, [r6,#8]
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_4_3_2
@Triplets_4_3_3
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      muls r1, r7
      ldr r3, [r4,#4]
      ldr r5, [r6,#8]
      nop
      nop
      nop
      b.w Finish
      nop
      nop
@Triplets_4_3_3
@Triplets_4_3_4
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      muls r1, r7
      ldr r3, [r4,#4]
      muls r5, r6
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_4_3_4
@Triplets_4_4_0
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      muls r1, r7
      muls r3, r4
      eors r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_4_4_0
@Triplets_4_4_1
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      muls r1, r7
      muls r3, r4
      lsls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_4_4_1
@Triplets_4_4_2
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      muls r1, r7
      muls r3, r4
      str r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_4_4_2
@Triplets_4_4_3
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      muls r1, r7
      muls r3, r4
      ldr r5, [r6,#8]
      nop
      nop
      nop
      nop
      b.w Finish
      nop
@Triplets_4_4_3
@Triplets_4_4_4
      mov r1, r11
      nop
      nop
      nop
      nop
      nop
      muls r1, r7
      muls r3, r4
      muls r5, r6
      nop
      nop
      nop
      nop
      nop
      b.w Finish
@Triplets_4_4_4
Finish:
   @End trigger
   str	r2, [r0, #0]
   mov  r0, r10
   str  r3, [r0, #0]
   pop {r0-r11}
   bx lr
.endfunc


  .end

  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  @QUICK_END:
  @
  @  b.n endtrig
  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
