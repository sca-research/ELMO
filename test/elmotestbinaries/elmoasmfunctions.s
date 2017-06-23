.syntax unified
.text
.thumb

.func starttrigger
.global starttrigger

starttrigger:
    push {r0-r7}
    movs r4, #0xE0
    lsls r4, #24
    movs r5, #0x04
    eors r4, r5
    movs r5, #1
    str r5, [r4, #0]
    pop {r0-r7}
bx lr

.endfunc

.func endtrigger
.global endtrigger

endtrigger:
    push {r0-r7}
    movs r4, #0xE0
    lsls r4, #24
    movs r5, #0x04
    eors r4, r5
    movs r5, #0
    str r5, [r4, #0]
    pop {r0-r7}
bx lr

.endfunc

.func readbyte
.global readbyte

readbyte:
    push {r0-r7}
    movs r4, #0xE1
    lsls r4, #24
    ldr r1, [r4, #0]
    strb r1, [r0, #0]
    pop {r0-r7}

bx lr

.endfunc

.func randbyte
.global randbyte

randbyte:
    push {r0-r7}
    movs r4, #0xE1
    lsls r4, #24
    movs r5, #0x04
    eors r4, r5
    ldr r1, [r4, #0]
    strb r1, [r0, #0]
    pop {r0-r7}

bx lr

.endfunc

.func getstart
.global getstart

getstart:
    push {r0-r7}
    movs r4, #0xE1
    lsls r4, #24
    movs r5, #0x08
    eors r4, r5
    ldr r1, [r4, #0]
    str r1, [r0, #0]
    pop {r0-r7}

bx lr

.endfunc


.func getruncount
.global getruncount

getruncount:
    push {r0-r7}
    movs r4, #0xE1
    lsls r4, #24
    movs r5, #0x0C
    eors r4, r5
    ldr r1, [r4, #0]
    str r1, [r0, #0]
    pop {r0-r7}

bx lr

.endfunc



.func printbyte
.global printbyte

printbyte:
    push {r0-r7}
    movs r4, #0xE0
    lsls r4, #24
    ldrb r5, [r0]
    str r5, [r4]
    pop {r0-r7}
bx lr

.endfunc

.func endprogram
.global endprogram

endprogram:
    push {r0-r7}
    movs r4, #0xF0
    lsls r4, #24
    movs r5, #0

    str r5, [r4]
    pop {r0-r7}
bx lr

.endfunc

.func initialisemaskflow
.global initialisemaskflow

# Takes address of key as input (r0)
initialisemaskflow:
    push {r0-r7}
    movs r4, #0xE0
    lsls r4, #24
    movs r5, #0x40
    eors r4, r5
    str r0, [r4]
    pop {r0-r7}
bx lr

.endfunc

.func resetmaskflow
.global resetmaskflow

resetmaskflow:
    push {r0-r7}
    movs r4, #0xE0
    lsls r4, #24
    movs r5, #0x42
    eors r4, r5
    movs r5, #0
    str r5, [r4]
    pop {r0-r7}
bx lr

.endfunc

.func setmaskflowstart
.global setmaskflowstart

# Takes r0 as start number

setmaskflowstart:
    push {r0-r7}
    movs r4, #0xE0
    lsls r4, #24
    movs r5, #0x44
    eors r4, r5
    str r0, [r4]
    pop {r0-r7}
bx lr

.endfunc

.func resetdatafile
.global resetdatafile

resetdatafile:
    push {r0-r7}
    movs r4, #0xE0
    lsls r4, #24
    movs r5, #0x46
    eors r4, r5
    movs r5, #0
    str r5, [r4]
    pop {r0-r7}
bx lr

.endfunc
