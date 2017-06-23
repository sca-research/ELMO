.syntax unified
.text
.thumb

.func instructions
.global instructions

instructions:

push {r0-r7}

mov r8, r1
mov r9, r2
mov r10, r3

mov pc, r4

.endfunc
