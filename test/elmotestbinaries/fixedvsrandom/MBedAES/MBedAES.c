#define NOTRACES 5000

#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>
#include <libopencm3/stm32/usart.h>
#include <stdio.h>
#include <stdlib.h>

#include "aes.h"
#include "../elmoasmfunctionsdef.h"

int main(void) {
    
    int i,j;
    
    uint8_t *input, *output, *key;
    
    key = malloc(16*sizeof(uint8_t));
    input = malloc(16*sizeof(uint8_t));
    output = malloc(16*sizeof(uint8_t));
    
    // Use fixed key and fixed input as specified by CRI for use with AES

    static const uint8_t fixedkey[16] = {0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef, 0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0xde, 0xf0};

    static const uint8_t fixedinput[16] = {0xda, 0x39, 0xa3, 0xee, 0x5e, 0x6b, 0x4b, 0x0d, 0x32, 0x55, 0xbf, 0xef, 0x95, 0x60, 0x18, 0x90};

    mbedtls_aes_context *ctx;
    ctx = malloc(sizeof(mbedtls_aes_context));
    
    for(j=0;j<16;j++)
        output[j] = 0x00;
    
    // Fixed Traces

    for(i=0;i<NOTRACES;i++){
        
        for(j=0;j<16;j++){

            input[j] = fixedinput[j];
            key[j] = fixedkey[j];
        }

        mbedtls_aes_setkey_enc(ctx, key, 128);
        
        starttrigger();
        
            mbedtls_aes_encrypt(ctx, input, output);
        
        endtrigger();
        
        for(j=0;j<16;j++)
            printhex(&output[j]);
        
    }

    for(j=0;j<16;j++)
        output[j] = 0x00;
    
    // Random Traces
    
    for(i=0;i<NOTRACES;i++){
        
        for(j=0;j<16;j++){
            input[j] = output[j];
            key[j] = fixedkey[j];
        }
        
        mbedtls_aes_setkey_enc(ctx, key, 128);
        
        starttrigger();
        
            mbedtls_aes_encrypt(ctx, input, output);
        
        endtrigger();
        
        for(j=0;j<16;j++)
            printhex(&output[j]);
        
    }
    
    endprogram();

    return 0;
}
