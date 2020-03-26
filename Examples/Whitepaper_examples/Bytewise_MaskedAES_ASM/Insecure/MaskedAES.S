
  .syntax unified
  .text
  .thumb
  
  .extern S
  .extern MaskedS
  .extern xtime
  .extern rcon

  .extern U
  .extern V
  .extern UV

.global GenMaskedSbox
.func GenMaskedSbox
GenMaskedSbox:
  push {lr}
  push {r0-r7}

  ldr r0, =U
  ldrb r1, [r0]
  ldr r0, =V
  ldrb r2, [r0]
  @r1=U, r2=V
  @Create variable UV
  ldr r0, =UV
  eors r2, r1
  strb r2, [r0]
  @UV=V^U=r2
  movs r3, #255
  ldr r4, =S
  ldr r5, =MaskedS

 masksbox:		@Create masked table
  mov r0, r2		@r0=UV
  eors r0, r3		@r0=UV^i
  ldrb r6, [ r4, r0]	@r6=S[UV^i]
  eors r6, r1		@r6=S[UV^i]^U
  strb r6, [ r5, r3 ]	@MS[i]=S[UV^i]^U
  subs r3, #1		@i--
  bge.n masksbox
  
  pop {r0-r7}
  pop {pc}
  .endfunc


.global MaskingPlaintext
.func MaskingPlaintext

MaskingPlaintext:
  push {lr}
  push {r0-r7}

  ldr r3, =U
  ldrb r3, [r3]		@r3=U
  @ldr r2, =SRMask@Additional Mask 

  # Arrange data and key so they can be loaded in words
  movs r5, #15
arrangedatamasked:	@change the byte order to AES column first order, masked them with U at the same time
  lsls r6, r5, #2	@r6=(r5)<<2
  movs r7, #0x0C	@r7=0x0c
  ands r6, r7		@r6=(r5) low two bits in the last nibble
  lsrs r7, r5, #2	@r7=(r5)>>2
  eors r6, r7		@r6=(r5) low two bits in the last nibble||(r5) high two bits in the last nibble 
  ldrb r7, [r0, r6]	@load input to r7
  eors r7, r3		@mask input with U
  @movs r4, #3
  @ands r4, r5           @low 2 bits of r5
  @ldrb r4, [r2, r4]     @Load additional mask
  @eors r7, r4           @Add additional mask
  strb r7, [r1, r5]	@store the masked value to output
  subs r5, #1		@proceed to other bytes
  bge.n arrangedatamasked

  pop {r0-r7}
  pop {pc}
  .endfunc

.global MaskingKey
.func MaskingKey
MaskingKey:
  push {lr}
  push {r0-r7}

  ldr r3, =V
  ldrb r2, [r3]

  movs r5, #15
arrangedatakeymasked:	@change the byte order to AES column first order, masked them with V at the same time
  lsls r6, r5, #2
  movs r7, #0x0C
  ands r6, r7
  lsrs r7, r5, #2
  eors r6, r7
  ldrb r7, [r0, r6]
  eors r7, r2
  strb r7, [r1, r5]	@store the masked key to output
  subs r5, #1
  bge.n arrangedatakeymasked
  
  pop {r0-r7}
  pop {pc}
  .endfunc  

.global MADK
.func MADK
MADK:
  push {lr}
  push {r0-r7}
  movs r4, #3		@r4=i

ADK:  
  lsls r5, r4, #2
  movs r6, #0
  @movs r7, #0		@Clear reg HD
  @ADK
  ldr r6, [r0, r5]     @r6=p(r4)
  ldr r7, [r1, r5]	@r7=k(r4)
  eors r7, r6
  @str r4, [r0, r5]	@store Clear write memory bus
  str r7, [r0, r5]	@store it in masked output
  subs r4, #1
  bge.n ADK

  pop {r0-r7}
  pop {pc}
  .endfunc  

.global MSbox
.func MSbox
MSbox:
  push {lr}
  push {r0-r7}

  ldr r2, =SRMask@Additional Mask that proteced SR

  movs r4, #15		@r4=i
  ldr r5, =MaskedS	@r5=MaskedS
  ldr r1, =S

