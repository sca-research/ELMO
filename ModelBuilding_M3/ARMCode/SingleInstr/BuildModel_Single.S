@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Mov-Instr-Mov Model Building
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

.syntax unified
.text
.thumb


.global ADD_1
.global ADDImm0_2
.global AND_3
.global CMP_4
.global CMPImm0_5
.global EOR_6
.global LDR_7
.global LDRB_8
.global LDRH_9
.global LSL_10
.global LSLImm1_11
.global LSR_12
.global LSRImm1_13
.global MOV_14
.global MOVImm0_15
.global MUL_16
.global ORR_17
.global ROR_18
.global STR_19
.global STRB_20
.global STRH_21
.global SUB_22
.global SUBImm0_23

.func ADD_1
ADD_1:

     push {r0-r7}
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
   str  r1, [r0, #0]
   movs r1, #0
   mov r8, r1
   @move first operand of instruction 1 back into r1
   mov r1, r11
   nop
   nop
   nop
   nop
   nop
   @3INSTRs
   mov  r1,r7     
   adds  r3,r4		@1:	0x19, 0x1b
   mov r5,r6    
   nop
   nop
   nop
   nop
   nop
   @End trigger
   str	r2, [r0, #0]
   mov r0, r10
   str	r3, [r0, #0]
   pop {r0-r7}
   bx lr

  .endfunc

.func ADDImm0_2
ADDImm0_2:
   push {r0-r7}
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
   str  r1, [r0, #0]
   movs r1, #0
   mov r8, r1
   @move first operand of instruction 1 back into r1
   mov r1, r11
   nop
   nop
   nop
   nop
   nop
   @3INSTRs
   mov  r1,r7     
   adds  r3,#0		@2:	0x33, 0x00
   mov r5,r6    
   nop
   nop
   nop
   nop
   nop
   @End trigger
   str	r2, [r0, #0]
   mov r0, r10
   str r3, [r0, #0]
   pop {r0-r7}
   bx lr

  .endfunc

.func AND_3
AND_3:
   push {r0-r7}
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
   str  r1, [r0, #0]
   movs r1, #0
   mov r8, r1
   @move first operand of instruction 1 back into r1
   mov r1, r11
   nop
   nop
   nop
   nop
   nop
   @3INSTRs
   mov  r1,r7     
   ands  r3,r4		@3:    0x40 ,0x23
   mov r5,r6    
   nop
   nop
   nop
   nop
   nop
   @End trigger
   str	r2, [r0, #0]
   mov r0, r10
   str r3, [r0, #0]
   pop {r0-r7}
   bx lr
  .endfunc




.func CMP_4
CMP_4:
   push {r0-r7}
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
   str  r1, [r0, #0]
   movs r1, #0
   mov r8, r1
   @move first operand of instruction 1 back into r1
   mov r1, r11
   nop
   nop
   nop
   nop
   nop
   @3INSTRs
   mov  r1,r7     
   cmp  r3,r4	@4:    0x42 ,0xa3
   mov r5,r6    
   nop
   nop
   nop
   nop
   nop
   @End trigger
   str	r2, [r0, #0]
   mov r0, r10
   str r3, [r0, #0]
   pop {r0-r7}
   bx lr
  .endfunc


.func CMPImm0_5
CMPImm0_5:
   push {r0-r7}
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
   str  r1, [r0, #0]
   movs r1, #0
   mov r8, r1
   @move first operand of instruction 1 back into r1
   mov r1, r11
   nop
   nop
   nop
   nop
   nop
   @3INSTRs
   mov  r1,r7     
   cmp  r3,#0	@5:	0x2b, 0x00
   mov r5,r6    
   nop
   nop
   nop
   nop
   nop
   @End trigger
   str	r2, [r0, #0]
   mov r0, r10
   str r3, [r0, #0]
   pop {r0-r7}
   bx lr
  .endfunc

.func EOR_6
EOR_6:
   push {r0-r7}
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
   str  r1, [r0, #0]
   movs r1, #0
   mov r8, r1
   @move first operand of instruction 1 back into r1
   mov r1, r11
   nop
   nop
   nop
   nop
   nop
   @3INSTRs
   mov  r1,r7     
   eors  r3,r4	@6:	0x40 ,0x63
   mov r5,r6    
   nop
   nop
   nop
   nop
   nop
   @End trigger
   str	r2, [r0, #0]
   mov r0, r10
   str r3, [r0, #0]
   pop {r0-r7}
   bx lr
  .endfunc

.func LDR_7
LDR_7:
   push {r0-r7}
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
   ldr r1, [r0, #24]	@@@extra lines for LDR/STR
   str r4, [r1]		@@@extra lines for LDR/STR
   mov r4, r1		@@@extra lines for LDR/STR
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
   str  r1, [r0, #0]
   movs r1, #0
   mov r8, r1
   @move first operand of instruction 1 back into r1
   mov r1, r11
   nop
   nop
   nop
   nop
   nop
   @3INSTRs
   mov  r1,r7     
   ldr  r3,[r4]    @7:	0x68 ,0x23
   mov r5,r6    
   nop
   nop
   nop
   nop
   nop
   @End trigger
   str	r2, [r0, #0]
   mov r0, r10
   str r3, [r0, #0]
   pop {r0-r7}
   bx lr
  .endfunc

.func LDRB_8
LDRB_8:
   push {r0-r7}
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
   ldr r1, [r0, #24]	@@@extra lines for LDR/STR
   str r4, [r1]		@@@extra lines for LDR/STR
   mov r4, r1		@@@extra lines for LDR/STR
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
   str  r1, [r0, #0]
   movs r1, #0
   mov r8, r1
   @move first operand of instruction 1 back into r1
   mov r1, r11
   nop
   nop
   nop
   nop
   nop
   @3INSTRs
   mov  r1,r7     
   ldrb r3,[r4]    @8:	0x78 ,0x23
   mov r5,r6    
   nop
   nop
   nop
   nop
   nop
   @End trigger
   str	r2, [r0, #0]
   mov r0, r10
   str r3, [r0, #0]
   pop {r0-r7}
   bx lr
  .endfunc

.func LDRH_9
LDRH_9:
   push {r0-r7}
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
   ldr r1, [r0, #24]	@@@extra lines for LDR/STR
   str r4, [r1]		@@@extra lines for LDR/STR
   mov r4, r1		@@@extra lines for LDR/STR
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
   str  r1, [r0, #0]
   movs r1, #0
   mov r8, r1
   @move first operand of instruction 1 back into r1
   mov r1, r11
   nop
   nop
   nop
   nop
   nop
   @3INSTRs
   mov  r1,r7     
   ldrh r3,[r4]    @9:	0x88 ,0x23
   mov r5,r6    
   nop
   nop
   nop
   nop
   nop
   @End trigger
   str	r2, [r0, #0]
   mov r0, r10
   str r3, [r0, #0]
   pop {r0-r7}
   bx lr
  .endfunc


.func LSL_10
LSL_10:
   push {r0-r7}
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
   str  r1, [r0, #0]
   movs r1, #0
   mov r8, r1
   @move first operand of instruction 1 back into r1
   mov r1, r11
   nop
   nop
   nop
   nop
   nop
   @3INSTRs
   mov  r1,r7     
   lsls r3,r4    @10:	0x40 ,0xa3
   mov r5,r6    
   nop
   nop
   nop
   nop
   nop
   @End trigger
   str	r2, [r0, #0]
   mov r0, r10
   str r3, [r0, #0]
   pop {r0-r7}
   bx lr
  .endfunc

.func LSLImm1_11
LSLImm1_11:
   push {r0-r7}
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
   str  r1, [r0, #0]
   movs r1, #0
   mov r8, r1
   @move first operand of instruction 1 back into r1
   mov r1, r11
   nop
   nop
   nop
   nop
   nop
   @3INSTRs
   mov  r1,r7     
   lsls r3,#1    @11:	0x00, 0x5b
   mov r5,r6    
   nop
   nop
   nop
   nop
   nop
   @End trigger
   str	r2, [r0, #0]
   mov r0, r10
   str r3, [r0, #0]
   pop {r0-r7}
   bx lr
  .endfunc

.func LSR_12
LSR_12:
   push {r0-r7}
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
   str  r1, [r0, #0]
   movs r1, #0
   mov r8, r1
   @move first operand of instruction 1 back into r1
   mov r1, r11
   nop
   nop
   nop
   nop
   nop
   @3INSTRs
   mov  r1,r7     
   lsrs r3,r4    @12:	0x40 ,0xe3
   mov r5,r6    
   nop
   nop
   nop
   nop
   nop
   @End trigger
   str	r2, [r0, #0]
   mov r0, r10
   str r3, [r0, #0]
   pop {r0-r7}
   bx lr
  .endfunc

.func LSRImm1_13
LSRImm1_13:
   push {r0-r7}
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
   str  r1, [r0, #0]
   movs r1, #0
   mov r8, r1
   @move first operand of instruction 1 back into r1
   mov r1, r11
   nop
   nop
   nop
   nop
   nop
   @3INSTRs
   mov  r1,r7     
   lsrs r3,#1    @13:	0x08, 0x5b
   mov r5,r6    
   nop
   nop
   nop
   nop
   nop
   @End trigger
   str	r2, [r0, #0]
   mov r0, r10
   str r3, [r0, #0]
   pop {r0-r7}
   bx lr
  .endfunc

.func MOV_14
MOV_14:
   push {r0-r7}
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
   str  r1, [r0, #0]
   movs r1, #0
   mov r8, r1
   @move first operand of instruction 1 back into r1
   mov r1, r11
   nop
   nop
   nop
   nop
   nop
   @3INSTRs
   mov  r1,r7     
   mov  r3,r4    @14:	0x46, 0x23
   mov r5,r6    
   nop
   nop
   nop
   nop
   nop
   @End trigger
   str	r2, [r0, #0]
   mov r0, r10
   str r3, [r0, #0]
   pop {r0-r7}
   bx lr
  .endfunc

.func MOVImm0_15
MOVImm0_15:
   push {r0-r7}
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
   str  r1, [r0, #0]
   movs r1, #0
   mov r8, r1
   @move first operand of instruction 1 back into r1
   mov r1, r11
   nop
   nop
   nop
   nop
   nop
   @3INSTRs
   mov  r1,r7     
   movs  r3,#0    @15:	0x23, 0x00
   mov r5,r6    
   nop
   nop
   nop
   nop
   nop
   @End trigger
   str	r2, [r0, #0]
   mov r0, r10
   str r3, [r0, #0]
   pop {r0-r7}
   bx lr
  .endfunc

.func MUL_16
MUL_16:
   push {r0-r7}
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
   str  r1, [r0, #0]
   movs r1, #0
   mov r8, r1
   @move first operand of instruction 1 back into r1
   mov r1, r11
   nop
   nop
   nop
   nop
   nop
   @3INSTRs
   mov  r1,r7     
   muls  r3,r4    @16:	0x43 ,0x63
   mov r5,r6    
   nop
   nop
   nop
   nop
   nop
   @End trigger
   str	r2, [r0, #0]
   mov r0, r10
   str r3, [r0, #0]
   pop {r0-r7}
   bx lr
  .endfunc

.func ORR_17
ORR_17:
   push {r0-r7}
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
   str  r1, [r0, #0]
   movs r1, #0
   mov r8, r1
   @move first operand of instruction 1 back into r1
   mov r1, r11
   nop
   nop
   nop
   nop
   nop
   @3INSTRs
   mov  r1,r7     
   orrs  r3,r4    @17:	0x43 ,0x23
   mov r5,r6    
   nop
   nop
   nop
   nop
   nop
   @End trigger
   str	r2, [r0, #0]
   mov r0, r10
   str r3, [r0, #0]
   pop {r0-r7}
   bx lr
  .endfunc

.func ROR_18
ROR_18:
   push {r0-r7}
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
   str  r1, [r0, #0]
   movs r1, #0
   mov r8, r1
   @move first operand of instruction 1 back into r1
   mov r1, r11
   nop
   nop
   nop
   nop
   nop
   @3INSTRs
   mov  r1,r7     
   rors  r3,r4    @18:	0x41 ,0xe3
   mov r5,r6    
   nop
   nop
   nop
   nop
   nop
   @End trigger
   str	r2, [r0, #0]
   mov r0, r10
   str r3, [r0, #0]
   pop {r0-r7}
   bx lr
  .endfunc

.func STR_19
STR_19:
   push {r0-r7}
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
   ldr r1, [r0, #24]	@@@extra lines for LDR/STR
   str r4, [r1]		@@@extra lines for LDR/STR
   mov r4, r1		@@@extra lines for LDR/STR
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
   str  r1, [r0, #0]
   movs r1, #0
   mov r8, r1
   @move first operand of instruction 1 back into r1
   mov r1, r11
   nop
   nop
   nop
   nop
   nop
   @3INSTRs
   mov  r1,r7     
   str  r3,[r4]    @19:	0x60 ,0x23
   mov r5,r6    
   nop
   nop
   nop
   nop
   nop
   @End trigger
   str	r2, [r0, #0]
   mov r0, r10
   str r3, [r0, #0]
   pop {r0-r7}
   bx lr
  .endfunc

.func STRB_20
STRB_20:
   push {r0-r7}
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
   ldr r1, [r0, #24]	@@@extra lines for LDR/STR
   str r4, [r1]		@@@extra lines for LDR/STR
   mov r4, r1		@@@extra lines for LDR/STR
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
   str  r1, [r0, #0]
   movs r1, #0
   mov r8, r1
   @move first operand of instruction 1 back into r1
   mov r1, r11
   nop
   nop
   nop
   nop
   nop
   @3INSTRs
   mov  r1,r7     
   strb  r3,[r4]    @20:	0x70 ,0x23
   mov r5,r6    
   nop
   nop
   nop
   nop
   nop
   @End trigger
   str	r2, [r0, #0]
   mov r0, r10
   str r3, [r0, #0]
   pop {r0-r7}
   bx lr
  .endfunc

.func STRH_21
STRH_21:
   push {r0-r7}
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
   ldr r1, [r0, #24]	@@@extra lines for LDR/STR
   str r4, [r1]		@@@extra lines for LDR/STR
   mov r4, r1		@@@extra lines for LDR/STR
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
   str  r1, [r0, #0]
   movs r1, #0
   mov r8, r1
   @move first operand of instruction 1 back into r1
   mov r1, r11
   nop
   nop
   nop
   nop
   nop
   @3INSTRs
   mov  r1,r7     
   strh  r3,[r4]    @21:	0x80 ,0x23
   mov r5,r6    
   nop
   nop
   nop
   nop
   nop
   @End trigger
   str	r2, [r0, #0]
   mov r0, r10
   str r3, [r0, #0]
   pop {r0-r7}
   bx lr
  .endfunc

.func SUB_22
SUB_22:
   push {r0-r7}
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
   str  r1, [r0, #0]
   movs r1, #0
   mov r8, r1
   @move first operand of instruction 1 back into r1
   mov r1, r11
   nop
   nop
   nop
   nop
   nop
   @3INSTRs
   mov  r1,r7     
   subs  r3,r4   @22:   0x1b ,0x1b
   mov r5,r6    
   nop
   nop
   nop
   nop
   nop
   @End trigger
   str	r2, [r0, #0]
   mov r0, r10
   str r3, [r0, #0]
   pop {r0-r7}
   bx lr
  .endfunc

.func SUBImm0_23
SUBImm0_23:
   push {r0-r7}
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
   str  r1, [r0, #0]
   movs r1, #0
   mov r8, r1
   @move first operand of instruction 1 back into r1
   mov r1, r11
   nop
   nop
   nop
   nop
   nop
   @3INSTRs
   mov  r1,r7     
   subs  r3,#0  @23:	0x3b, 0x00
   mov r5,r6    
   nop
   nop
   nop
   nop
   nop
   @End trigger
   str	r2, [r0, #0]
   mov r0, r10
   str r3, [r0, #0]
   pop {r0-r7}
   bx lr
  .endfunc
  .end

  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
  @QUICK_END:
  @
  @  b.n endtrig
  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
