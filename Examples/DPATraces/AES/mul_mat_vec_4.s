.section .data  
	matMix: .byte 25,  1,  0,  0
		    .byte  0, 25,  1,  0
			.byte  0,  0, 25,  1
		    .byte  1,  0,  0, 25
.section .text
.syntax unified
.thumb
.global mul_mat_vec_4

/* input */
/* r0 stores the adress of vec */
/* r1 stores the adress of result */

/* output */
mul_mat_vec_4:
		/* copy registers value to the stack */
		PUSH {R0,R1,R2,R3,R4,R5,R6,R7,R8,R10,R11,R12}
		/* r0 stores the adress of vec */
        /* r1 stores the adress of result */
		
		/* prepare the adress */
		LDR R2, =matMix /* r2 stores the adress of matMix */
		LDR R3, =Logtable /* r3 stores the adress of logtable */
		LDR R10, =Alogtable /* r4 stores the adress of Alogtable */
		
		MOV R12, #0 /* counter for iterations of row for mat */
loopMulMV:
		MOV R11, #0 /* store the eor result */
		/*---the 0th byte---*/
		LDRB R4, [R0] /* load the 0th byte */
		LDRB R5, [R3, R4] /* look up the table */
		LDRB R6, [R2] /* load the 0th byte of mat row */
		/* mod 255 */
		ADD R7, R5, R6
		AND R8, R7, 0xFF
		ADD R8, R8, R7, LSR #8
		/* look up the table */
		LDRB R8, [R10, R8]
		ADD R4, 0xFF
		LSR R4, R4, #8
		MUL R8, R8, R4 /* if r4 = 0 then result is 0 */
		/* xor */
		EOR R11, R8
		/*---the 1th byte---*/
		LDRB R4, [R0, #1] /* load the 0th byte */
		LDRB R5, [R3, R4] /* look up the table */
		LDRB R6, [R2, #1] /* load the 0th byte of mat row */
		/* mod 255 */
		ADD R7, R5, R6
		AND R8, R7, 0xFF
		ADD R8, R8, R7, LSR #8
		/* look up the table */
		LDRB R8, [R10, R8]
		ADD R4, 0xFF
		LSR R4, R4, #8
		MUL R8, R8, R4 /* if r4 = 0 then result is 0 */
		/* xor */
		EOR R11, R8
		/*---the 2th byte---*/
		LDRB R4, [R0, #2] /* load the 0th byte */
		LDRB R5, [R3, R4] /* look up the table */
		LDRB R6, [R2, #2] /* load the 0th byte of mat row */
		/* mod 255 */
		ADD R7, R5, R6
		AND R8, R7, 0xFF
		ADD R8, R8, R7, LSR #8
		/* look up the table */
		LDRB R8, [R10, R8]
		ADD R4, 0xFF
		LSR R4, R4, #8
		MUL R8, R8, R4 /* if r4 = 0 then result is 0 */
		/* xor */
		EOR R11, R8
		/*---the 3th byte---*/
		LDRB R4, [R0, #3] /* load the 0th byte */
		LDRB R5, [R3, R4] /* look up the table */
		LDRB R6, [R2, #3] /* load the 0th byte of mat row */
		/* mod 255 */
		ADD R7, R5, R6
		AND R8, R7, 0xFF
		ADD R8, R8, R7, LSR #8
		/* look up the table */
		LDRB R8, [R10, R8]
		ADD R4, 0xFF
		LSR R4, R4, #8
		MUL R8, R8, R4 /* if r4 = 0 then result is 0 */
		/* xor */
		EOR R11, R8
		/* store the byte */
		STRB R11, [R1, R12]
		
		/* the next row */
		ADD R12, #1
		ADD R2, #4
		CMP R12, #4
		IT NE
		BNE loopMulMV
		
		/* copy registers value from the stack */
		POP {R0,R1,R2,R3,R4,R5,R6,R7,R8,R10,R11,R12}
		/* return */
		BX LR
.end
	