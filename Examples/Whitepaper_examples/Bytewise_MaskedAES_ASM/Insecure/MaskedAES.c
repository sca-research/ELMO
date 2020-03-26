

// This is a first-order protected byte-wise masked AES, using the masking scheme in the Chap 9 from the DPA Book (Mangard S, Oswald E, Popp T. Power analysis attacks: Revealing the secrets of smart cards. Springer Science &amp;Business Media, 2007)
// Changes have been made to make the assembly code 1st order secure on NXP LPC1114, please refers to https://github.com/bristol-sca/ASM_MaskedAES for technical details

//For ELMO fix-v.s.-random leakage detection:
//Trigger period: first round AES's encryption
//Instruction counts=1053
//./elmo ${BINARY_DIRECTORY}/ELMO/MaskedAES.bin -autotvla 2000

#define NOTRACES 20000
#define AUTON //Automaticially decide the number of traces N
#include <stdio.h>
#include <stdlib.h>

#include "MaskedAES.h"
#include "elmoasmfunctionsdef.h"

void AES_encrypt(uint8_t* m, uint8_t* c)
{
   uint8_t temp[16];
  for(int j=0;j<16;j++)
  {
    m[j]=0;
    temp[j]=0;
  }

  MaskingKey(RoundKey, temp);
  MADK(c,temp);

  starttrigger();

  for(int i=0;i<10;i++)
  {
        MSbox(c);


       
        MShiftRow(c);


        if(i!=9)
        {

           MMixColumn(c, m);

           MaskingKey(RoundKey+(i+1)*16, temp);

           MADK(m,temp);

           SafeCopy(m,c);

        }
        else
        {
           MaskingKey(RoundKey+(i+1)*16, temp);
           MADK(c,temp);
           SafeCopy(c,m);
	  
        }
      if(i==0)
          endtrigger();
  }
//endtrigger();
  Finalize(m, c);


  
}

int main() {


    uint8_t *input, *output, *key;
    uint8_t *temp;
    uint32_t i,j;
    uint32_t N;
    key = malloc(16*sizeof(uint8_t));
    input = malloc(16*sizeof(uint8_t));
    output = malloc(16*sizeof(uint8_t));
    
    //static const uint8_t fixedkey[16] = {0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef, 0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc, 0xde, 0xf0};
    //static const uint8_t fixedinput[16] = {0xda, 0x39, 0xa3, 0xee, 0x5e, 0x6b, 0x4b, 0x0d, 0x32, 0x55, 0xbf, 0xef, 0x95, 0x60, 0x18, 0x90};
    static const uint8_t fixedkey[16] = {0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c};
    static const uint8_t fixedinput[16] = {0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f, 0x3c};
    //static const uint8_t fixedinput[16] = {0x32, 0x43, 0xf6, 0xa8, 0x88, 0x5a, 0x30, 0x8d, 0x31, 0x31, 0x98, 0xa2, 0xe0, 0x37, 0x07, 0x34};
    U = 0;
    V = 0;
    UV = 0;
    temp=(uint8_t*)&SRMask;
    #ifdef AUTON
     LoadN(&N);//Get N from ELMO
    #else
     N=NOTRACES/2;
    #endif

    for(j=0;j<16;j++)
    {
        output[j] = 0x00;
    }
    //key Expansion
    KeyExpansion(fixedkey);
    for(i=0;i<N;i++)
    {
        
	//Switch from Fix to Random (Only do it once)
        if(i==N/2)
        {
		for(j=0;j<16;j++)
           	  output[j] = 0x00;
	}
       //Fix v.s. Random Plaintexts
        for(j=0;j<16;j++)
       {
            if(i<N/2)
            {
		input[j] = fixedinput[j]; // Fixed Traces
	    }
	    else
            {
		input[j] = output[j]; // Random Traces
	    }
        }
       //Random masks
       randbyte(&U);
       randbyte(&V);
       for(j=0;j<4;j++)
          randbyte(temp+j);

        //Encryption
        GenMaskedSbox();
        MaskingPlaintext(input, output);  
     
        AES_encrypt(input, output); 

    }
    
    endprogram();

    return 0;
}