MS:  
  @movs r6, #0		@Clear reg & bus
  movs r7, #0
  
  @SBox
  ldrb r6, [r0, r4]     @r6=input(r4)
  @movs r7, #3
  @ands r7, r4           @r7=i&0x0011
  @ldrb r7, [r2, r7]     @r7=SRMask[i&0x0011]
  @eors r6, r7           @remove SRMask


  ldrb r3, [r5, r6]	@r3=MaskedS(r6)=S(sum)^U
  strb r3, [r0, r4]	@store it in masked output
  @@@@@@@@@@@@@@@@@@@@@@@@@ Additional mask
  @movs r7, #3
  @ands r7, r6
  @ldrb r7, [r2, r7]     @r7=SRMask[sum&0x0011]
  @eors r7, r3
  @@@@@@@@@@@@@@@@@@@@@@@@@

  @lsrs r6, r4, #2       @r6= high two bits of i
  @subs r6, r4, r6       @r6= i-high two bits of i
  @adds r6, #4		@r6= i+4-high two bits of i
  @movs r3, #3 
  @ands r3, r6		@r3= (i+4-high two bits of i)&0x11
  @ldrb r6, [r2, r3]     @r6=SRMask[r4&0x0011]
  @eors r7, r6           @r7=r7^SRMask[r4&0x0011]
  @@@@@@@@@@@@@@@@@@@@@@@@@
  @strb r4, [r0, r4]     @Store clear the STR bus
  @@@@@@@@@@@@@@@@@@@@@@@@@
  @strb r7, [r0, r4]	@store it in masked output


  subs r4, #1
  bge.n MS
  
  pop {r0-r7}
  pop {pc}
  .endfunc 


