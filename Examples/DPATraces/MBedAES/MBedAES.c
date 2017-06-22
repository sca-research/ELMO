/* This example generates 200 traces that could be used for a DPA style attack. ELMO should be compiled without the FIXEDVSRANDOM define. */

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

            randdata(&input[j]); //Get random data for inputs. Random data generated is stored in randdata.txt.
            key[j] = j; // Initialise key to 0, 1, 2, 3,..., 15
            output[j] = 0x00;
                
        }

        mbedtls_aes_setkey_enc(ctx, key, 128);
        
        starttrigger();
        
            mbedtls_aes_encrypt(ctx, input, output);
        
        endtrigger();
        
        // Print cipher texts.
        
        for(j=0;j<16;j++){
                
            printhex(&output[j]);

        }
                
    }
    
    endprogram();

    return 0;
}
