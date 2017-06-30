/*
 * University of Bristol – Open Access Software Licence
 * Copyright (c) 2016, The University of Bristol, a chartered
 * corporation having Royal Charter number RC000648 and a charity
 * (number X1121) and its place of administration being at Senate
 * House, Tyndall Avenue, Bristol, BS8 1TH, United Kingdom.
 * All rights reserved
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 * notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above
 * copyright notice, this list of conditions and the following
 * disclaimer in the documentation and/or other materials provided
 * with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Any use of the software for scientific publications or commercial
 * purposes should be reported to the University of Bristol
 * (OSI-notifications@bristol.ac.uk and quote reference 2668). This is
 * for impact and usage monitoring purposes only.
 *
 * Enquiries about further applications and development opportunities
 * are welcome. Please contact elisabeth.oswald@bristol.ac.uk
 */
/* Generates instruction sequences based on serial input by selecting binary representation of instructions and storing them in memory. Binary instructions generated form following sequence:
 *1) Load user input data from memory (different if data is for memory instruction)
 * 2) Start trigger on pin A5
 * 2) NOP * 10 (to ensure "clean" data dependency of sequence)
 * 3) INSTRUCTION1
 * 4) INSTRUCTION2
 * 5) INSTRUCTION3
 * 6) NOP * 10
 * 7) End trigger
 * 8) Branch back
 * Receives instructions and data via serial on PA10 as three single byte values for the three instructions and 24 bytes for the data for three instructions.
 * Values for each instruction are 0 to 14 where each integer represents the respective instruction in the following order: 'ldr', 'ldrb', 'str', 'strb', 'add', 'sub', 'mul', 'eor', 'orr', 'and', 'lsl', 'lsr', 'ror', 'mov', 'cmp'
 * Uses libopencm3 for serial communication with board.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "../elmoasmfunctionsdef.h"

#define U_8bit unsigned char
#define NO_BYTES 16
#define NO_ENC 100
#define NOTRACES 1000

// Generate instructions in binary.

static void create_insts(U_8bit *insts, U_8bit *instselect);

U_8bit *address1,*address2,*address3;

// 'ldr', 'ldrb', 'ldrh', 'str', 'strb', 'strh', 'add', 'sub', 'mul', 'eor', 'orr', 'and', 'lsl', 'lsr', 'ror', 'mov', 'cmp', 'add #0', 'sub #0', 'lsl #1', 'lsr #1', 'mov #0' and 'cmp #0' with operands either r1, r7; r3, r4 or r5, r6 for each instruction respectively

U_8bit instruction1[46] = {0x68, 0x39, 0x78, 0x39 , 0x88, 0x39, 0x60 ,0x39 ,0x70 ,0x39 , 0x80, 0x39, 0x19 ,0xc9 ,0x1b ,0xc9 ,0x43 ,0x79 ,0x40 ,0x79 ,0x43 ,0x39 ,0x40 ,0x39 ,0x40 ,0xb9 ,0x40 ,0xf9 ,0x41 ,0xf9 ,0x46 ,0x39 ,0x42 ,0xb9, 0x31, 0x00, 0x39, 0x00, 0x00, 0x49, 0x08, 0x49, 0x21, 0x00, 0x29, 0x00};
U_8bit instruction2[46] = {0x68 ,0x23 ,0x78 ,0x23 , 0x88, 0x23, 0x60 ,0x23 ,0x70 ,0x23 , 0x80, 0x23, 0x19 ,0x1b ,0x1b ,0x1b ,0x43 ,0x63 ,0x40 ,0x63 ,0x43 ,0x23 ,0x40 ,0x23 ,0x40 ,0xa3 ,0x40 ,0xe3 ,0x41 ,0xe3 ,0x46 ,0x23 ,0x42 ,0xa3, 0x33, 0x00, 0x3b, 0x00, 0x00, 0x5b, 0x08, 0x5b, 0x23, 0x00, 0x2b, 0x00};
U_8bit instruction3[46] = {0x68 ,0x35 ,0x78 ,0x35 , 0x88, 0x35, 0x60 ,0x35 ,0x70 ,0x35 , 0x80, 0x35, 0x19 ,0xad ,0x1b ,0xad ,0x43 ,0x75 ,0x40 ,0x75 ,0x43 ,0x35 ,0x40 ,0x35 ,0x40 ,0xb5 ,0x40 ,0xf5 ,0x41 ,0xf5 ,0x46 ,0x35 ,0x42 ,0xb5, 0x35, 0x00, 0x3d, 0x00, 0x00, 0x6d, 0x08, 0x6d, 0x25, 0x00, 0x2d, 0x00};

U_8bit instructiongroup[5] = {6,12,3,0,8};

void instructions(U_8bit *op, U_8bit *address1, U_8bit *address2, U_8bit *address3, U_8bit *instad);

void create_insts(U_8bit *insts, U_8bit *instselect){

	// Select right load sequence

	if(instselect[0] < 6){ // Inst 1 is a memory instruction
		// 	ldr r1, [r0, #0], mov r11, r1, ldr r7, [r0, #4], mov r1, r8, str r7, [r1], mov r7, r1
		insts[1] = 0x68; insts[0] = 0x01; insts[3] = 0x46; insts[2] = 0x8b; insts[5] = 0x68; insts[4] = 0x47; insts[7] = 0x46; insts[6] = 0x41; insts[9] = 0x60; insts[8] = 0x0f; insts[11] = 0x46; insts[10] = 0x0f;
        
	}

   /* else if(instselect[0] == 8){
        // 	ldr r1, [r0, #0], mov r11, r1, ldr r7,[r0, #4]
        insts[1] = 0x68; insts[0] = 0x41; insts[3] = 0x46; insts[2] = 0x8b; insts[5] = 0x68; insts[4] = 0x07; insts[7] = 0x46; insts[6] = 0xc0; insts[9] = 0x46; insts[8] = 0xc0; insts[11] = 0x46; insts[10] = 0xc0;
    }*/
    
	else{
		// 	ldr r1, [r0, #0], mov r11, r1, ldr r7,[r0, #4]
		insts[1] = 0x68; insts[0] = 0x01; insts[3] = 0x46; insts[2] = 0x8b; insts[5] = 0x68; insts[4] = 0x47; insts[7] = 0x46; insts[6] = 0xc0; insts[9] = 0x46; insts[8] = 0xc0; insts[11] = 0x46; insts[10] = 0xc0;
	}

	if(instselect[1] < 6){ // Inst 2 is a memory instruction
		// 	ldr r3, [r0, #8], ldr r4, [r0, #12], mov r1, r9, str r4, [r1], mov r4, r1
		insts[13] = 0x68; insts[12] = 0x83; insts[15] = 0x68; insts[14] = 0xc4; insts[17] = 0x46; insts[16] = 0x49; insts[19] = 0x60; insts[18] = 0x0c; insts[21] = 0x46; insts[20] = 0x0c;

	}
