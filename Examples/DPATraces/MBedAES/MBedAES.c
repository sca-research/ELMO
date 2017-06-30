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

#define NOTRACES 200

#include <stdio.h>
#include <stdlib.h>

#include "aes.h"
#include "aes.c"
#include "../../elmoasmfunctionsdef.h"

int main(void) {
    
    int i,j;
    
    uint8_t *input, *output, *key;
    
    key = malloc(16*sizeof(uint8_t));
    input = malloc(16*sizeof(uint8_t));
    output = malloc(16*sizeof(uint8_t));
    
    mbedtls_aes_context *ctx;
    ctx = malloc(sizeof(mbedtls_aes_context));
    
    for(i=0;i<NOTRACES;i++){
        
        // Set up inputs and key.
        
        for(j=0;j<16;j++){

            randbyte(&input[j]); //Get random data for inputs. Random data generated is stored in randdata.txt.
            key[j] = j; // Initialise key to 0, 1, 2, 3,..., 15
            output[j] = 0x00;
                
        }

        mbedtls_aes_setkey_enc(ctx, key, 128);
        
        starttrigger();
        
            mbedtls_aes_encrypt(ctx, input, output);
        
        endtrigger();
        
        // Print cipher texts.
        
        for(j=0;j<16;j++){
                
            printbyte(&output[j]);

        }
                
    }
    
    endprogram();

    return 0;
}
