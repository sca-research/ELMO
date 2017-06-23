#define NOTRACES 20000

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "AES.h"
#include "../../elmoasmfunctionsdef.h"

extern void acComputeAES(uint8_t *output, uint8_t *input, uint8_t *key);
extern void acComputeAESMasked(uint8_t *output, uint8_t *input, uint8_t *key);

int main(void) {

    int i,j;

    uint8_t *input, *output, *key;

    key = malloc(16*sizeof(uint8_t));
    input = malloc(16*sizeof(uint8_t));
    output = malloc(16*sizeof(uint8_t));
    
    static const uint8_t fixedkey[16] = {0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef, 0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0xde, 0xf0};
    static const uint8_t fixedinput[16] = {0xda, 0x39, 0xa3, 0xee, 0x5e, 0x6b, 0x4b, 0x0d, 0x32, 0x55, 0xbf, 0xef, 0x95, 0x60, 0x18, 0x90};
    
    U = 0;
    V = 0;
    UV = 0;
    
    for(j=0;j<16;j++){
        output[j] = 0x00;
    }

// Generate fixed traces
    for(i=0;i<NOTRACES;i++){

        readbyte(&U);
        readbyte(&V);
        
        for(j=0;j<16;j++){
            readbyte(&input[j]);
            input[j] = fixedinput[j];
            key[j] = fixedkey[j];
        }
        
        setmaskflowstart(0);
        initialisemaskflow(&U);
        
        setmaskflowstart(8);
        initialisemaskflow(&V);
        
        //Trigger started in asm file
        acComputeAESMasked(output, input, key);
    }
    
    resetdatafile();

    for(j=0;j<16;j++){
        output[j] = 0x00;
    }
    
// Generate random traces
    
    for(i=0;i<NOTRACES;i++){
        
        readbyte(&U);
        readbyte(&V);
        
        for(j=0;j<16;j++){
            readbyte(&input[j]);
            key[j] = fixedkey[j];
        }
        
        setmaskflowstart(0);
        initialisemaskflow(&U);
        
        setmaskflowstart(8);
        initialisemaskflow(&V);
        
        //Trigger started in asm file
        acComputeAESMasked(output, input, key);
    }
    
    endprogram();

    return 0;
}
