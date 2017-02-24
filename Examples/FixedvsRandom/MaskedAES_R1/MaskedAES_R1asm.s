
  .syntax unified
  .text
  .thumb
  
  .extern S
  .extern MaskedS
  .extern xtime
  .extern rcon

  .extern U
  .extern U2
  .extern V2
  .extern V
  .extern UV
  .extern X
  .extern Q
  .extern G

  .extern index4
  .extern index16

  .extern ShiftRowsIndexes

  .extern ShuffleMacroFour
  .extern ShuffleMacroSixteen

  .extern get_random

.global acComputeAESMasked
.func acComputeAESMasked

acComputeAESMasked:

  push {r0-r7}


  mov r8, r0
  mov r9, r1
  mov r10, r2

  ldr r0, =U
  ldrb r1, [r0]

  ldr r0, =V
  ldrb r2, [r0]

  # Create variable UV
  
  ldr r0, =UV
  eors r2, r1
  strb r2, [r0]

  movs r3, #255
  ldr r4, =S
  ldr r5, =MaskedS

masksbox:
  mov r0, r2
  eors r0, r3
  ldrb r6, [ r4, r0]
  eors r6, r1
  strb r6, [ r5, r3 ]
  subs r3, #1
  bge.n masksbox

  # Preserve registers
  
  mov r0, r8
  mov r1, r9
  mov r2, r10

  ldr r3, =U
  ldrb r3, [r3]
  
  ldr r4, =V
  ldrb r4, [r4]

  # Arrange data and key so they can be loaded in words

  movs r5, #15

arrangedatamasked:
  lsls r6, r5, #2
  movs r7, #0x0C
  ands r6, r7
  lsrs r7, r5, #2
  eors r6, r7
  ldrb r7, [r1, r6]
  eors r7, r3
  strb r7, [r0, r5]
  subs r5, #1
  bge.n arrangedatamasked

  movs r5, #15

arrangedatakeymasked:
  lsls r6, r5, #2
  movs r7, #0x0C
  ands r6, r7
  lsrs r7, r5, #2
  eors r6, r7
  ldrb r7, [r2, r6]
  eors r7, r4
  strb r7, [r1, r5]
  subs r5, #1
  bge.n arrangedatakeymasked

  # Mov key to key memory location
  
  ldr r3, [r1]
  str r3, [r2]
  ldr r3, [r1,#4]
  str r3, [r2,#4]
  ldr r3, [r1,#8]
  str r3, [r2,#8]
  ldr r3, [r1,#12]
  str r3, [r2,#12]

  # Reload registers for loading key and state

  mov r0, r8
  mov r1, r9
  mov r2, r10

  # Start Trigger

    push {r0-r7}
    movs r0, #0xE0
    lsls r0, #24
    movs r1, #0x04
    eors r0, r1
    movs r1, #1
    str r1, [r0, #0]
    pop {r0-r7}

  movs r4, #15
  ldr r5, =MaskedS

AddKeySubBytes:

  # Add Key
  ldr r6, [r0, r4]
  ldr r7, [r2, r4]
  eors r6, r7

  # SBox
  ldrb r7, [r5, r6]
  strb r7, [r1, r4]

  subs r4, #1
  bge.n AddKeySubBytes

  # Shift Rows

  ldr r4, [ r1, #4 ]
  movs r5, #8
  rors r4, r5
  str r4, [ r1, #4 ]
  ldr r4, [ r1, #8 ]
  movs r5, #16
  rors r4, r5
  str r4, [ r1, #8 ]
  ldr r4, [ r1, #12 ]
  movs r5, #24
  rors r4, r5
  str r4, [ r1, #12 ]

  # Mix Columns
  
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

  # End Trigger

    push {r0-r7}
    movs r4, #0xE0
    lsls r4, #24
    movs r5, #0x04
    eors r4, r5
    movs r1, #0
    str r5, [r4, #0]
    pop {r0-r7}
  
  pop {r0-r7}
  bx lr

  .endfunc
  .end
