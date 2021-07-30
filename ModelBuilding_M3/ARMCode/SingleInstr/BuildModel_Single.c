/* Copyright (C) 2017 Daniel Page <dan@phoo.org>
 *
 * Use of this source code is restricted per the CC BY-SA license, a copy of
 * which can be found via http://creativecommons.org (and should be included 
 * as LICENSE.txt within the associated archive or repository).
 */
//For M3: export TARGET="${SCALE_HW}/target/lpc1313fbd48"
//Make & Program: sudo  make --no-builtin-rules -f ${TARGET}/build/lib/scale.mk BSP="${TARGET}/build" USB="/dev/ttyUSB0" PROJECT="BuildModel_Single" PROJECT_SOURCES="BuildModel_Single.c BuildModel_Single.S" PROJECT_HEADERS="BuildModel_Single.h" clean all program

/*
* process the instrutions according to the instrution code 
* 
*/
#include "BuildModel_Single.h"

unsigned int ADD_I1(uint8_t* addr,unsigned int v21,unsigned int v22)
{
	ADD_1(addr);
	return (unsigned int)(v21+v22);

}
unsigned int ADDImm0_I2(uint8_t* addr,unsigned int v21,unsigned int v22)
{
 	ADDImm0_2(addr);
	return (unsigned int)(v21);

}
unsigned int AND_I3(uint8_t* addr,unsigned int v21,unsigned int v22)
{
 	AND_3(addr);
	return (unsigned int)(v21&v22);
}
unsigned int CMP_I4(uint8_t* addr,unsigned int v21,unsigned int v22)
{
 	CMP_4(addr);
	return (unsigned int)(0);
}
unsigned int CMPImm0_I5(uint8_t* addr,unsigned int v21,unsigned int v22)
{
 	CMPImm0_5(addr);
	return (unsigned int)(v21);
}
unsigned int EOR_I6(uint8_t* addr,unsigned int v21,unsigned int v22)
{
 	EOR_6(addr);
	return (unsigned int)(v21^v22);
}
unsigned int LDR_I7(uint8_t* addr,unsigned int v21,unsigned int v22)
{
 	LDR_7(addr);
	return (unsigned int)(v22);
}
unsigned int LDRB_I8(uint8_t* addr,unsigned int v21,unsigned int v22)
{
 	LDRB_8(addr);
	return (unsigned int)(v22&0xff);
}
unsigned int LDRH_I9(uint8_t* addr,unsigned int v21,unsigned int v22)
{
 	LDRH_9(addr);
	return (unsigned int)(v22&0xffff);
}