/*
	else if(instselect[1] == 8){
		// ldr r3, [r0, #8], ldr r4, [r0, #12]
		insts[13] = 0x68; insts[12] = 0xc3; insts[15] = 0x68; insts[14] = 0x84; insts[17] = 0x46; insts[16] = 0xc0; insts[19] = 0x46; insts[18] = 0xc0; insts[21] = 0x46; insts[20] = 0xc0;

	}
*/
    
    else{
        // ldr r3, [r0, #8], ldr r4, [r0, #12]
        insts[13] = 0x68; insts[12] = 0x83; insts[15] = 0x68; insts[14] = 0xc4; insts[17] = 0x46; insts[16] = 0xc0; insts[19] = 0x46; insts[18] = 0xc0; insts[21] = 0x46; insts[20] = 0xc0;
        
    }
    
	if(instselect[2] < 6){ // Inst 3 is a memory instruction
		// 	ldr r5, [r0, #16], ldr r6, [r0, #20], mov r1, r10, str r6, [r1], mov r6, r1		
		insts[23] = 0x69; insts[22] = 0x05; insts[25] = 0x69; insts[24] = 0x46; insts[27] = 0x46; insts[26] = 0x51; insts[29] = 0x60; insts[28] = 0x0e; insts[31] = 0x46; insts[30] = 0x0e;

	}

