.section .data
	   
   tempVecFs: .byte  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00

.section .text
.syntax unified
.thumb
.global F_addRoundKey, F_sbox, F_shiftRows, F_mixColumn
	
	
		/*====================================*/
		/*------function: F_addRoundKey-------*/
		/*====================================*/
F_addRoundKey:
		/* copy registers value to the stack */
		PUSH {R0,R1,R2,R3,R4}
		/* r0 stores the adress of src1 */
		/* r1 stores the adress of src2 */
		/* r2 stores the adress of result */
		LDR R3, [R0]
		LDR R4, [R1]
		EOR R3, R4
		STR R3, [R2]
		
		LDR R3, [R0, #4]
		LDR R4, [R1, #4]
		EOR R3, R4
		STR R3, [R2, #4]
		
		LDR R3, [R0, #8]
		LDR R4, [R1, #8]
		EOR R3, R4
		STR R3, [R2, #8]
		
		LDR R3, [R0, #12]
		LDR R4, [R1, #12]
		EOR R3, R4
		STR R3, [R2, #12]
		
		/* r2 stores the adress of result */
		
		/* copy registers value from the stack */
		POP {R0,R1,R2,R3,R4}
		/* return */
		BX LR
		/*====================================*/
		
		
		/*====================================*/
		/*----------function: F_sbox----------*/
		/*====================================*/
F_sbox:
		/* copy registers value to the stack */
		PUSH {R0,R1,R2,R3,R4}
		/* r0 stores the adress of src */
		/* r1 stores the adress of result */
		LDR R2, =tab_sbox /* the table for sbox */
		LDRB R3, [R0] /* load the byte */
		LDRB R4, [R2, R3] /* look up the table */
		STRB R4, [R1] /* store the byte */
		
		LDRB R3, [R0, #1] /* load the byte */
		LDRB R4, [R2, R3] /* look up the table */
		STRB R4, [R1, #1] /* store the byte */
		
		LDRB R3, [R0, #2] /* load the byte */
		LDRB R4, [R2, R3] /* look up the table */
		STRB R4, [R1, #2] /* store the byte */
		
		LDRB R3, [R0, #3] /* load the byte */
		LDRB R4, [R2, R3] /* look up the table */
		STRB R4, [R1, #3] /* store the byte */
		
		LDRB R3, [R0, #4] /* load the byte */
		LDRB R4, [R2, R3] /* look up the table */
		STRB R4, [R1, #4] /* store the byte */
		
		LDRB R3, [R0, #5] /* load the byte */
		LDRB R4, [R2, R3] /* look up the table */
		STRB R4, [R1, #5] /* store the byte */
		
		LDRB R3, [R0, #6] /* load the byte */
		LDRB R4, [R2, R3] /* look up the table */
		STRB R4, [R1, #6] /* store the byte */
		
		LDRB R3, [R0, #7] /* load the byte */
		LDRB R4, [R2, R3] /* look up the table */
		STRB R4, [R1, #7] /* store the byte */
		
		LDRB R3, [R0, #8] /* load the byte */
		LDRB R4, [R2, R3] /* look up the table */
		STRB R4, [R1, #8] /* store the byte */
		
		LDRB R3, [R0, #9] /* load the byte */
		LDRB R4, [R2, R3] /* look up the table */
		STRB R4, [R1, #9] /* store the byte */
		
		LDRB R3, [R0, #10] /* load the byte */
		LDRB R4, [R2, R3] /* look up the table */
		STRB R4, [R1, #10] /* store the byte */
		
		LDRB R3, [R0, #11] /* load the byte */
		LDRB R4, [R2, R3] /* look up the table */
		STRB R4, [R1, #11] /* store the byte */
		
		LDRB R3, [R0, #12] /* load the byte */
		LDRB R4, [R2, R3] /* look up the table */
		STRB R4, [R1, #12] /* store the byte */
		
		LDRB R3, [R0, #13] /* load the byte */
		LDRB R4, [R2, R3] /* look up the table */
		STRB R4, [R1, #13] /* store the byte */
		
		LDRB R3, [R0, #14] /* load the byte */
		LDRB R4, [R2, R3] /* look up the table */
		STRB R4, [R1, #14] /* store the byte */
		
		LDRB R3, [R0, #15] /* load the byte */
		LDRB R4, [R2, R3] /* look up the table */
		STRB R4, [R1, #15] /* store the byte */
		
		/* r1 stores the adress of result */
		
		/* copy registers value from the stack */
		POP {R0,R1,R2,R3,R4}
		/* return */
		BX LR
		/*====================================*/
		
		
		/*====================================*/
		/*-------function: F_shiftRows--------*/
		/*====================================*/
		
F_shiftRows:
		/* copy registers value to the stack */
		PUSH {R0,R1,R2}
		/* r0 stores the adress of src */
		/* r1 stores the adress of result */
		
		/* shift */
		LDRB R2, [R0]
		STRB R2, [R1]
		LDRB R2, [R0, #1]
		STRB R2, [R1, #13]
		LDRB R2, [R0, #2]
		STRB R2, [R1, #10]
		LDRB R2, [R0, #3]
		STRB R2, [R1, #7]
		LDRB R2, [R0, #4]
		STRB R2, [R1, #4]
		LDRB R2, [R0, #5]
		STRB R2, [R1, #1]
		LDRB R2, [R0, #6]
		STRB R2, [R1, #14]
		LDRB R2, [R0, #7]
		STRB R2, [R1, #11]
		LDRB R2, [R0, #8]
		STRB R2, [R1, #8]
		LDRB R2, [R0, #9]
		STRB R2, [R1, #5]
		LDRB R2, [R0, #10]
		STRB R2, [R1, #2]
		LDRB R2, [R0, #11]
		STRB R2, [R1, #15]
		LDRB R2, [R0, #12]
		STRB R2, [R1, #12]
		LDRB R2, [R0, #13]
		STRB R2, [R1, #9]
		LDRB R2, [R0, #14]
		STRB R2, [R1, #6]
		LDRB R2, [R0, #15]
		STRB R2, [R1, #3]
	
		/* r1 stores the adress of result */
		
		/* copy registers value from the stack */
		POP {R0,R1,R2}
		/* return */
		BX LR
		
		/*====================================*/
		
		
		/*====================================*/
		/*-------function: F_mixColumn--------*/
		/*====================================*/
F_mixColumn:
		/* copy registers value to the stack */
		PUSH {R0,R1,R2,R12,LR}
		/* r0 stores the adress of src */
		/* r1 stores the adress of result */
		//MOV R11, R0
		
		MOV R12, #0 /* counter for iterations of columns : 4 */
		//LDR R1, =tempVecFs /* tempVec stores the result (16) */
loopMix:
		/* prepare the adress to be producted */
		/* r0 stores the adress of vec */
		/* prepare the adress of result */
		/* r1 stores the adress of result */
		/* mat * vec */
		BL mul_mat_vec_4
		
		/* next column */
		ADD R0, #4 /* the next column (4) */
		ADD R1, #4 /* next beginning adress of column */
		ADD R12, #1
		CMP R12, #4
		IT NE 
		BNE loopMix
		
		/* store */
		//LDR R1, =tempVecFs
		//LDR R2, [R1]
		//STR R2, [R11]
		//LDR R2, [R1, #4]
		//STR R2, [R11, #4]
		//LDR R2, [R1, #8]
		//STR R2, [R11, #8]
		//LDR R2, [R1, #12]
		//STR R2, [R11, #12]
		
		/* copy registers value from the stack */
		POP {R0,R1,R2,R12,LR}
		/* return */
		BX LR
		/*====================================*/
		
.end
		