.global MShiftRow
.func MShiftRow
MShiftRow:
  push {lr}
  push {r4-r7}


  ldr r2, =xtime_const@Using the constant to clear out any read/write bus transition
  ldr r3, [r2]

  movs r1, #0
  movs r5, #8
  movs r6, #16
  movs r7, #24

  ldr r4, [ r0, #0 ]
  @movs r1, #0 @Clear bus
  str r1, [ r0, #0 ] @Clear bus
  ldr r1, [ r0, #0 ] @Clear bus
  str r4, [ r0, #0 ] @store result


  @ldr r3, [r2]@Using the mask V to clear out any read/write bus transition
  movs r1, #0
  ldr r4, [ r0, #4 ]
  rors r1, r5 @Clear rors?
  str r1, [ r0, #4 ]
  eors r1, r1
  rors r4, r5 @Rotate state
  eors r1, r1
  ldr r1, [ r0, #4 ]
  str r4, [ r0, #4 ]

  @ldr r3, [r2]@Using the mask V to clear out any read/write bus transition
  movs r1, #0
  ldr r4, [ r0, #8 ]		@Leakage from here: all values are using the same mask, both op1HD & op2HD
  rors r1, r6 @Clear rors?
  str r1, [ r0, #8 ]
  eors r1, r1
  rors r4, r6 @Rotate state
  eors r1, r1
  ldr r1, [ r0, #8 ]
  str r4, [ r0, #8 ]


  @ldr r3, [r2]@Using the mask V to clear out any read/write bus transition
  movs r1, #0
  ldr r4, [ r0, #12 ]
  rors r1, r7 @Clear rors?
  str r1, [ r0, #12 ]
  eors r1, r1
  rors r4, r7 @Rotate state
  eors r1, r1
  ldr r1, [ r0, #12 ]
  str r4, [ r0, #12 ]

  movs r1, #0
  movs r4, #0
  pop {r4-r7}
  pop {pc}
  .endfunc

  

.global MMixColumn
.func MMixColumn
MMixColumn:

  push {lr}
  push {r0-r7}  

  movs r3, #0	@Clear Context
  movs r4, #0
  movs r5, #0
  movs r6, #0
  movs r7, #0

  mov r2, r8
  push {r2}
  mov r2, r9
  push {r2}
  mov r2, r10
  push {r2}

  
  mov r8, r1
  mov r9, r0

  ldr r7, =xtime_const

  ldr r5, =V
  ldrb r3, [r5]
  ldr r5, =xtime
  ldrb r6, [r5, r3]
  
  lsls r5, r6, #8
  eors r6,r5
  lsls r5, r6, #16
  eors r6, r5
  lsls r5, r3, #8
  eors r3, r5
  lsls r5, r3, #16
  eors r3, r5

  movs r4, #3

mix_columnmasked:
  mov r12, r4  
  mov r0, r4
  mov r4, r9
  lsls r1, r0, #2
  ldr r1, [r4, r1]
  adds r0, #1
  movs r4, #3
  ands r0, r4
  mov r4, r9
  lsls r5, r0, #2
  ldr r5, [r4, r5]
  eors r1, r3
  eors r1, r5
  lsrs r4, r1, #7
  ldr r2, [r7, #0]
  ands r4, r2
  ldr r2, [r7, #8]
  muls r4, r2
  lsls r1, r1, #1
  ldr r2, [r7, #4]
  ands r1, r2
  eors r1, r4
  eors r1, r5
  adds r0, #1
  movs r4, #3
  ands r0, r4
  mov r4, r9
  lsls r5, r0, #2
  ldr r5, [r4, r5]
  eors r1, r5
  adds r0, #1
  movs r4, #3
  ands r0, r4
  mov r4, r9
  lsls r5, r0, #2
  ldr r5, [r4, r5]
  eors r1, r5
  eors r1, r6
  mov r5, r12
  lsls r5, r5, #2
  mov r0, r8
  str r1, [r0, r5]
  mov r4, r12
  subs r4, #1
  bge.n mix_columnmasked


  
  pop {r2}
  mov r10, r2
  pop {r2}
  mov r9, r2
  pop {r2}
  mov r8, r2
 
  pop {r0-r7}
  pop {pc}
  .endfunc

.global Finalize
.func Finalize
Finalize:
  push {lr}
  push {r0-r7}

  ldr r2, =SRMask@Additional Mask that proteced SR
  ldr  r4, =UV
  ldrb r3, [r4]
  movs r5, #15
Fin:	@change the byte order to AES column first order, masked them with U at the same time
  lsls r6, r5, #2	@r6=(r5)<<2
  movs r7, #0x0C	@r7=0x0c
  ands r6, r7		@r6=(r5) low two bits in the last nibble
  lsrs r7, r5, #2	@r7=(r5)>>2
  eors r6, r7		@r6=(r5) low two bits in the last nibble||(r5) high two bits in the last nibble 
  ldrb r7, [r0, r6]	@load input to r7
  eors r7, r3		@mask input with U
  @movs r4, #3
  @ands r4, r6           @r4=low 2 bits of r6
  @ldrb r4, [r2, r4]     @r4=SRMask[r6&0x0011]
  @eors r7, r4           @r7=r7^SRMask[r6&0x0011]
  strb r7, [r1, r5]	@store the masked value to output
  subs r5, #1		@proceed to other bytes
  bge.n Fin

  pop {r0-r7}
  pop {pc}
.endfunc

.global Trigger
.func Trigger
Trigger:
  push {lr}
  push {r4-r6}
   @Start of trigger
   @Trigger address: 0x50003FFC
   movs r4, #80
   lsls r4, r4, #24
   movs r5, #63
   lsls r5,r5,#8
   eors r4,r5
   movs r5, #252
   eors r4,r5
   movs r5,#1
   lsls r5,#8
   ldr  r6, [r4, #0]
   eors r5, r6
   str  r5, [r4, #0]
   nop
   nop
   nop   
   nop
   str  r6, [r4, #0]

pop {r4-r6}
pop {pc}
.endfunc

.global SafeCopy
.func SafeCopy
SafeCopy:
  push {lr}
  push {r2-r6}

  movs r3, #0
loop:
  movs r2, #0 @Zero reg & bus
  lsls r4, r3, #2
  str r2, [r1, r4]
  ldr r2, [r1, r4]

  ldr r2, [r0, r4]@Load value
  str r2, [r1, r4]@Store value
  adds r3, #1
  cmp  r3, #4
  bne  loop

  pop {r2-r6}
  pop {pc}
.endfunc
  .end