/*
	else if(instselect[2] == 8){
        //	ldr r5, [r0, #16], ldr r6, [r0, #20]
        insts[23] = 0x69; insts[22] = 0x45; insts[25] = 0x69; insts[24] = 0x06; insts[27] = 0x46; insts[26] = 0xc0; insts[29] = 0x46; insts[28] = 0xc0; insts[31] = 0x46; insts[30] = 0xc0;
        
    }
*/
 
	else{
		//	ldr r5, [r0, #16], ldr r6, [r0, #20]
		insts[23] = 0x69; insts[22] = 0x05; insts[25] = 0x69; insts[24] = 0x46; insts[27] = 0x46; insts[26] = 0xc0; insts[29] = 0x46; insts[28] = 0xc0; insts[31] = 0x46; insts[30] = 0xc0;

	}

	// Start of trigger assign r8 to be #0 (as NOP is mov r8, r8) and move first operand of instruction 1 back into r1
		//	movs r0, #144, lsls r0, r0, #23, movs r1, #32, ldr	r2, [r0, #20], eors r1, r2,	str r1, [r0, #20], movs r1, #0, mov r8, r1, mov r1, r11
		//insts[33] = 0x46; insts[32] = 0xc0; insts[35] = 0x46; insts[34] = 0xc0; insts[37] = 0x46; insts[36] = 0xc0; insts[39] = 0x46; insts[38] = 0xc0; insts[41] = 0x46; insts[40] = 0xc0; insts[43] = 0x46; insts[42] = 0xc0;
    
        insts[33] = 0x20; insts[32] = 0xe0; insts[35] = 0x06; insts[34] = 0x00; insts[37] = 0x21; insts[36] = 0x04; insts[39] = 0x40; insts[38] = 0x48; insts[41] = 0x21; insts[40] = 0x01; insts[43] = 0x60; insts[42] = 0x01;

            insts[45] = 0x21; insts[44] = 0x00; insts[47] = 0x46; insts[46] = 0x88; insts[49] = 0x46; insts[48] = 0x59;

		if(instselect[0] < 6){ //  First instruction is memory so don't include extra cycle for alignment of second instruction

			insts[51] = instruction1[(instselect[0]*2)]; insts[50] = instruction1[(instselect[0]*2) + 1];

			insts[53] = instruction2[(instselect[1]*2)]; insts[52] = instruction2[(instselect[1]*2) + 1];
	
			insts[55] = instruction3[(instselect[2]*2)]; insts[54] = instruction3[(instselect[2]*2) + 1];

			insts[57] = 0x46; insts[56] = 0xc0;

			// End of function
			insts[59] = 0x21; insts[58] = 0x00; insts[61] = 0x60; insts[60] = 0x01; insts[63] = 0xbc; insts[62] = 0xff; insts[65] = 0x47; insts[64] = 0x70;
        }
            // First instruction is not memory so need to include a nop instruction for alignment of second instruction

        else{

			insts[51] = 0x46; insts[50] = 0xc0;

			insts[53] = instruction1[(instselect[0]*2)]; insts[52] = instruction1[(instselect[0]*2) + 1];

			insts[55] = instruction2[(instselect[1]*2)]; insts[54] = instruction2[(instselect[1]*2) + 1];

			insts[57] = instruction3[(instselect[2]*2)]; insts[56] = instruction3[(instselect[2]*2) + 1];

		// Stop trigger and branch back
			// str	r2, [r0, #20], pop {r0-r7}, bx lr
			//insts[59] = 0x46; insts[58] = 0xc0; insts[61] = 0x46; insts[60] = 0xc0; insts[63] = 0xbc; insts[62] = 0xff; insts[65] = 0x47; insts[64] = 0x70;
            
            insts[59] = 0x21; insts[58] = 0x00; insts[61] = 0x60; insts[60] = 0x01; insts[63] = 0xbc; insts[62] = 0xff; insts[65] = 0x47; insts[64] = 0x70;

        }
	}

int main(void) {

	unsigned char *instad, *op, *instselect;
	unsigned int  i, j, k, l, m;

	instselect = malloc(3);
	op = malloc(24);
	instad = malloc(500);

	for(i=0;i<24;i++){
		op[i] = 0x00;
	}

	address1 = malloc(4);
	address2 = malloc(4);
	address3 = malloc(4);
    
    for(i=0;i<5;i++){
        for(j=0;j<5;j++){
            for(k=0;k<5;k++){
                resetdatafile();
                for(l=0;l<NOTRACES;l++){

                    instselect[0] = instructiongroup[i];
                    instselect[1] = instructiongroup[j];
                    instselect[2] = instructiongroup[k];

                    for(m=0;m<24;m++){
                        readbyte(&op[m]);
                    }

                    create_insts(instad, instselect);
                    instructions(op, address1, address2, address3, instad);

                }
            }
        }
    }

    endprogram();

	return 0;
}