unsigned int LSL_I10(uint8_t* addr,unsigned int v21,unsigned int v22)
{
 	LSL_10(addr);
	return (unsigned int)(v21<<v22);
}
unsigned int LSLImm1_I11(uint8_t* addr,unsigned int v21,unsigned int v22)
{
 	LSLImm1_11(addr);
	return (unsigned int)(v21<<1);
}
unsigned int LSR_I12(uint8_t* addr,unsigned int v21,unsigned int v22)
{
 	LSR_12(addr);
	return (unsigned int)(v21>>v22);
}
unsigned int LSRImm1_I13(uint8_t* addr,unsigned int v21,unsigned int v22)
{
 	LSRImm1_13(addr);
	return (unsigned int)(v21>>1);
}
unsigned int MOV_I14(uint8_t* addr,unsigned int v21,unsigned int v22)
{
 	MOV_14(addr);
	return (unsigned int)(v22);
}
unsigned int MOVImm0_I15(uint8_t* addr,unsigned int v21,unsigned int v22)
{
 	MOVImm0_15(addr);
	return (unsigned int)(0);
}
unsigned int MUL_I16(uint8_t* addr,unsigned int v21,unsigned int v22)
{
 	MUL_16(addr);
	return (unsigned int)(v21*v22);
}
unsigned int ORR_I17(uint8_t* addr,unsigned int v21,unsigned int v22)
{
 	ORR_17(addr);
	return (unsigned int)(v21|v22);
}
unsigned int ROR_I18(uint8_t* addr,unsigned int v21,unsigned int v22)
{
 	ROR_18(addr);
	v22=v22%32;
	return (unsigned int)((v21<<(32-v22))|(v21>>v22));
}
unsigned int STR_I19(uint8_t* addr,unsigned int v21,unsigned int v22)
{
 	STR_19(addr);
	return (unsigned int)(v22);
}
unsigned int STRB_I20(uint8_t* addr,unsigned int v21,unsigned int v22)
{
 	STRB_20(addr);
	return (unsigned int)(v22&0xff);
}
unsigned int STRH_I21(uint8_t* addr,unsigned int v21,unsigned int v22)
{
 	STRH_21(addr);
	return (unsigned int)(v22&0xffff);
}
unsigned int SUB_I22(uint8_t* addr,unsigned int v21,unsigned int v22)
{
 	SUB_22(addr);
	return (unsigned int)(v21-v22);
}
unsigned int SUBImm0_I23(uint8_t* addr,unsigned int v21,unsigned int v22)
{
 	SUBImm0_23(addr);
	return (unsigned int)(v21);
}
int main( int argc, char* argv[] ) {
 if( !scale_init( &SCALE_CONF ) ) {
    return -1;
  }

  uint8_t plain[32];
  unsigned int addr1,v21,v22,result;
  //unsigned int addr1,v11,v12,v21,v22,v31,v32,result;
  unsigned int instr=0;
  result=0;
  while( true ) {


             	for( int i = 0; i < 32; i++ ) 
	     	{
              		plain[i]=(uint8_t)scale_uart_rd(SCALE_UART_MODE_BLOCKING);
             	}
                

		//v11=(plain[3]<<24)|(plain[2]<<16)|(plain[1]<<8)|(plain[0]); 
		//v12=(plain[7]<<24)|(plain[6]<<16)|(plain[5]<<8)|(plain[4]); 
		v21=(plain[11]<<24)|(plain[10]<<16)|(plain[9]<<8)|(plain[8]); 
		v22=(plain[15]<<24)|(plain[14]<<16)|(plain[13]<<8)|(plain[12]); 
		//v31=(plain[19]<<24)|(plain[18]<<16)|(plain[17]<<8)|(plain[16]); 
		//v32=(plain[23]<<24)|(plain[22]<<16)|(plain[21]<<8)|(plain[20]); 
		addr1=(plain[27]<<24)|(plain[26]<<16)|(plain[25]<<8)|(plain[24]);
		addr1&=0x000003f8;
		addr1|=0x10000800;
		plain[27]=(addr1>>24)&0xff;
		plain[26]=(addr1>>16)&0xff;
		plain[25]=(addr1>>8)&0xff;
		plain[24]=(addr1>>0)&0xff;
		
		instr=(unsigned int)plain[28];

		//target_gpio_wr( GPIO_PIN_TRG, true  );//trig on

		switch(instr)
		{
		   case 1: result=ADD_I1(plain,v21,v22);break;
		   case 2: result=ADDImm0_I2(plain,v21,v22);break;	
		   case 3: result=AND_I3(plain,v21,v22);break;
		   case 4: result=CMP_I4(plain,v21,v22);break;
		   case 5: result=CMPImm0_I5(plain,v21,v22);break;
		   case 6: result=EOR_I6(plain,v21,v22);break;
		   case 7: result=LDR_I7(plain,v21,v22);break;
		   case 8: result=LDRB_I8(plain,v21,v22);break;
		   case 9: result=LDRH_I9(plain,v21,v22);break;
		   case 10:result= LSL_I10(plain,v21,v22);break;
		   case 11: result=LSLImm1_I11(plain,v21,v22);break;
		   case 12: result=LSR_I12(plain,v21,v22);break;
		   case 13: result=LSRImm1_I13(plain,v21,v22);break;
		   case 14: result=MOV_I14(plain,v21,v22);break;
		   case 15: result=MOVImm0_I15(plain,v21,v22);break;
		   case 16: result=MUL_I16(plain,v21,v22);break;
		   case 17: result=ORR_I17(plain,v21,v22);break;
		   case 18: result=ROR_I18(plain,v21,v22);break;
		   case 19: result=STR_I19(plain,v21,v22);break;
		   case 20: result=STRB_I20(plain,v21,v22);break;
		   case 21: result=STRH_I21(plain,v21,v22);break;
		   case 22: result=SUB_I22(plain,v21,v22);break;
		   case 23: result=SUBImm0_I23(plain,v21,v22);break;
		   default: result=0;break;	
		}

		
    		//target_gpio_wr( GPIO_PIN_TRG, false  );//trig off
	
    		scale_delay_us( 100 );

		//target_uart_wr( (char)((result>>0)&0xff) );
		//target_uart_wr( (char)((result>>8)&0xff) );
		//target_uart_wr( (char)((result>>16)&0xff) );
		//target_uart_wr( (char)((result>>24)&0xff) );
    		for( int i = 0; i <32; i++ ) {
     			scale_uart_wr(SCALE_UART_MODE_BLOCKING,( (char)plain[ i ] ));
    		}
  }

  return 0;
}
