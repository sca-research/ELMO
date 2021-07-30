/* Copyright (C) 2017 Daniel Page <dan@phoo.org>
 *
 * Use of this source code is restricted per the CC BY-SA license, a copy of
 * which can be found via http://creativecommons.org (and should be included 
 * as LICENSE.txt within the associated archive or repository).
 */
//For M3: export TARGET="${SCALE_HW}/target/lpc1313fbd48"
//Make & Program: sudo  make --no-builtin-rules -f ${TARGET}/build/lib/scale.mk BSP="${TARGET}/build" USB="/dev/ttyUSB0" PROJECT="BuildModel_Seq" PROJECT_SOURCES="BuildModel_Seq.c BuildModel_Seq.S" PROJECT_HEADERS="BuildModel_Seq.h" clean all program
#include "BuildModel_Seq.h"


void RunInstr(uint8_t* plain)
{
	Intro(plain);
	//Mid();
	//Finish();
}
/*
* process the instrutions according to the instrution code 
* 
*/

int main( int argc, char* argv[] ) {
 if( !scale_init( &SCALE_CONF ) ) {
    return -1;
  }
  uint8_t plain[32];
  uint8_t plain0[32];
  uint8_t repeat=0;
  unsigned int addr1;
  uint8_t instr=0;
  while( true ) {


             	for( int i = 0; i < 32; i++ ) 
	     	{
              		plain[i]=(uint8_t)scale_uart_rd(SCALE_UART_MODE_BLOCKING);
             	}
                


		
		addr1=(plain[27]<<24)|(plain[26]<<16)|(plain[25]<<8)|(plain[24]);
		addr1&=0x000001f0;
		addr1|=0x10000a00;
		plain[27]=(addr1>>24)&0xff;
		plain[26]=(addr1>>16)&0xff;
		plain[25]=(addr1>>8)&0xff;
		plain[24]=(addr1>>0)&0xff;
		
		instr=(unsigned int)plain[28];
                //plain[28]=123;
                if(instr/25==2||instr/25==3)
		  plain[29]=1;
                else
                  plain[29]=0;
                instr=instr%25;
		if(instr/5==2||instr/5==3)
		  plain[30]=1;
                else
                  plain[30]=0;
 		instr=instr%5;
		if(instr==2||instr==3)
		  plain[31]=1;
                else
                  plain[31]=0;

		repeat=(uint8_t)scale_uart_rd(SCALE_UART_MODE_BLOCKING);
                for(int j=0;j<repeat;j++)
		{
			for( int i = 0; i < 32; i++ ) 
				plain0[i]=plain[i];
			RunInstr(plain0);
		}


    		for( int i = 0; i <32; i++ ) {
     			scale_uart_wr(SCALE_UART_MODE_BLOCKING,( (char)plain0[ i ] ));
    		}
  }

  return 0;
}
