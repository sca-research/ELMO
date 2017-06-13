/* ELMO is based on the Thumblator emmulator which can be found at: https://github.com/dwelch67/thumbulator. The functional correctness of this code has been tested using a number generic testing methods however we do not garentee this code to be bug free. */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <math.h>
#include <stdbool.h>
#include <stdint.h>

//#include "test/elmodefinestest.h"
#include "elmodefines.h"

#include "include/powermodel.h"
#include "include/fixedvsrandom.h"

#ifdef DBUG
#include "include/debug.h"
#endif

#ifdef MASKFLOW
    #include "include/maskflow.h"
#endif

#ifdef ENERGYMODEL
    #include "include/energy.h"
#endif

//-------------------------------------------------------------------

// Linked list functions for maskflow

#ifdef MASKFLOW

void initialise_dataflow(dataflow *item){
    
    int i;
    
    item -> op1 = 0;
    item -> op2 = 0;
    for(i=0;i<6;i++)
        item -> instruction_type[i] = 0;
    item -> op1_maskflow = zero_maskflow32();
    item -> op2_maskflow = zero_maskflow32();
    
}

dataflow *create_dataflow(dataflow *item){
    
    int i;
    
    item -> next = malloc(sizeof(dataflow));
    item = item -> next;
    initialise_dataflow(item);
    item -> next = NULL;
    return item;
    
}

dataflow *update_dataflow(dataflow *item, unsigned int op1, unsigned int op2, unsigned int instruction_type, bit32_maskflow op1_maskflow, bit32_maskflow op2_maskflow){
    
    int i;
    
    item->op1 = op1;
    item->op2 = op2;
    
    for (i=0;i<32;i++){
        
        item->op1_binary[i] = ((item->op1 >> i) & 0x00000001);
        item->op2_binary[i] = ((item->op2 >> i) & 0x00000001);
        
    }
    
    item->instruction_type[instruction_type] = 1;
    item->instruction_typedec = instruction_type;
    
    item->op1_maskflow = op1_maskflow;
    item->op2_maskflow = op2_maskflow;
    
    // printf("%ud ", item->op1_maskflow);
    // printf("%ud\n", item->op2_maskflow);
    
    /*
     for(i=31;i>=0;i--)
     printf("%d", item->op1_maskflow[i]);
     printf("   ");
     
     for(i=31;i>=0;i--)
     printf("%d", item->op2_maskflow[i]);
     printf("\n");
     */
    
    if(instruction_type == 2 | instruction_type == 3){
        indexno += 2;
        item->op1_maskflow = zero_maskflow32();
    }
    else
        indexno++;
    
#ifdef DIFFTRACELENGTH

    item = create_dataflow(item);

#else

    if(t==1)
        item = create_dataflow(item);
    else{
        item = item->next;
        initialise_dataflow(item);
    }
    
#endif
    
    return item;
}

//-------------------------------------------------------------------

// Linked list functions for no maskflow

#else

void initialise_dataflow(dataflow *item){
    
    int i;
    
    item -> op1 = 0;
    item -> op2 = 0;
    for(i=0;i<6;i++)
        item -> instruction_type[i] = 0;
    
}

dataflow *create_dataflow(dataflow *item){
    
    int i;
    
    item -> next = malloc(sizeof(dataflow));
    item = item -> next;
    initialise_dataflow(item);
    item -> next = NULL;
    return item;
    
}


dataflow *update_dataflow(dataflow *item, unsigned int op1, unsigned int op2, unsigned int instruction_type){
    
    int i;
    
    item->op1 = op1;
    item->op2 = op2;
    
    for (i=0;i<32;i++){
        
        item->op1_binary[i] = ((item->op1 >> i) & 0x00000001);
        item->op2_binary[i] = ((item->op2 >> i) & 0x00000001);
        
    }
    
    item->instruction_type[instruction_type] = 1;
    item->instruction_typedec = instruction_type;
    
    // printf("%ud ", item->op1_maskflow);
    // printf("%ud\n", item->op2_maskflow);
    
    /*
     for(i=31;i>=0;i--)
     printf("%d", item->op1_maskflow[i]);
     printf("   ");
     
     for(i=31;i>=0;i--)
     printf("%d", item->op2_maskflow[i]);
     printf("\n");
     */
    
    if(instruction_type == 2 | instruction_type == 3){
        indexno += 2;
    }
    else
        indexno++;
    
#ifdef DIFFTRACELENGTH
    
    item = create_dataflow(item);
    
#else

    if(t==1)
        item = create_dataflow(item);
    else{
        item = item->next;
        initialise_dataflow(item);
    }
    
#endif

    return item;
}

#endif

//-------------------------------------------------------------------
/*
unsigned int leakagetestfail(void){

    unsigned int i, j, len_maskflow, len_fixedvsrandom, leakagetestfailno = 0, *fixedvsrandom, *maskflow;
    FILE *fp_maskflow, *fp_fixedvsrandom;
    char line[80];

    fp_maskflow = fopen(MASKFLOWOUTPUTFILE, "r");
    fp_fixedvsrandom = fopen(FIXEDVSRANDOMFILE, "r");

    len_maskflow = gettracelength(fp_maskflow);
    len_fixedvsrandom = gettracelength(fp_fixedvsrandom);

    rewind(fp_maskflow);
    rewind(fp_fixedvsrandom);

    maskflow = malloc(len_maskflow*sizeof(int));
    fixedvsrandom = malloc(len_fixedvsrandom*sizeof(int));

    for(i=0;i<len_maskflow;i++){
        fgets(line, 80, fp_maskflow);
        sscanf(line, "%d", &maskflow[i]);
    }
    for(i=0;i<len_fixedvsrandom;i++){
        fgets(line, 80, fp_fixedvsrandom);
       // printf("%s\n", line);
        sscanf(line, "%d", &fixedvsrandom[i]);
    }
    for(i=0;i<len_maskflow;i++)
        for(j=0;j<len_fixedvsrandom; j++)
            if(maskflow[i] == fixedvsrandom[j])
                leakagetestfailno++;

    fclose(fp_maskflow);
    fclose(fp_fixedvsrandom);
    
    free(maskflow);
    free(fixedvsrandom);

    return leakagetestfailno;

}
*/

//-------------------------------------------------------------------

void dump_counters ( void )
{
    int i;
    
    printf("\n########################################\n\nSUMMARY:\n");
    if(CYCLEACCURATE) printf("cycle accurate model\n");
    else printf("instruction accurate model\n");
    printf("instructions/cylces %d\n",instructions);
    printf("total energy consumption %0.20f\n",energy);
    printf("first order fixed vs random fail instructions/cycles %d\n",leakyinstructionno);
    printf("second order fixed vs random instructions/cycles\n");
    for(i=0;i<no_masks;i++)
        printf("mask %d: %d\n",i, maskfixedvsrandomfail[i]);

}

//-------------------------------------------------------------------

unsigned int fetch16 ( unsigned int addr )
{
    unsigned int data;

    fetches++;

if(DBUGFETCH) fprintf(stderr,"fetch16(0x%08X)=",addr);
if(registerdataflow && DBUG) fprintf(stderr,"fetch16(0x%08X)=",addr);
    switch(addr&0xF0000000)
    {
        case 0x00000000: //ROM
            addr&=ROMADDMASK;

//if(addr<0x50)
//{
//    fprintf(stderr,"fetch16(0x%08X), abort\n",addr);
//    exit(1);
//}
            
            addr>>=1;
            data=rom[addr];
if(DBUGFETCH) fprintf(stderr,"0x%04X\n",data);
if(registerdataflow && DBUG) fprintf(stderr,"0x%04X\n",data);
            return(data);
        case 0x20000000: //RAM
            addr&=RAMADDMASK;
            addr>>=1;
            data=ram[addr];
if(DBUGFETCH) fprintf(stderr,"0x%04X\n",data);
if(registerdataflow && DBUG) fprintf(stderr,"0x%04X\n",data);
            return(data);
    }
    fprintf(stderr,"fetch16(0x%08X), abort pc = 0x%04X\n",addr,read_register(15));
    exit(1);
}

//-------------------------------------------------------------------

unsigned int fetch32 ( unsigned int addr )
{
    unsigned int data;

if(DBUGFETCH) fprintf(stderr,"fetch32(0x%08X)=",addr);
if(registerdataflow && DBUG) fprintf(stderr,"fetch32(0x%08X)=",addr);
    switch(addr&0xF0000000)
    {
        case 0x00000000: //ROM
            if(addr<0x50)
            {
                data=read32(addr);
if(DBUGFETCH) fprintf(stderr,"0x%08X\n",data);
if(registerdataflow && DBUG) fprintf(stderr,"0x%08X\n",data);
                if(addr==0x00000000) return(data);
                if(addr==0x00000004) return(data);
                if(addr==0x0000003C) return(data);
                fprintf(stderr,"fetch32(0x%08X), abort pc = 0x%04X\n",addr,read_register(15));
                exit(1);
            }
        case 0x20000000: //RAM
            //data=fetch16(addr+0);
            //data|=((unsigned int)fetch16(addr+2))<<16;
            data=read32(addr);
if(DBUGFETCH) fprintf(stderr,"0x%08X\n",data);
if(registerdataflow && DBUG) fprintf(stderr,"0x%08X\n",data);
            return(data);
    }
    fprintf(stderr,"fetch32(0x%08X), abort pc 0x%04X\n",addr,read_register(15));
    exit(1);
}

//-------------------------------------------------------------------

void write16 ( unsigned int addr, unsigned int data )
{

    writes++;
    
if(registerdataflow && DBUG) fprintf(stderr,"write16(0x%08X,0x%04X)\n",addr,data);
    switch(addr&0xF0000000)
    {
        case 0x20000000: //RAM
if(DBUGRAM) fprintf(stderr,"write16(0x%08X,0x%04X)\n",addr,data);
            addr&=RAMADDMASK;
            addr>>=1;
            ram[addr]=data&0xFFFF;
            return;
      }
      fprintf(stderr,"write16(0x%08X,0x%04X), abort pc 0x%04X\n",addr,data,read_register(15));
      exit(1);
}

//-------------------------------------------------------------------

void write32 ( unsigned int addr, unsigned int data )
{

char str[500], filepath[500];
    
if(registerdataflow && DBUG) fprintf(stderr,"write32(0x%08X,0x%08X)\n",addr,data);
    switch(addr&0xF0000000)
    {
        case 0xF0000000: //halt
            tracenumber = (t-1);

#ifdef FIXEDVSRANDOM
            if(fixedvsrandomtest){
                tracenumber = (t-1)/2;
                fixedvsrandom();
            }
#endif
            
#ifdef ENERGYMODEL
            getenergy();
#endif

            dump_counters();
            exit(0);
        case 0xE0000000: //periph
            switch(addr)
        {
            case 0xE0000000:{
                fprintf(uartout,"%02x\n",data);
                fflush(stdout);
                break;
            }
            case 0xE0000004:{ // trigger
                
                registerdataflow = (data & 0x01);
                
                if((t<tracestart)){
                    
                    if(registerdataflow){
                        if(t%PRINTTRACENOINTERVAL == 0)
                            printf("GHOST TRACE NO: %010d\n", t);
                        dataptr = NULL;
                        asmoutput = NULL;
                        registerdataflow = 0;
                    }
                    else{
                        //freedataflow();
                        t++;
                    }
                    
                }
                
                else{
                    if(registerdataflow){
                        if(t%PRINTTRACENOINTERVAL == 0)
                            printf("TRACE NO: %010d\n", t);
#ifdef DIFFTRACELENGTH
                        dataptr = create_dataflow(start);
#else
                        dataptr = start->next;
#endif
                        if(t==1 || PRINTALLASMTRACES){
                            strcpy(str, ASMOUTPUTFOLDER);
                            strcat(str, ASMOUTPUTFILE);
                            sprintf(filepath, str, t);
                            asmoutput = fopen(filepath, "w+");
                        }
                    }
                    else{
#ifdef POWERMODEL_HW
                        hwpowermodel();
#else
                        elmopowermodel();
#endif
                        
#ifdef MASKFLOW
                        if (t==1) maskflowfailtest();
#endif
                        
#ifdef DIFFTRACELENGTH
                        freedataflow();
#endif
                        
                        indexno = 1;
                        if(t==1 || PRINTALLASMTRACES) fclose(asmoutput);
                        t++;
                        
                    }
                }
                break;
            }
                
                case 0xE000E010:
                {
                    unsigned int old;

                    old=systick_ctrl;
                    systick_ctrl = data&0x00010007;
                    if(((old&1)==0)&&(systick_ctrl&1))
                    {
                        //timer started, load count
                        systick_count=systick_reload;
                    }
                    break;
                }
                case 0xE000E014:
                {
                    systick_reload=data&0x00FFFFFF;
                    break;
                }
                case 0xE000E018:
                {
                    systick_count=data&0x00FFFFFF;
                    break;
                }
                case 0xE000E01C:
                {
                    systick_calibrate=data&0x00FFFFFF;
                    break;
                }
                case 0xE0000040:
                {
#ifdef MASKFLOW
                    set_mask_dataflow(data, start_mask_dataflow);
#endif
                    break;
                }
                case 0xE0000042:
                {
#ifdef MASKFLOW
                    reset_maskflow();
#endif
                    break;
                }
                case 0xE0000044:
                {
                    start_mask_dataflow = data;
                    break;
                }
                case 0xE0000046:
                {
                    rewind(datafile);
                    break;
                }

            }
            return;
    }
            //  case 0x20000000: //RAM
if(DBUGRAMW) fprintf(stderr,"write32(0x%08X,0x%08X)\n",addr,data);
            write16(addr+0,(data>> 0)&0xFFFF);
            write16(addr+2,(data>>16)&0xFFFF);
            return;
    
    fprintf(stderr,"write32(0x%08X,0x%08X), abort pc 0x%04X\n",addr,data,read_register(15));
    exit(1);
}

//-----------------------------------------------------------------

unsigned int read16 ( unsigned int addr )
{
    unsigned int data;

    reads++;

if(registerdataflow && DBUG) fprintf(stderr,"read16(0x%08X)=",addr);
    
    switch(addr&0xF0000000)
    {
        case 0x00000000: //ROM
            addr&=ROMADDMASK;
            addr>>=1;
            data=rom[addr];
if(registerdataflow && DBUG) fprintf(stderr,"0x%04X\n",data);
            return(data);
        case 0x20000000: //RAM
if(DBUGRAM) fprintf(stderr,"read16(0x%08X)=",addr);
            addr&=RAMADDMASK;
            addr>>=1;
            data=ram[addr];
if(registerdataflow && DBUG) fprintf(stderr,"0x%04X\n",data);
if(DBUGRAM) fprintf(stderr,"0x%04X\n",data);
            return(data);
    }

    if(DBUGRAM) fprintf(stderr,"read16(0x%08X)=",addr);
    addr&=RAMADDMASK;
    addr>>=1;
    data=ram[addr];
    if(registerdataflow && DBUG) fprintf(stderr,"0x%04X\n",data);
    if(DBUGRAM) fprintf(stderr,"0x%04X\n",data);
    return(data);
    
    fprintf(stderr,"read16(0x%08X), abort pc 0x%04X\n",addr,read_register(15));
    exit(1);
}

//-------------------------------------------------------------------

unsigned int read32 ( unsigned int addr )
{
    unsigned int data;
    size_t len = 50;
    char *str;

    str = (char *)malloc(len);

if(registerdataflow && DBUG) fprintf(stderr,"read32(0x%08X)=",addr);
    
    switch(addr&0xF0000000)
    {
        case 0xE0000000:
        {
            switch(addr)
            {
                case 0xE000E010:
                {
                    data = systick_ctrl;
                    systick_ctrl&=(~0x00010000);
                    free(str);
                    return(data);
                }
                case 0xE000E014:
                {
                    data=systick_reload;
                    free(str);
                    return(data);
                }
                case 0xE000E018:
                {
                    data=systick_count;
                    free(str);
                    return(data);
                }
                case 0xE000E01C:
                {
                    data=systick_calibrate;
                    free(str);
                    return(data);
                }
                case 0xE1000000:
                {
                    getline(&str, &len, datafile);
                    data = (int)strtol(str, NULL, 16);
                    //printf("%x\n", data);
                    free(str);
                    return(data);
                }
                case 0xE1000004:
                {
                    data = rand();
                    fprintf(randdata,"%2x\n",data&0xFF);
                    free(str);
                    return(data);
                }
                case 0xE1000008:
                {
                    data = t;
                    free(str);
                    return(data);

                }
                case 0xE100000C:
                {
                    data = runcount;
                    free(str);
                    return(data);

                }

            }
        }
    }
    
     // Case RAM
     if(DBUGRAMW) fprintf(stderr,"read32(0x%08X)=",addr);
     data =read16(addr+0);
     data|=((unsigned int)read16(addr+2))<<16;
     if(registerdataflow && DBUG) fprintf(stderr,"0x%08X\n",data);
     if(DBUGRAMW) fprintf(stderr,"0x%08X\n",data);
     free(str);
     return(data);
    

    fprintf(stderr,"read32(0x%08X), abort pc 0x%04X\n",addr,read_register(15));
    exit(1);
    
}

//-------------------------------------------------------------------

unsigned int read_register ( unsigned int reg )
{
    unsigned int data;

    reg&=0xF;
if(registerdataflow && DBUG) fprintf(stderr,"read_register(%u)=",reg);
if(DBUGREG) fprintf(stderr,"read_register(%u)=",reg);
    data=reg_norm[reg];
    if(reg==15)
    {
        if(data&1)
        {
            fprintf(stderr,"pc has lsbit set 0x%08X\n",data);
        }
        data&=~1;
    }
if(registerdataflow && DBUG) fprintf(stderr,"0x%08X\n",data);
if(DBUGREG) fprintf(stderr,"0x%08X\n",data);
    return(data);
}
//-------------------------------------------------------------------
void write_register ( unsigned int reg, unsigned int data )
{
    reg&=0xF;
if(registerdataflow && DBUG) fprintf(stderr,"write_register(%u,0x%08X)\n",reg,data);
if(DBUGREG) fprintf(stderr,"write_register(%u,0x%08X)\n",reg,data);
    if(reg==15) data&=~1;
    reg_norm[reg]=data;

if(output_vcd)
{
    unsigned int vv;
    fprintf(fpvcd,"b");
    for(vv=0x80000000;vv;vv>>=1)
    {
        if(vv&data) fprintf(fpvcd,"1"); else fprintf(fpvcd,"0");
    }
    fprintf(fpvcd," r%u\n",reg);
}

}
//-------------------------------------------------------------------
void do_zflag ( unsigned int x )
{
    if(x==0) cpsr|=CPSR_Z; else cpsr&=~CPSR_Z;
}
//-------------------------------------------------------------------
void do_nflag ( unsigned int x )
{
    if(x&0x80000000) cpsr|=CPSR_N; else cpsr&=~CPSR_N;
}
//-------------------------------------------------------------------
void do_cflag ( unsigned int a, unsigned int b, unsigned int c )
{
    unsigned int rc;

    cpsr&=~CPSR_C;
    rc=(a&0x7FFFFFFF)+(b&0x7FFFFFFF)+c; //carry inbuses
    rc = (rc>>31)+(a>>31)+(b>>31);  //carry out
    if(rc&2) cpsr|=CPSR_C;
}
//-------------------------------------------------------------------
void do_vflag ( unsigned int a, unsigned int b, unsigned int c )
{
    unsigned int rc;
    unsigned int rd;

    cpsr&=~CPSR_V;
    rc=(a&0x7FFFFFFF)+(b&0x7FFFFFFF)+c; //carry in
    rc>>=31; //carry in in lsbit
    rd=(rc&1)+((a>>31)&1)+((b>>31)&1); //carry out
    rd>>=1; //carry out in lsbit
    rc=(rc^rd)&1; //if carry in != carry out then signed overflow
    if(rc) cpsr|=CPSR_V;
}
//-------------------------------------------------------------------
void do_cflag_bit ( unsigned int x )
{
   if(x) cpsr|=CPSR_C; else cpsr&=~CPSR_C;
}
//-------------------------------------------------------------------
void do_vflag_bit ( unsigned int x )
{
   if(x) cpsr|=CPSR_V; else cpsr&=~CPSR_V;
}
//-------------------------------------------------------------------
//-------------------------------------------------------------------
//-------------------------------------------------------------------
int execute ( void )
{
	unsigned int pc;
	unsigned int sp;
	unsigned int inst;
	
	unsigned int op1 = 0,op2 = 0,output;
	unsigned int ra,rb,rc;
	unsigned int rm,rd,rn,rs;
	unsigned int op;
    
    bit32_maskflow ra_maskflow,rb_maskflow,rc_maskflow, op1_maskflow, op2_maskflow;

//if(fetches>400000) return(1);

    pc=read_register(15);

    if(handler_mode)
    {
        if((pc&0xF0000000)==0xF0000000)
        {
            unsigned int sp;

            handler_mode = 0;
//fprintf(stderr,"--leaving handler\n");
            sp=read_register(13);
            write_register(0,read32(sp)); sp+=4;
            write_register(1,read32(sp)); sp+=4;
            write_register(2,read32(sp)); sp+=4;
            write_register(3,read32(sp)); sp+=4;
            write_register(12,read32(sp)); sp+=4;
            write_register(14,read32(sp)); sp+=4;
            pc=read32(sp); sp+=4;
            cpsr=read32(sp); sp+=4;
            write_register(13,sp);
        }
    }

    if(systick_ctrl&1)
    {
        if(systick_count)
        {
            systick_count--;
        }
        else
        {
            systick_count=systick_reload;
            systick_ctrl|=0x00010000;
        }
    }

    if((systick_ctrl&3)==3)
    {
        if(systick_ctrl&0x00010000)
        {
            if(handler_mode==0)
            {
                unsigned int sp;

                systick_ints++;
//fprintf(stderr,"--- enter systick handler\n");
                sp=read_register(13);
                sp-=4; write32(sp,cpsr);
                sp-=4; write32(sp,pc);
                sp-=4; write32(sp,read_register(14));
                sp-=4; write32(sp,read_register(12));
                sp-=4; write32(sp,read_register(3));
                sp-=4; write32(sp,read_register(2));
                sp-=4; write32(sp,read_register(1));
                sp-=4; write32(sp,read_register(0));
                write_register(13,sp);
                pc=fetch32(0x0000003C); //systick vector
                pc+=2;
                //write_register(14,0xFFFFFF00);
                write_register(14,0xFFFFFFF9);

                handler_mode=1;
            }
        }
    }

    inst=fetch16(pc-2);
    pc+=2;
    write_register(15,pc);
if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"--- 0x%08X: 0x%04X ",(pc-4),inst);

if(output_vcd)
{
    unsigned int vv;
    fprintf(fpvcd,"b");
    for(vv=0x8000;vv;vv>>=1)
    {
        if(vv&inst) fprintf(fpvcd,"1"); else fprintf(fpvcd,"0");
    }
    fprintf(fpvcd," inst\n");
}
    
    //ADC
    if((inst&0xFFC0)==0x4140)
    {
        rd=(inst>>0)&0x07;
        rm=(inst>>3)&0x07;
        
        ra=read_register(rd);
        rb=read_register(rm);
        rc=ra+rb;
        if(cpsr&CPSR_C) rc++;
        write_register(rd,rc);
        op1 = 0; op2 = 0;
        
        do_nflag(rc);
        do_zflag(rc);
        
        if(cpsr&CPSR_C) { do_cflag(ra,rb,1); do_vflag(ra,rb,1); }
        else            { do_cflag(ra,rb,0); do_vflag(ra,rb,0); }
        
#ifdef MASKFLOW
        ra_maskflow = read_register_maskflow(rd);
        rb_maskflow = read_register_maskflow(rm);
        rc_maskflow = compute_maskflow(ra_maskflow, rb_maskflow, 0, 0);
        write_register_maskflow(rd, rc_maskflow);
        op1_maskflow = ra_maskflow; op2_maskflow = rb_maskflow;
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"adc r%u,r%u\n",rd,rm);

#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
        
        return(0);
    }

    //ADD(1) small immediate two registers
    if((inst&0xFE00)==0x1C00)
    {
        rd=(inst>>0)&0x7;
        rn=(inst>>3)&0x7;
        rb=(inst>>6)&0x7;
        if(rb)
        {
            ra=read_register(rn);
            op1=ra; op2=rb;
            rc=ra+rb;
            write_register(rd,rc);

            do_nflag(rc);
            do_zflag(rc);
            do_cflag(ra,rb,0);
            do_vflag(ra,rb,0);
            
#ifdef MASKFLOW
            
            ra_maskflow = read_register_maskflow(ra);
            rb_maskflow = zero_maskflow32();
            rc_maskflow = compute_maskflow(ra_maskflow, rb_maskflow, 0, 0);
            write_register_maskflow(rd, rc_maskflow);
            op1_maskflow = ra_maskflow; op2_maskflow = rb_maskflow;
            
#endif

        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"adds r%u,r%u,#0x%X\n",rd,rn,rb);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0);
#endif
        return(0);
        }
        else
        {
            //this is a mov
        }
    }

    //ADD(2) big immediate one register
    if((inst&0xF800)==0x3000)
    {
        rb=(inst>>0)&0xFF;
        rd=(inst>>8)&0x7;
        
        ra=read_register(rd);
        op1=ra; op2=rb;
        rc=ra+rb;
        write_register(rd,rc);
        
        do_nflag(rc);
        do_zflag(rc);
        do_cflag(ra,rb,0);
        do_vflag(ra,rb,0);
        
#ifdef MASKFLOW
        ra_maskflow = read_register_maskflow(rd);
        rb_maskflow = zero_maskflow32();
        rc_maskflow = compute_maskflow(ra_maskflow, rb_maskflow, 0, 0);
        write_register_maskflow(rd, rc_maskflow);
        op1_maskflow = ra_maskflow; op2_maskflow = rb_maskflow;
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"adds r%u,#0x%02X\n",rd,rb);
        
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0);
#endif

        return(0);
    }

    //ADD(3) three registers
    if((inst&0xFE00)==0x1800)
    {
        rd=(inst>>0)&0x7;
        rn=(inst>>3)&0x7;
        rm=(inst>>6)&0x7;

        ra=read_register(rn);
        op1=ra;
        rb=read_register(rm);
        op2=rb;
        
        rc=ra+rb;
        write_register(rd,rc);
        op1=ra; op2=rb;

        do_nflag(rc);
        do_zflag(rc);
        do_cflag(ra,rb,0);
        do_vflag(ra,rb,0);
        
#ifdef MASKFLOW
        ra_maskflow = read_register_maskflow(rn);
        rb_maskflow = read_register_maskflow(rm);
        rc_maskflow = compute_maskflow(ra_maskflow, rb_maskflow, 0, 0);
        write_register_maskflow(rd,rc_maskflow);
        op1_maskflow = ra_maskflow; op2_maskflow = rb_maskflow;
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"adds r%u,r%u,r%u\n",rd,rn,rm);
        
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0);
#endif

        return(0);
    }

    //ADD(4) two registers one or both high no flags
    if((inst&0xFF00)==0x4400)
    {
        if((inst>>6)&3)
        {
            //UNPREDICTABLE
        }
        rd=(inst>>0)&0x7;
        rd|=(inst>>4)&0x8;
        rm=(inst>>3)&0xF;
        
        ra=read_register(rd);
        op1=ra;
        rb=read_register(rm);
        op2=rb;
        
        if(rd==15)
        {
            if((rc&1)==0)
            {
                fprintf(stderr,"add pc,... produced an arm address 0x%08X 0x%08X\n",pc,rc);
                exit(1);
            }
            rc&=~1; //write_register may do this as well
            rc+=2; //The program counter is special
        }

        rc=ra+rb;
        
        write_register(rd,rc);
        
#ifdef MASKFLOW
        ra_maskflow = read_register_maskflow(rd);
        rb_maskflow = read_register_maskflow(rm);
        rc_maskflow = compute_maskflow(ra_maskflow, rb_maskflow, 0, 0);
        write_register_maskflow(rd,rc_maskflow);
        op1_maskflow = ra_maskflow; op2_maskflow = rb_maskflow;
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"add r%u,r%u\n",rd,rm);
        
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0);
#endif
        
        return(0);
    }

    //ADD(5) rd = pc plus immediate
    if((inst&0xF800)==0xA000)
    {
        rb=(inst>>0)&0xFF;
        rd=(inst>>8)&0x7;
        rb<<=2;
        
        ra=read_register(15);
        rc=(ra&(~3))+rb;
        write_register(rd,rc);
        op1 = 0; op2 = 0;
        
#ifdef MASKFLOW
        
        ra_maskflow = read_register_maskflow(15);
        rb_maskflow = zero_maskflow32();
        rc_maskflow = compute_maskflow(ra_maskflow, rb_maskflow, 0, 0);
        write_register_maskflow(rd, rc_maskflow);
        op1_maskflow = ra_maskflow; op2_maskflow = rb_maskflow;
        
#endif

        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"add r%u,PC,#0x%02X\n",rd,rb);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
        return(0);
    }

    //ADD(6) rd = sp plus immediate
    if((inst&0xF800)==0xA800)
    {
        rb=(inst>>0)&0xFF;
        rd=(inst>>8)&0x7;
        rb<<=2;
        
        ra=read_register(13);
        rc=ra+rb;
        write_register(rd,rc);
        op1 = 0; op2 = 0;
        
#ifdef MASKFLOW
        
        ra_maskflow = read_register_maskflow(13);
        rb_maskflow = zero_maskflow32();
        rc_maskflow = compute_maskflow(ra_maskflow, rb_maskflow, 0, 0);
        write_register_maskflow(rd, rc_maskflow);
        op1_maskflow = ra_maskflow; op2_maskflow = rb_maskflow;
        
#endif

        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"add r%u,SP,#0x%02X\n",rd,rb);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
        return(0);
    }

    //ADD(7) sp plus immediate
    if((inst&0xFF80)==0xB000)
    {
        rb=(inst>>0)&0x7F;
        rb<<=2;
        ra=read_register(13);
        rc=ra+rb;
        write_register(13,rc);
        op1 = 0; op2 = 0;

#ifdef MASKFLOW
        
        ra_maskflow = read_register_maskflow(13);
        rb_maskflow = zero_maskflow32();
        rc_maskflow = compute_maskflow(ra_maskflow, rb_maskflow, 0, 0);
        write_register_maskflow(rd, rc_maskflow);
        op1_maskflow = ra_maskflow; op2_maskflow = rb_maskflow;
        
#endif

        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"add SP,#0x%02X\n",rb);

#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
        return(0);
    }

    //AND
    if((inst&0xFFC0)==0x4000)
    {
        rd=(inst>>0)&0x7;
        rm=(inst>>3)&0x7;

        ra=read_register(rd);
        op1=ra;
        rb=read_register(rm);
        op2=rb;
        rc=ra&rb;
        write_register(rd,rc);
        
        do_nflag(rc);
        do_zflag(rc);
        
#ifdef MASKFLOW
        
        ra_maskflow = read_register_maskflow(rd);
        rb_maskflow = read_register_maskflow(rm);
        rc_maskflow = compute_maskflow(ra_maskflow, rb_maskflow, 0, 0);
        write_register_maskflow(rd, rc_maskflow);
        op1_maskflow = ra_maskflow; op2_maskflow = rb_maskflow;
        
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"ands r%u,r%u\n",rd,rm);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0);
#endif
        return(0);
    }

    //ASR(1) two register immediate
    if((inst&0xF800)==0x1000)
    {
        rd=(inst>>0)&0x07;
        rm=(inst>>3)&0x07;
        rb=(inst>>6)&0x1F;
        rc=read_register(rm);
        if(rb==0)
        {
            if(rc&0x80000000)
            {
                do_cflag_bit(1);
                rc=~0;
            }
            else
            {
                do_cflag_bit(0);
                rc=0;
            }
        }
        else
        {
            do_cflag_bit(rc&(1<<(rb-1)));
            ra=rc&0x80000000;
            rc>>=rb;
            if(ra) //asr, sign is shifted in
            {
                rc|=(~0)<<(32-rb);
            }
        }
        write_register(rd,rc);
        op1 = 0; op2 = 0;
        
        do_nflag(rc);
        do_zflag(rc);
        
#ifdef MASKFLOW
        rc_maskflow = read_register_maskflow(rm);
        rb_maskflow = zero_maskflow32();
        rc_maskflow = compute_maskflow(rc_maskflow, zero_maskflow32(), rb, 3);
        write_register_maskflow(rd, rc_maskflow);
        op1_maskflow = rc_maskflow; op2_maskflow = zero_maskflow32();
#endif
        

        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"asrs r%u,r%u,#0x%X\n",rd,rm,rb);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
        return(0);
    }
    
    //ASR(2) two register
    if((inst&0xFFC0)==0x4100)
    {
        rd=(inst>>0)&0x07;
        rs=(inst>>3)&0x07;
        rc=read_register(rd);
        rb=read_register(rs);
        rb&=0xFF;
        if(rb==0)
        {

        }
        else if(rb<32)
        {
            do_cflag_bit(rc&(1<<(rb-1)));
            ra=rc&0x80000000;
            rc>>=rb;
            if(ra) //asr, sign is shifted in
            {
                rc|=(~0)<<(32-rb);
            }
        }
        else
        {
            if(rc&0x80000000)
            {
                do_cflag_bit(1);
                rc=(~0);
            }
            else
            {
                do_cflag_bit(0);
                rc=0;
            }
        }

        write_register(rd,rc);
        op1 = 0; op2 = 0;
        
        do_nflag(rc);
        do_zflag(rc);
        
#ifdef MASKFLOW
        
        rc_maskflow = read_register_maskflow(rd);
        rb_maskflow = read_register_maskflow(rs);
        rc_maskflow = compute_maskflow(rc_maskflow, zero_maskflow32(), rb, 3);
        write_register_maskflow(rd, rc_maskflow);
        op1_maskflow = rc_maskflow; op2_maskflow = rb_maskflow;
        
#endif

        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"asrs r%u,r%u\n",rd,rs);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif        
        return(0);
    }

    //B(1) conditional branch
    if((inst&0xF000)==0xD000)
    {
        rb=(inst>>0)&0xFF;
        if(rb&0x80) rb|=(~0)<<8;
        op=(inst>>8)&0xF;
        rb<<=1;
        rb+=pc;
        rb+=2;
        switch(op)
        {
            case 0x0: //b eq  z set
                if(cpsr&CPSR_Z)
                {
                    write_register(15,rb);
                }
                if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"beq 0x%08X\n",rb-3);
                op1 = 0; op2 = 0;
#ifdef MASKFLOW
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
                return(0);

            case 0x1: //b ne  z clear
                if(!(cpsr&CPSR_Z))
                {
                    write_register(15,rb);
                }
                if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"bne 0x%08X\n",rb-3);
                op1 = 0; op2 = 0;
#ifdef MASKFLOW
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
                return(0);

            case 0x2: //b cs c set
                if(cpsr&CPSR_C)
                {
                    write_register(15,rb);
                }
                if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"bcs 0x%08X\n",rb-3);
                op1 = 0; op2 = 0;
#ifdef MASKFLOW
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
                return(0);

            case 0x3: //b cc c clear
                if(!(cpsr&CPSR_C))
                {
                    write_register(15,rb);
                }
                if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"bcc 0x%08X\n",rb-3);
                op1 = 0; op2 = 0;
#ifdef MASKFLOW
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
                return(0);

            case 0x4: //b mi n set
                if(cpsr&CPSR_N)
                {
                    write_register(15,rb);
                }
                
                if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"bmi 0x%08X\n",rb-3);
                op1 = 0; op2 = 0;
#ifdef MASKFLOW
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
                return(0);

            case 0x5: //b pl n clear
                if(!(cpsr&CPSR_N))
                {
                    write_register(15,rb);
                }
                if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"bpl 0x%08X\n",rb-3);
                op1 = 0; op2 = 0;
#ifdef MASKFLOW
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif        
                return(0);

            case 0x6: //b vs v set
                if(cpsr&CPSR_V)
                {
                    write_register(15,rb);
                }
                if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"bvs 0x%08X\n",rb-3);
                op1 = 0; op2 = 0;
#ifdef MASKFLOW
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
                return(0);

            case 0x7: //b vc v clear
                if(!(cpsr&CPSR_V))
                {
                    write_register(15,rb);
                }
                
                if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"bvc 0x%08X\n",rb-3);
                op1 = 0; op2 = 0;
#ifdef MASKFLOW
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
                return(0);

            case 0x8: //b hi c set z clear
                if((cpsr&CPSR_C)&&(!(cpsr&CPSR_Z)))
                {
                    write_register(15,rb);
                }
                if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"bhi 0x%08X\n",rb-3);
                op1 = 0; op2 = 0;
#ifdef MASKFLOW
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
                return(0);

            case 0x9: //b ls c clear or z set
                if((cpsr&CPSR_Z)||(!(cpsr&CPSR_C)))
                {
                    write_register(15,rb);
                }
                
                if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"bls 0x%08X\n",rb-3);
                op1 = 0; op2 = 0;
#ifdef MASKFLOW
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
                return(0);

            case 0xA: //b ge N == V
                ra=0;
                if(  (cpsr&CPSR_N) &&  (cpsr&CPSR_V) ) ra++;
                if((!(cpsr&CPSR_N))&&(!(cpsr&CPSR_V))) ra++;
                if(ra)
                {
                    write_register(15,rb);
                }
                if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"bge 0x%08X\n",rb-3);
                op1 = 0; op2 = 0;
#ifdef MASKFLOW
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
                return(0);

            case 0xB: //b lt N != V
                ra=0;
                if((!(cpsr&CPSR_N))&&(cpsr&CPSR_V)) ra++;
                if((!(cpsr&CPSR_V))&&(cpsr&CPSR_N)) ra++;
                if(ra)
                {
                    write_register(15,rb);
                }
                
                if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"blt 0x%08X\n",rb-3);
                op1 = 0; op2 = 0;
#ifdef MASKFLOW
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
                return(0);

            case 0xC: //b gt Z==0 and N == V
                ra=0;
                if(  (cpsr&CPSR_N) &&  (cpsr&CPSR_V) ) ra++;
                if((!(cpsr&CPSR_N))&&(!(cpsr&CPSR_V))) ra++;
                if(cpsr&CPSR_Z) ra=0;
                if(ra)
                {
                    write_register(15,rb);
                }
                
                if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"bgt 0x%08X\n",rb-3);
                op1 = 0; op2 = 0;
#ifdef MASKFLOW
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
                return(0);

            case 0xD: //b le Z==1 or N != V
                ra=0;
                if((!(cpsr&CPSR_N))&&(cpsr&CPSR_V)) ra++;
                if((!(cpsr&CPSR_V))&&(cpsr&CPSR_N)) ra++;
                if(cpsr&CPSR_Z) ra++;
                if(ra)
                {
                    write_register(15,rb);
                }
                if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"ble 0x%08X\n",rb-3);
                op1 = 0; op2 = 0;
#ifdef MASKFLOW
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
                return(0);

            case 0xE:
                //undefined instruction
                break;
            case 0xF:
                //swi
                break;
        }
    }

    //B(2) unconditional branch
    if((inst&0xF800)==0xE000)
    {
        rb=(inst>>0)&0x7FF;
        if(rb&(1<<10)) rb|=(~0)<<11;
        rb<<=1;
        rb+=pc;
        rb+=2;
        write_register(15,rb);
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"B 0x%08X\n",rb-3);
        op1 = 0; op2 = 0;
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
        return(0);
    }

    //BIC
    if((inst&0xFFC0)==0x4380)
    {
        rd=(inst>>0)&0x7;
        rm=(inst>>3)&0x7;
        ra=read_register(rd);
        rb=read_register(rm);
        rc=ra&(~rb);
        write_register(rd,rc);
        do_nflag(rc);
        do_zflag(rc);
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"bics r%u,r%u\n",rd,rm);
        op1 = 0; op2 = 0;
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
        return(0);
    }

    //BKPT
    if((inst&0xFF00)==0xBE00)
    {
        rb=(inst>>0)&0xFF;
        fprintf(stderr,"bkpt 0x%02X\n",rb);
        return(1);
    }

    //BL/BLX(1)
    if((inst&0xE000)==0xE000) //BL,BLX
    {
        if((inst&0x1800)==0x1000) //H=b10
        {
            rb=inst&((1<<11)-1);
            if(rb&1<<10) rb|=(~((1<<11)-1)); //sign extend
            rb<<=12;
            rb+=pc;
            write_register(14,rb);
            if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"bl\n");
            op1 = 0; op2 = 0;
#ifdef MASKFLOW
            if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
            if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
            return(0);
        }
        else
        if((inst&0x1800)==0x1800) //H=b11
        {
            //branch to thumb
            rb=read_register(14);
            rb+=(inst&((1<<11)-1))<<1;;
            rb+=2;

            write_register(14,(pc-2)|1);
            write_register(15,rb);
            if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"bl 0x%08X\n",rb-3);
            op1 = 0; op2 = 0;
#ifdef MASKFLOW
            if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
            if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
            return(0);
        }
        else
        if((inst&0x1800)==0x0800) //H=b01
        {
            //fprintf(stderr,"cannot branch to arm 0x%08X 0x%04X\n",pc,inst);
            //return(1);
            //branch to thumb
            rb=read_register(14);
            rb+=(inst&((1<<11)-1))<<1;;
            rb&=0xFFFFFFFC;
            rb+=2;

                write_register(14,(pc-2)|1);
                write_register(15,rb);
            if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"bl 0x%08X\n",rb-3);
            op1 = 0; op2 = 0;
#ifdef MASKFLOW
            if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
            if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
            return(0);

        }
    }

    //BLX(2)
    if((inst&0xFF87)==0x4780)
    {
        rm=(inst>>3)&0xF;
        rc=read_register(rm);
//fprintf(stderr,"blx r%u 0x%X 0x%X\n",rm,rc,pc);
        rc+=2;
        if(rc&1)
        {
            write_register(14,(pc-2)|1);
            rc&=~1;
            write_register(15,rc);
            if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"blx r%u\n",rm);
#ifdef MASKFLOW
            if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
            if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
            return(0);
        }
        else
        {
            fprintf(stderr,"cannot branch to arm 0x%08X 0x%04X\n",pc,inst);
            return(1);
        }
    }

    //BX
    if((inst&0xFF87)==0x4700)
    {
        rm=(inst>>3)&0xF;
        rc=read_register(rm);
        rc+=2;
//fprintf(stderr,"bx r%u 0x%X 0x%X\n",rm,rc,pc);
      //  if(rc&1)
       // {
          //  rc&=~1;
            write_register(15,rc);
            if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"bx r%u\n",rm);
            op1 = 0; op2 = 0;
#ifdef MASKFLOW
            if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
            if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
            return(0);
        //}
        //else
        //{
          //  fprintf(stderr,"cannot branch to arm 0x%08X 0x%04X\n",pc,inst);
           // return(1);
        //}
    }

    //CMN
    if((inst&0xFFC0)==0x42C0)
    {
        rn=(inst>>0)&0x7;
        rm=(inst>>3)&0x7;
        ra=read_register(rn);
        rb=read_register(rm);
        rc=ra+rb;
        op1 = 0; op2 = 0;
        
#ifdef MASKFLOW
        ra_maskflow=read_register_maskflow(rn);
        rb_maskflow = read_register_maskflow(rm);
        op1_maskflow = ra_maskflow; op2_maskflow = rb_maskflow;
#endif

        do_nflag(rc);
        do_zflag(rc);
        do_cflag(ra,rb,0);
        do_vflag(ra,rb,0);
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"cmns r%u,r%u\n",rn,rm);
        
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
        
        return(0);
    }

    //CMP(1) compare immediate
    if((inst&0xF800)==0x2800)
    {
        rb=(inst>>0)&0xFF;
        rn=(inst>>8)&0x07;
        
        ra=read_register(rn);
        op1=ra; op2=rb;
        rc=ra-rb;

        do_nflag(rc);
        do_zflag(rc);
        do_cflag(ra,~rb,1);
        do_vflag(ra,~rb,1);
        
#ifdef MASKFLOW
        ra_maskflow = read_register_maskflow(rn);
        rb_maskflow = zero_maskflow32();
        op1_maskflow = ra_maskflow; op2_maskflow = rb_maskflow;
#endif

        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"cmp r%u,#0x%02X\n",rn,rb);
        
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0);
#endif

        return(0);
    }

    //CMP(2) compare register
    if((inst&0xFFC0)==0x4280)
    {
        rn=(inst>>0)&0x7;
        rm=(inst>>3)&0x7;
        ra=read_register(rn);
        op1=ra;
        rb=read_register(rm);
        op2=rb;
        rc=ra-rb;
        
        
        do_nflag(rc);
        do_zflag(rc);
        do_cflag(ra,~rb,1);
        do_vflag(ra,~rb,1);
        
#ifdef MASKFLOW
        ra_maskflow = read_register_maskflow(rn);
        rb_maskflow = read_register_maskflow(rm);
        op1_maskflow = ra_maskflow; op2_maskflow = rb_maskflow;
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"cmps r%u,r%u\n",rn,rm);

#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0);
#endif

        return(0);
    }

    //CMP(3) compare high register
    if((inst&0xFF00)==0x4500)
    {
        if(((inst>>6)&3)==0x0)
        {
            //UNPREDICTABLE
        }
        rn=(inst>>0)&0x7;
        rn|=(inst>>4)&0x8;
        if(rn==0xF)
        {
            //UNPREDICTABLE
        }
        rm=(inst>>3)&0xF;
        
        ra=read_register(rn);
        op1=ra;
        rb=read_register(rm);
        op2=rb;
        rc=ra-rb;
        
        do_nflag(rc);
        do_zflag(rc);
        do_cflag(ra,~rb,1);
        do_vflag(ra,~rb,1);
        
#ifdef MASKFLOW
        
        ra_maskflow = read_register_maskflow(rn);
        rb_maskflow = read_register_maskflow(rm);
        op1_maskflow = ra_maskflow; op2_maskflow = rb_maskflow;
        
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"cmps r%u,r%u\n",rn,rm);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0);
#endif
        return(0);
    }

    //CPS
    if((inst&0xFFE8)==0xB660)
    {
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"cps TODO\n");
        return(1);
    }

    //CPY copy high register
    if((inst&0xFFC0)==0x4600)
    {
        //same as mov except you can use both low registers
        //going to let mov handle high registers
        rd=(inst>>0)&0x7; //mov handles the high registers
        rm=(inst>>3)&0x7; //mov handles the high registers
        
        rc=read_register(rm);
        op1=read_register(rd); op2=rc;
        write_register(rd,rc);
        
#ifdef MASKFLOW
        
        rc_maskflow = read_register_maskflow(rm);
        op1_maskflow = read_register_maskflow(rd); op2_maskflow = rc_maskflow;
        write_register_maskflow(rd, rc_maskflow);
        
#endif
        
        //if(rd==15) //mov handles the high registers like r15
        //{
            //rc&=~1;
            //rc+=2; //The program counter is special
        //}
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"cpy r%u,r%u\n",rd,rm);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0);
#endif
        return(0);
    }

    //EOR
    if((inst&0xFFC0)==0x4040)
    {
        rd=(inst>>0)&0x7;
        rm=(inst>>3)&0x7;
        ra=read_register(rd);
        rb=read_register(rm);
        rc=ra^rb;
        op1=ra; op2=rb;
        write_register(rd,rc);
        
        do_nflag(rc);
        do_zflag(rc);
        
#ifdef MASKFLOW
        
        ra_maskflow = read_register_maskflow(rd);
        rb_maskflow = read_register_maskflow(rm);
        rc_maskflow = compute_maskflow(ra_maskflow, rb_maskflow, 0, 1);
        write_register_maskflow(rd, rc_maskflow);
        op1_maskflow = ra_maskflow; op2_maskflow = rb_maskflow;
        
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"eors r%u,r%u\n",rd,rm);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0);
#endif
        return(0);
    }

    //LDMIA
    if((inst&0xF800)==0xC800)
    {
        rn=(inst>>8)&0x7;
        sp=read_register(rn);
        for(ra=0,rb=0x01;rb;rb=(rb<<1)&0xFF,ra++)
        {
            if(inst&rb)
            {

                op1 = 0; op2 = 0;
                write_register(ra,read32(sp));
                
#ifdef MASKFLOW
                
                op1_maskflow = read_register_maskflow(ra); op2_maskflow = read32_maskflow(sp);
                write_register_maskflow(ra, op2_maskflow);
                
#endif

#ifdef MASKFLOW
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
                sp+=4;
            }
        }
        //there is a write back exception.
        if((inst&(1<<rn))==0) write_register(rn,sp);
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES))
        {
            fprintf(stderr,"ldmia r%u!,{",rn);
            for(ra=0,rb=0x01,rc=0;rb;rb=(rb<<1)&0xFF,ra++)
            {
                if(inst&rb)
                {
                    if(rc) fprintf(asmoutput,",");
                    fprintf(asmoutput,"r%u",ra);
                    rc++;
                }
            }
            fprintf(asmoutput,"}\n");
        }

        return(0);
    }

    //LDR(1) two register immediate
    if((inst&0xF800)==0x6800)
    {
        rd=(inst>>0)&0x07;
        rn=(inst>>3)&0x07;
        rb=(inst>>6)&0x1F;
        rb<<=2;
        rb=read_register(rn)+rb;
        rc=read32(rb);
        op1 = read_register(rd); op2 = rc;
        write_register(rd,rc);
        
#ifdef MASKFLOW
        
        rc_maskflow = read32_maskflow(rb);
        op1_maskflow = read_register_maskflow(rd); op2_maskflow = rc_maskflow;
        write_register_maskflow(rd, rc_maskflow);
        
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)){ fprintf(asmoutput,"ldr r%u,[r%u,#0x%X]\n",rd,rn,rb);
            if(CYCLEACCURATE){
                fprintf(asmoutput,"--- 0x%08X: 0x%04X ",(pc-4),inst);
                fprintf(asmoutput,"ldr r%u,[r%u,#0x%X]\n",rd,rn,rb);
            }
        }
        
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 3, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 3);
#endif
        return(0);
    }

    //LDR(2) three register
    if((inst&0xFE00)==0x5800)
    {
        rd=(inst>>0)&0x7;
        rn=(inst>>3)&0x7;
        rm=(inst>>6)&0x7;
        rb=read_register(rn)+read_register(rm);
        //rc_maskflow = compute_maskflow(read32_maskflow(rb), read_register_maskflow(rm), 0, 0); // Need to preserve key data if used in computing address
        rc=read32(rb);
        op1 = read_register(rd); op2 = rc;
        write_register(rd,rc);
        
#ifdef MASKFLOW
        rc_maskflow = read32_maskflow(rb); // Need to preserve key data if used in computing address
        op1_maskflow = read_register_maskflow(rd); op2_maskflow = rc_maskflow;
        write_register_maskflow(rd, rc_maskflow);
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)){ fprintf(asmoutput,"ldr r%u,[r%u,r%u]\n",rd,rn,rm);
            if(CYCLEACCURATE){
                fprintf(asmoutput,"--- 0x%08X: 0x%04X ",(pc-4),inst);
                fprintf(asmoutput,"ldr r%u,[r%u,r%u]\n",rd,rn,rm);
            }
        }
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 3, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 3);
#endif
        return(0);
    }

    //LDR(3)
    if((inst&0xF800)==0x4800)
    {
        rb=(inst>>0)&0xFF;
        rd=(inst>>8)&0x07;
        rb<<=2;
        ra=read_register(15);
        ra&=~3;
        rb+=ra;
        //if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,";@ 0x%X ",rb);
        rc=read32(rb);
        op1 = read_register(rd); op2 = rc;
        write_register(rd,rc);
        
#ifdef MASKFLOW
        rc_maskflow = read32_maskflow(rb);
        op1_maskflow = read_register_maskflow(rd); op2_maskflow = rc_maskflow;
        write_register_maskflow(rd, rc_maskflow);
        
#endif

        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)){ fprintf(asmoutput,"ldr r%u,[PC+#0x%X]\n",rd,rb);
            if(CYCLEACCURATE){
                fprintf(asmoutput,"--- 0x%08X: 0x%04X ",(pc-4),inst);
                fprintf(asmoutput,"ldr r%u,[PC+#0x%X]\n",rd,rb);
            }
        }
        
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 3, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 3);
#endif
        
        return(0);
    }

    //LDR(4)
    if((inst&0xF800)==0x9800)
    {
        rb=(inst>>0)&0xFF;
        rd=(inst>>8)&0x07;
        rb<<=2;

        ra=read_register(13);
        //ra&=~3;
        rb+=ra;
        rc=read32(rb);
        op1 = read_register(rd); op2 = rc;
        write_register(rd,rc);
        
#ifdef MASKFLOW
        
        rc_maskflow = read32_maskflow(rb);
        write_register_maskflow(rd, rc_maskflow);
        op1_maskflow = read_register_maskflow(rd); op2_maskflow = rc_maskflow;
        
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)){ fprintf(asmoutput,"ldr r%u,[SP+#0x%X]\n",rd,rb);
            if(CYCLEACCURATE){
                fprintf(asmoutput,"--- 0x%08X: 0x%04X ",(pc-4),inst);
                fprintf(asmoutput,"ldr r%u,[SP+#0x%X]\n",rd,rb);
            }
        }
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 3, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 3);
#endif
        return(0);
    }

    //LDRB(1)
    if((inst&0xF800)==0x7800)
    {
        rd=(inst>>0)&0x07;
        rn=(inst>>3)&0x07;
        rb=(inst>>6)&0x1F;
        rb=read_register(rn)+rb;
        rc=read16(rb&(~1));
        
#ifdef MASKFLOW
        
        rc_maskflow=read16_maskflow(rb&(~1));
        
#endif
        
        
        if(rb&1)
        {
            rc>>=8;
            
#ifdef MASKFLOW
            
            rc_maskflow = bit8tobit16(rc_maskflow, true);
            
#endif
            
        }
        else
        {
            
#ifdef MASKFLOW
            
            rc_maskflow = bit8tobit16(rc_maskflow, false);
            
#endif
            
        }
        
        op1 = read_register(rd); op2 = rc&0xFF;
        write_register(rd,rc&0xFF);
        
#ifdef MASKFLOW
        
        op1_maskflow = read_register_maskflow(rd); op2_maskflow = rc_maskflow;
        write_register_maskflow(rd, rc_maskflow);
        
#endif
        
        //if(registerdataflow) print32(read_register_maskflow(rd));
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)){ fprintf(asmoutput,"ldrb r%u,[r%u,#0x%X]\n",rd,rn,rb);
            if(CYCLEACCURATE){
                fprintf(asmoutput,"--- 0x%08X: 0x%04X ",(pc-4),inst);
                fprintf(asmoutput,"ldrb r%u,[r%u,#0x%X]\n",rd,rn,rb);
            }
        }
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 3, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 3);
#endif
        return(0);
    }

    //LDRB(2)
    if((inst&0xFE00)==0x5C00)
    {
        rd=(inst>>0)&0x7;
        rn=(inst>>3)&0x7;
        rm=(inst>>6)&0x7;
        rb=read_register(rn)+read_register(rm);
        rc=read16(rb&(~1));
        
#ifdef MASKFLOW
        rc_maskflow = read16_maskflow(rb&(~1));
#endif
        
        if(rb&1)
        {
            rc>>=8;
            
#ifdef MASKFLOW
            rc_maskflow = bit8tobit16(rc_maskflow, true);
#endif
            
        }
        else
        {
#ifdef MASKFLOW
             rc_maskflow = bit8tobit16(rc_maskflow, false);
#endif
            
        }
        //rc_maskflow = compute_maskflow(rc_maskflow, read_register_maskflow(rm), 0, 0);
        op1 = read_register(rd); op2 = rc&0xFF;
        write_register(rd,rc&0xFF);
        
#ifdef MASKFLOW
        write_register_maskflow(rd, rc_maskflow);
        op1_maskflow = read_register_maskflow(rd); op2_maskflow = rc_maskflow;
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)){ fprintf(asmoutput,"ldrb r%u,[r%u,r%u]\n",rd,rn,rm);
            if(CYCLEACCURATE){
                fprintf(asmoutput,"--- 0x%08X: 0x%04X ",(pc-4),inst);
                fprintf(asmoutput,"ldrb r%u,[r%u,r%u]\n",rd,rn,rm);
            }
        }
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 3, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 3);
#endif
        return(0);
    }

    //LDRH(1)
    if((inst&0xF800)==0x8800)
    {
        rd=(inst>>0)&0x07;
        rn=(inst>>3)&0x07;
        rb=(inst>>6)&0x1F;
        rb<<=1;
        rb=read_register(rn)+rb;
        
        rc=read16(rb);
        op1 = read_register(rd); op2 = rc&0xFFFF;
        write_register(rd,rc&0xFFFF);
        
#ifdef MASKFLOW
        rc_maskflow = read16_maskflow(rb);
        write_register_maskflow(rd, rc_maskflow);
        op1_maskflow = read_register_maskflow(rd); op2_maskflow = rc_maskflow;
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)){ fprintf(asmoutput,"ldrh r%u,[r%u,#0x%X]\n",rd,rn,rb);
            if(CYCLEACCURATE){
                fprintf(asmoutput,"--- 0x%08X: 0x%04X ",(pc-4),inst);
                fprintf(asmoutput,"ldrh r%u,[r%u,#0x%X]\n",rd,rn,rb);
            }
        }
        
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 3, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 3);
#endif
        
        return(0);
    }

    //LDRH(2)
    if((inst&0xFE00)==0x5A00)
    {
        rd=(inst>>0)&0x7;
        rn=(inst>>3)&0x7;
        rm=(inst>>6)&0x7;
        rb=read_register(rn)+read_register(rm);
        rc=read16(rb);
        op1 = read_register(rd); op2 = rc&0xFFFF;
        write_register(rd,rc&0xFFFF);
        
#ifdef MASKFLOW
        rc_maskflow = compute_maskflow(read16_maskflow(rb), read_register_maskflow(rm), 0, 0);
        write_register_maskflow(rd, rc_maskflow);
        op1_maskflow = read_register_maskflow(rd); op2_maskflow = rc_maskflow;
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)){ fprintf(asmoutput,"ldrh r%u,[r%u,r%u]\n",rd,rn,rm);
            if(CYCLEACCURATE){
                fprintf(asmoutput,"--- 0x%08X: 0x%04X ",(pc-4),inst);
                fprintf(asmoutput,"ldrh r%u,[r%u,r%u]\n",rd,rn,rm);
            }
        }
        
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 3, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 3);
#endif
        
        return(0);
    }

    //LDRSB
    if((inst&0xFE00)==0x5600)
    {
        rd=(inst>>0)&0x7;
        rn=(inst>>3)&0x7;
        rm=(inst>>6)&0x7;
        rb=read_register(rn)+read_register(rm);
        rc=read16(rb&(~1));
        
#ifdef MASKFLOW
        rc_maskflow = read16_maskflow(rb&(~1));
#endif
        if(rb&1)
        {
            rc>>=8;
#ifdef MASKFLOW
            rc_maskflow = bit8tobit16(rc_maskflow, true);
#endif
        }
        else
        {
#ifdef MASKFLOW
            rc_maskflow = bit8tobit16(rc_maskflow, false);
#endif
        }
        rc&=0xFF;
        if(rc&0x80) rc|=((~0)<<8);
        op1 = 0; op2 = 0;
        write_register(rd,rc);
        
#ifdef MASKFLOW
        rc_maskflow = compute_maskflow(rc_maskflow, read_register_maskflow(rm), 0, 0);
        write_register_maskflow(rd, rc_maskflow);
        op1_maskflow = read_register_maskflow(rd); op2_maskflow = rc_maskflow;
#endif

        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"ldrsb r%u,[r%u,r%u]\n",rd,rn,rm);

#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
        return(0);
    }

    //LDRSH
    if((inst&0xFE00)==0x5E00)
    {
        rd=(inst>>0)&0x7;
        rn=(inst>>3)&0x7;
        rm=(inst>>6)&0x7;
        rb=read_register(rn)+read_register(rm);
        rc=read16(rb);
    
        rc&=0xFFFF;
        if(rc&0x8000) rc|=((~0)<<16);
        op1 = 0; op2 = 0;
        write_register(rd,rc);
        
#ifdef MASKFLOW
        
        rc_maskflow = compute_maskflow(read16_maskflow(rb), read_register_maskflow(rm), 0, 0);
        write_register_maskflow(rd, rc_maskflow);
        op1_maskflow = read_register_maskflow(rd); op2_maskflow = rc_maskflow;

#endif

        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"ldrsh r%u,[r%u,r%u]\n",rd,rn,rm);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
        return(0);
    }

    //LSL(1)
    if((inst&0xF800)==0x0000)
    {
        rd=(inst>>0)&0x07;
        rm=(inst>>3)&0x07;
        rb=(inst>>6)&0x1F;
        rc=read_register(rm);
        op1=rc; op2=rb;
        
#ifdef MASKFLOW
        rc_maskflow = read_register_maskflow(rm);
        op1_maskflow = rc_maskflow; op2_maskflow = zero_maskflow32();
#endif
        
        if(rb==0)
        {
            //if immed_5 == 0
            //C unnaffected
            //result not shifted
        }
        else
        {
            //else immed_5 > 0
            do_cflag_bit(rc&(1<<(32-rb)));
            rc<<=rb;
            
#ifdef MASKFLOW
            rc_maskflow = compute_maskflow(rc_maskflow, zero_maskflow32(), rb, 2);
#endif
            
        }
        
        op1 = 0; op2 = 0;
        write_register(rd,rc);
        
        do_nflag(rc);
        do_zflag(rc);
        
#ifdef MASKFLOW
        write_register_maskflow(rd, rc_maskflow);
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"lsls r%u,r%u,#0x%X\n",rd,rm,rb);
        
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
        
        return(0);
    }

    //LSL(2) two register
    if((inst&0xFFC0)==0x4080)
    {
        rd=(inst>>0)&0x07;
        rs=(inst>>3)&0x07;
        rc=read_register(rd);
        rb=read_register(rs);
        op1=rc; op2=rb;
        
#ifdef MASKFLOW
        rc_maskflow = read_register_maskflow(rd);
        rb_maskflow = read_register_maskflow(rs);
        op1_maskflow = rc_maskflow; op2_maskflow = rb_maskflow;
#endif
        
        rb&=0xFF;
        if(rb==0)
        {
        }
        else if(rb<32)
        {
            do_cflag_bit(rc&(1<<(32-rb)));
            rc<<=rb;
            
#ifdef MASKFLOW
            rc_maskflow = compute_maskflow(rc_maskflow, rb_maskflow, rb, 2);
#endif
            
        }
        else if(rb==32)
        {
            do_cflag_bit(rc&1);
            rc=0;
            
#ifdef MASKFLOW
            rc_maskflow = zero_maskflow32();
#endif
        }
        else
        {
            do_cflag_bit(0);
            rc=0;

#ifdef MASKFLOW
            rc_maskflow = zero_maskflow32();
#endif

        }
        write_register(rd,rc);

        do_nflag(rc);
        do_zflag(rc);
        
#ifdef MASKFLOW
        write_register_maskflow(rd, rc_maskflow);
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"lsls r%u,r%u\n",rd,rs);

#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 1, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 1);
#endif
        
        return(0);
    }

    //LSR(1) two register immediate
    if((inst&0xF800)==0x0800)
    {
        rd=(inst>>0)&0x07;
        rm=(inst>>3)&0x07;
        rb=(inst>>6)&0x1F;
        
        rc=read_register(rm);
        op1=rc; op2=rb;
        
#ifdef MASKFLOW
        rc_maskflow = read_register_maskflow(rm);
        op1_maskflow = rc_maskflow; op2_maskflow = zero_maskflow32();
#endif

	if(rb==0)
        {
            do_cflag_bit(rc&0x80000000);
            rc=0;
        }
        else
        {
            do_cflag_bit(rc&(1<<(rb-1)));
            rc>>=rb;
            
#ifdef MASKFLOW
            rc_maskflow = compute_maskflow(rc_maskflow, zero_maskflow32(), rb, 3);
#endif
            
        }
        
        op1 = 0; op2 = 0;
        write_register(rd,rc);
        
        do_nflag(rc);
        do_zflag(rc);
        
#ifdef MASKFLOW
        write_register_maskflow(rd, rc_maskflow);
#endif

        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"lsrs r%u,r%u,#0x%X\n",rd,rm,rb);
        
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif        
        return(0);
    }

    //LSR(2) two register
    if((inst&0xFFC0)==0x40C0)
    {
        rd=(inst>>0)&0x07;
        rs=(inst>>3)&0x07;
        rc=read_register(rd);
        rb=read_register(rs);
        op1=rc; op2=rb;

#ifdef MASKFLOW
        
        rc_maskflow = read_register_maskflow(rd);
        rb_maskflow = read_register_maskflow(rs);
        op1_maskflow = rc_maskflow; op2_maskflow = rb_maskflow;
        
#endif

        rb&=0xFF;
        if(rb==0)
        {
        }
        else if(rb<32)
        {
            do_cflag_bit(rc&(1<<(rb-1)));
            rc>>=rb;
#ifdef MASKFLOW
            rc_maskflow = compute_maskflow(rc_maskflow, rb_maskflow, rb, 3);
#endif
        }
        else if(rb==32)
        {
            do_cflag_bit(rc&0x80000000);
            rc=0;
#ifdef MASKFLOW
            rc_maskflow = zero_maskflow32();
#endif
        }
        else
        {
            do_cflag_bit(0);
            rc=0;
#ifdef MASKFLOW
            rc_maskflow = zero_maskflow32();
#endif
        }

        write_register(rd,rc);
        do_nflag(rc);
        do_zflag(rc);
        
#ifdef MASKFLOW
        write_register_maskflow(rd, rc_maskflow);
#endif

        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"lsrs r%u,r%u\n",rd,rs);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 1, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 1);
#endif
        return(0);
    }

    //MOV(1) immediate
    if((inst&0xF800)==0x2000)
    {
        rb=(inst>>0)&0xFF;
        rd=(inst>>8)&0x07;
        
        op1=read_register(rd); op2=rb;
        write_register(rd,rb);
        
        do_nflag(rb);
        do_zflag(rb);

#ifdef MASKFLOW
        write_register_maskflow(rd, zero_maskflow32());
        op1_maskflow = read_register_maskflow(rd); op2_maskflow = zero_maskflow32();
#endif
        

        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"movs r%u,#0x%02X\n",rd,rb);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0);
#endif
        return(0);
    }

    //MOV(2) two low registers
    if((inst&0xFFC0)==0x1C00)
    {
        rd=(inst>>0)&7;
        rn=(inst>>3)&7;
        ra=read_register(rd);
        rc=read_register(rn);
        write_register(rd,rc);
        op1=ra; op2=rc;
        
#ifdef MASKFLOW
        ra_maskflow = read_register_maskflow(rd);
        rc_maskflow = read_register_maskflow(rn);
        write_register_maskflow(rd, rc_maskflow);
        op1_maskflow = ra_maskflow; op2_maskflow = rc_maskflow;
#endif
        
        do_nflag(rc);
        do_zflag(rc);
        do_cflag_bit(0);
        do_vflag_bit(0);
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"movs r%u,r%u\n",rd,rn);
        
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0);
#endif
        
        return(0);
    }

    //MOV(3)
    if((inst&0xFF00)==0x4600)
    {
        rd=(inst>>0)&0x7;
        rd|=(inst>>4)&0x8;
        rm=(inst>>3)&0xF;
        ra=read_register(rd);
        rc=read_register(rm);
        op1=ra; op2=rc;

        if((rd==14)&&(rm==15))
        {
            //printf("mov lr,pc warning 0x%08X\n",pc-2);
            //rc|=1;
        }
        if(rd==15)
        {
            //if((rc&1)==0)
            //{
                //fprintf(stderr,"cpy or mov pc,... produced an ARM address 0x%08X 0x%08X\n",pc,rc);
                //exit(1);
            //}
            rc&=~1; //write_register may do this as well
            rc+=2; //The program counter is special
        }
        
        write_register(rd,rc);
        
#ifdef MASKFLOW
        ra_maskflow = read_register_maskflow(rd);
        rc_maskflow = read_register_maskflow(rm);
        op1_maskflow = ra_maskflow; op2_maskflow = rc_maskflow;
        write_register_maskflow(rd, rc_maskflow);
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"mov r%u,r%u\n",rd,rm);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0);
#endif
        return(0);
    }

    //MUL
    if((inst&0xFFC0)==0x4340)
    {
        rd=(inst>>0)&0x7;
        rm=(inst>>3)&0x7;
        
        ra=read_register(rd);
        op1=ra;
        rb=read_register(rm);
        op2=rb;
        
        rc=ra*rb;
        write_register(rd,rc);

        do_nflag(rc);
        do_zflag(rc);
        
#ifdef MASKFLOW
        ra_maskflow = read_register_maskflow(rd);
        rb_maskflow = read_register_maskflow(rm);
        rc_maskflow = compute_maskflow(ra_maskflow, rb_maskflow, 0, 0);
        write_register_maskflow(rd, rc_maskflow);
        op1_maskflow = ra_maskflow; op2_maskflow = rb_maskflow;
#endif

        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"muls r%u,r%u\n",rd,rm);
        
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 4, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 4);
#endif
        
        return(0);
    }

    //MVN
    if((inst&0xFFC0)==0x43C0)
    {
        rd=(inst>>0)&0x7;
        rm=(inst>>3)&0x7;
        
        ra=read_register(rm);
        rc=(~ra);
        op1 = 0; op2 = 0;
        write_register(rd,rc);
        do_nflag(rc);
        do_zflag(rc);
        
#ifdef MASKFLOW
        
        rc_maskflow = read_register_maskflow(rm);
        write_register_maskflow(rd,rc_maskflow);
        op1_maskflow = read_register_maskflow(rd); op2_maskflow = rc_maskflow;
        
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"mvns r%u,r%u\n",rd,rm);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
        return(0);
    }

    //NEG
    if((inst&0xFFC0)==0x4240)
    {
        rd=(inst>>0)&0x7;
        rm=(inst>>3)&0x7;
        
        ra=read_register(rm);
        rc=0-ra;
        op1 = 0; op2 = 0;
        write_register(rd,rc);
        
        do_nflag(rc);
        do_zflag(rc);
        do_cflag(0,~ra,1);
        do_vflag(0,~ra,1);
        
#ifdef MASKFLOW
        rc_maskflow = read_register_maskflow(rm);
        op1_maskflow = read_register_maskflow(rd); op2_maskflow = rc_maskflow;
        write_register_maskflow(rd, rc_maskflow);
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"negs r%u,r%u\n",rd,rm);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
        return(0);
    }

    //ORR
    if((inst&0xFFC0)==0x4300)
    {
        rd=(inst>>0)&0x7;
        rm=(inst>>3)&0x7;
        
        ra=read_register(rd);
        op1=ra;
        rb=read_register(rm);
        op2=rb;
        rc=ra|rb;
        write_register(rd,rc);
        
        do_nflag(rc);
        do_zflag(rc);
        
#ifdef MASKFLOW
        ra_maskflow = read_register_maskflow(rd);
        rb_maskflow = read_register_maskflow(rm);
        rc_maskflow = compute_maskflow(rc_maskflow, rb_maskflow, 0, 0);
        op1_maskflow = ra_maskflow; op2_maskflow = rb_maskflow;
        write_register_maskflow(rd, rc_maskflow);
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"orrs r%u,r%u\n",rd,rm);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0);
#endif
        return(0);
    }

    //POP
    if((inst&0xFE00)==0xBC00)
    {

        sp=read_register(13);
        for(ra=0,rb=0x01;rb;rb=(rb<<1)&0xFF,ra++)
        {
            if(inst&rb)
            {
                op1 = 0; op2 = 0;
                write_register(ra,read32(sp));
                
#ifdef MASKFLOW
                write_register_maskflow(ra, read32_maskflow(sp));
                op1_maskflow = read_register_maskflow(ra); op2_maskflow = read32_maskflow(sp);
#endif

#ifdef MASKFLOW
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
                sp+=4;
            }
        }
        if(inst&0x100)
        {
            rc=read32(sp);
            if((rc&1)==0)
            {
                fprintf(stderr,"pop {rc} with an ARM address pc 0x%08X popped 0x%08X\n",pc,rc);
                //exit(1);
                rc&=~1;
            }
            rc+=2;
            write_register(15,rc);
            sp+=4;
        }
        write_register(13,sp);
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES))
        {
            fprintf(asmoutput,"pop {");
            for(ra=0,rb=0x01,rc=0;rb;rb=(rb<<1)&0xFF,ra++)
            {
                if(inst&rb)
                {
                    if(rc) fprintf(asmoutput,"\n");
                    fprintf(asmoutput,"r%u",ra);
                    rc++;
                }
            }
            if(inst&0x100)
            {
                if(rc) fprintf(asmoutput,",");
                fprintf(asmoutput,"pc");
            }
            fprintf(asmoutput,"}\n");
        }
        return(0);
    }

    //PUSH
    if((inst&0xFE00)==0xB400)
    {
        sp=read_register(13);
        for(ra=0,rb=0x01,rc=0;rb;rb=(rb<<1)&0xFF,ra++)
        {
            if(inst&rb)
            {
                rc++;
            }
        }
        if(inst&0x100) rc++;
        rc<<=2;
        sp-=rc;
        rd=sp;
        for(ra=0,rb=0x01;rb;rb=(rb<<1)&0xFF,ra++)
        {
            if(inst&rb)
            {
                op1 = 0; op2 = 0;
                write32(rd,read_register(ra));
                
#ifdef MASKFLOW
                write32_maskflow(rd, read_register_maskflow(ra));
                op1_maskflow = read_register_maskflow(ra); op2_maskflow = read32_maskflow(rd);
#endif

#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif

                rd+=4;
            }
        }
        if(inst&0x100)
        {
            rc=read_register(14);
            write32(rd,rc); //read_register(14));

            if((rc&1)==0)
            {
                fprintf(stderr,"push {lr} with an ARM address pc 0x%08X popped 0x%08X\n",pc,rc);
//                exit(1);
            }
        }
        
        write_register(13,sp);
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES))
        {
            fprintf(asmoutput,"push {");
            for(ra=0,rb=0x01,rc=0;rb;rb=(rb<<1)&0xFF,ra++)
            {
                if(inst&rb)
                {
                    if(rc) fprintf(asmoutput,"\n");
                    fprintf(asmoutput,"r%u",ra);
                    rc++;
                }
            }
            if(inst&0x100)
            {
                if(rc) fprintf(asmoutput,",");
                fprintf(asmoutput,"lr");
            }
            fprintf(asmoutput,"}\n");
        }
        return(0);
    }

    //REV
    if((inst&0xFFC0)==0xBA00)
    {
        rd=(inst>>0)&0x7;
        rn=(inst>>3)&0x7;
        ra=read_register(rn);
        rc =((ra>> 0)&0xFF)<<24;
        rc|=((ra>> 8)&0xFF)<<16;
        rc|=((ra>>16)&0xFF)<< 8;
        rc|=((ra>>24)&0xFF)<< 0;
        
        op1 = 0; op2 = 0;
        write_register(rd,rc);
        
#ifdef MASKFLOW
        
        rb_maskflow = read_register_maskflow(rd);
        ra_maskflow = read_register_maskflow(rn);
        rc_maskflow = compute_maskflow(compute_maskflow(bit8tobit16(compute_maskflow(ra_maskflow, zero_maskflow32(), 0, 3), false), zero_maskflow32(), 24, 2), rc_maskflow,0,0);
        rc_maskflow = compute_maskflow(compute_maskflow(bit8tobit16(compute_maskflow(ra_maskflow, zero_maskflow32(), 8, 3), false), zero_maskflow32(), 16, 2), rc_maskflow,0,0);
        rc_maskflow = compute_maskflow(compute_maskflow(bit8tobit16(compute_maskflow(ra_maskflow, zero_maskflow32(), 16, 3), false), zero_maskflow32(), 8, 2), rc_maskflow,0,0);
        rc_maskflow = compute_maskflow(compute_maskflow(bit8tobit16(compute_maskflow(ra_maskflow, zero_maskflow32(), 24, 3), false), zero_maskflow32(), 0, 2), rc_maskflow,0,0);
        op1_maskflow = rb_maskflow; op2_maskflow = ra_maskflow;
        write_register_maskflow(rd, rc_maskflow);
        
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"rev r%u,r%u\n",rd,rn);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
        return(0);
    }

    //REV16
    if((inst&0xFFC0)==0xBA40)
    {
        rd=(inst>>0)&0x7;
        rn=(inst>>3)&0x7;
        ra=read_register(rn);

        rc =((ra>> 0)&0xFF)<< 8;
        rc|=((ra>> 8)&0xFF)<< 0;
        rc|=((ra>>16)&0xFF)<<24;
        rc|=((ra>>24)&0xFF)<<16;

        op1 = 0; op2 = 0;
        write_register(rd,rc);
        
#ifdef MASKFLOW

        rb_maskflow = read_register_maskflow(rd);
        ra_maskflow = read_register_maskflow(rn);
        rc_maskflow = compute_maskflow(compute_maskflow(bit8tobit16(compute_maskflow(ra_maskflow, zero_maskflow32(), 0, 3), false), zero_maskflow32(), 8, 2), rc_maskflow,0,0);
        rc_maskflow = compute_maskflow(compute_maskflow(bit8tobit16(compute_maskflow(ra_maskflow, zero_maskflow32(), 8, 3), false), zero_maskflow32(), 0, 2), rc_maskflow,0,0);
        rc_maskflow = compute_maskflow(compute_maskflow(bit8tobit16(compute_maskflow(ra_maskflow, zero_maskflow32(), 16, 3), false), zero_maskflow32(), 24, 2), rc_maskflow,0,0);
        rc_maskflow = compute_maskflow(compute_maskflow(bit8tobit16(compute_maskflow(ra_maskflow, zero_maskflow32(), 24, 3), false), zero_maskflow32(), 16, 2), rc_maskflow,0,0);
        op1_maskflow = rb_maskflow; op2_maskflow = ra_maskflow;
        write_register_maskflow(rd, rc_maskflow);
        
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"rev16 r%u,r%u\n",rd,rn);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
        return(0);
    }

    //REVSH
    if((inst&0xFFC0)==0xBAC0)
    {
        rd=(inst>>0)&0x7;
        rn=(inst>>3)&0x7;
        ra=read_register(rn);
        rc =((ra>> 0)&0xFF)<< 8;
        rc|=((ra>> 8)&0xFF)<< 0;
        if(rc&0x8000) rc|=0xFFFF0000;
        else          rc&=0x0000FFFF;
        
        op1 = 0; op2 = 0;
        write_register(rd,rc);
        
#ifdef MASKFLOW
        
        rb_maskflow = read_register_maskflow(rd);
        ra_maskflow = read_register_maskflow(rn);
        rc_maskflow = compute_maskflow(compute_maskflow(bit8tobit16(compute_maskflow(ra_maskflow, zero_maskflow32(), 0, 3), false), zero_maskflow32(), 8, 2), rc_maskflow,0,0);
        rc_maskflow = compute_maskflow(compute_maskflow(bit8tobit16(compute_maskflow(ra_maskflow, zero_maskflow32(), 8, 3), false), zero_maskflow32(), 0, 2), rc_maskflow,0,0);
        op1_maskflow = rb_maskflow; op2_maskflow = ra_maskflow;
        write_register_maskflow(rd, rc_maskflow);
        
#endif

        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"revsh r%u,r%u\n",rd,rn);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
        return(0);
    }

    //ROR
    if((inst&0xFFC0)==0x41C0)
    {
        rd=(inst>>0)&0x7;
        rs=(inst>>3)&0x7;
        rc=read_register(rd);
        ra=read_register(rs);
        op1=rc; op2=ra;
        ra&=0xFF;
        
        if(ra==0)
        {
        }
        else
        {
            ra&=0x1F;
            if(ra==0)
            {
                do_cflag_bit(rc&0x80000000);
            }
            else
            {
                do_cflag_bit(rc&(1<<(ra-1)));
                rb=rc<<(32-ra);
                rc>>=ra;
                rc|=rb;
                
#ifdef MASKFLOW
                rc_maskflow = read_register_maskflow(rd);
                ra_maskflow = read_register_maskflow(rs);
                op1_maskflow = rc_maskflow; op2_maskflow = ra_maskflow;
                rc_maskflow = compute_maskflow(rc_maskflow, ra_maskflow, ra, 4);
                write_register_maskflow(rd, rc_maskflow);
#endif
                
            }
        }
        
        write_register(rd,rc);
        do_nflag(rc);
        do_zflag(rc);
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"rors r%u,r%u\n",rd,rs);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 1, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 1);
#endif
        return(0);
    }

    //SBC
    if((inst&0xFFC0)==0x4180)
    {
        rd=(inst>>0)&0x7;
        rm=(inst>>3)&0x7;
        ra=read_register(rd);
        rb=read_register(rm);
        rc=ra-rb;
        if(!(cpsr&CPSR_C)) rc--;
        
        op1 = 0; op2 = 0;
        write_register(rd,rc);

        do_nflag(rc);
        do_zflag(rc);
        if(cpsr&CPSR_C)
        {
            do_cflag(ra,~rb,1);
            do_vflag(ra,~rb,1);
        }
        else
        {
            do_cflag(ra,~rb,0);
            do_vflag(ra,~rb,0);
        }
        
#ifdef MASKFLOW
        
        ra_maskflow = read_register_maskflow(rd);
        rb_maskflow = read_register_maskflow(rm);
        rc_maskflow = compute_maskflow(ra_maskflow, rb_maskflow, 0, 0);
        op1_maskflow = ra_maskflow; op2_maskflow = rb_maskflow;
        write_register_maskflow(rd, rc_maskflow);
        
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"sbc r%u,r%u\n",rd,rm);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
        return(0);
    }

    //SETEND
    if((inst&0xFFF7)==0xB650)
    {
        fprintf(stderr,"setend not implemented\n");
        return(1);
    }

    //STMIA
    if((inst&0xF800)==0xC000)
    {
        rn=(inst>>8)&0x7;


        sp=read_register(rn);
        for(ra=0,rb=0x01;rb;rb=(rb<<1)&0xFF,ra++)
        {
            if(inst&rb)
            {
                op1 = 0; op2 = 0;
                write32(sp,read_register(ra));
                
#ifdef MASKFLOW

                write32_maskflow(sp, read_register_maskflow(ra));
                op1_maskflow = read_register_maskflow(ra); op2_maskflow = read32_maskflow(sp);
                
#endif

#ifdef MASKFLOW
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
                if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif                
                sp+=4;
            }
        }
        write_register(rn,sp);
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES))
        {
            fprintf(asmoutput,"stmia r%u!,{",rn);
            for(ra=0,rb=0x01,rc=0;rb;rb=(rb<<1)&0xFF,ra++)
            {
                if(inst&rb)
                {
                    if(rc) fprintf(asmoutput,",");
                    fprintf(asmoutput,"r%u",ra);
                    rc++;
                }
            }
            fprintf(asmoutput,"}\n");
        }
        return(0);
    }

    //STR(1)
    if((inst&0xF800)==0x6000)
    {
        rd=(inst>>0)&0x07;
        rn=(inst>>3)&0x07;
        rb=(inst>>6)&0x1F;
        rb<<=2;

        rb=read_register(rn)+rb;
        rc=read_register(rd);
        op1 = read32(rb); op2 = rc;
        write32(rb,rc);
        
#ifdef MASKFLOW
        rc_maskflow = read_register_maskflow(rd);
        write32_maskflow(rb, rc_maskflow);
        op1_maskflow = read32_maskflow(rb); op2_maskflow = rc_maskflow;
#endif

        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)){ fprintf(asmoutput,"str r%u,[r%u,#0x%X]\n",rd,rn,rb);
            if(CYCLEACCURATE){
                fprintf(asmoutput,"--- 0x%08X: 0x%04X ",(pc-4),inst);
                fprintf(asmoutput,"str r%u,[r%u,#0x%X]\n",rd,rn,rb);
            }
        }
        
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 2, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 2);
#endif
        return(0);
    }

    //STR(2)
    if((inst&0xFE00)==0x5000)
    {
        rd=(inst>>0)&0x7;
        rn=(inst>>3)&0x7;
        rm=(inst>>6)&0x7;
        
        
        rb=read_register(rn)+read_register(rm);
        rc=read_register(rd);
        op1 = read32(rb); op2 = rc;
        write32(rb,rc);
        
#ifdef MASKFLOW
        
        rc_maskflow = read_register_maskflow(rd);
        write32_maskflow(rb, rc_maskflow);
        op1_maskflow = read32_maskflow(rb); op2_maskflow = rc_maskflow;
        
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)){fprintf(asmoutput,"str r%u,[r%u,r%u]\n",rd,rn,rm);
            if(CYCLEACCURATE){
                fprintf(asmoutput,"--- 0x%08X: 0x%04X ",(pc-4),inst);
                fprintf(asmoutput,"str r%u,[r%u,r%u]\n",rd,rn,rm);
            }
        }
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 2, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 2);
#endif
        return(0);
    }

    //STR(3)
    if((inst&0xF800)==0x9000)
    {
        rb=(inst>>0)&0xFF;
        rd=(inst>>8)&0x07;
        rb<<=2;

        rb=read_register(13)+rb;
        rc=read_register(rd);
        op1 = read32(rb); op2 = rc;
        write32(rb,rc);
        
#ifdef MASKFLOW

        rc_maskflow = read_register_maskflow(rd);
        op1_maskflow = read32_maskflow(rb); op2_maskflow = rc_maskflow;
        write32_maskflow(rb, rc_maskflow);
        
#endif

        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)){ fprintf(asmoutput,"str r%u,[SP,#0x%X]\n",rd,rb);
            if(CYCLEACCURATE){
                fprintf(asmoutput,"--- 0x%08X: 0x%04X ",(pc-4),inst);
                fprintf(asmoutput,"str r%u,[SP,#0x%X]\n",rd,rb);
            }
        }
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 2, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 2);
#endif
        return(0);
    }

    //STRB(1)
    if((inst&0xF800)==0x7000)
    {
        rd=(inst>>0)&0x07;
        rn=(inst>>3)&0x07;
        rb=(inst>>6)&0x1F;
        
        rb=read_register(rn)+rb;
        rc=read_register(rd);
        ra=read16(rb&(~1));
        
#ifdef MASKFLOW
        
        rc_maskflow = read_register_maskflow(rd);
        ra_maskflow = read16_maskflow(rb&(~1));
        
#endif
        
        if(rb&1)
        {
            ra&=0x00FF;
            ra|=rc<<8;
            
#ifdef MASKFLOW
                ra_maskflow = bit8tobit16(ra_maskflow, false);
                rc_maskflow = bit8tobit16(rc_maskflow, false);
             //   print32(rc_maskflow);
                ra_maskflow = compute_maskflow(ra_maskflow, rotatematrixleft(rc_maskflow, 8), 0, 1);
#endif
            
        }
        else
        {
            ra&=0xFF00;
            ra|=rc&0x00FF;
            
#ifdef MASKFLOW
                ra_maskflow = bit8tobit16(ra_maskflow, true);
                rc_maskflow = bit8tobit16(rc_maskflow, false);
            	ra_maskflow = compute_maskflow(rotatematrixleft(ra_maskflow, 8), rc_maskflow, 0, 1);
#endif
            
        }
        
        op1 = read32(rb); op2 = rc;
        write16(rb&(~1),ra&0xFFFF);
        
#ifdef MASKFLOW
        
        write16_maskflow(rb&(~1),ra_maskflow);
        op2_maskflow = rc_maskflow; op1_maskflow = read32_maskflow(rb);
        
#endif

        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)){ fprintf(asmoutput,"strb r%u,[r%u,#0x%X]\n",rd,rn,rb);
            if(CYCLEACCURATE){
                fprintf(asmoutput,"--- 0x%08X: 0x%04X ",(pc-4),inst);
                fprintf(asmoutput,"strb r%u,[r%u,#0x%X]\n",rd,rn,rb);
            }
        }
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 2, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 2);
#endif
        return(0);
    }

    //STRB(2)
    if((inst&0xFE00)==0x5400)
    {
        rd=(inst>>0)&0x7;
        rn=(inst>>3)&0x7;
        rm=(inst>>6)&0x7;


        rb=read_register(rn)+read_register(rm);
        rc=read_register(rd);
        ra=read16(rb&(~1));

#ifdef MASKFLOW
        
        rc_maskflow = read_register_maskflow(rd);
        ra_maskflow = read16_maskflow(rb&(~1));
        
#endif

        if(rb&1)
        {
            ra&=0x00FF;
            ra|=rc<<8;
            
#ifdef MASKFLOW
                ra_maskflow = bit8tobit16(ra_maskflow, false);
                rc_maskflow = bit8tobit16(rc_maskflow, false);
               // print32(rc_maskflow);
                ra_maskflow = compute_maskflow(ra_maskflow, rotatematrixleft(rc_maskflow, 8), 0, 1);
#endif
            
        }
        else
        {
            ra&=0xFF00;
            ra|=rc&0x00FF;
            
#ifdef MASKFLOW
                ra_maskflow = bit8tobit16(ra_maskflow, true);
                rc_maskflow = bit8tobit16(rc_maskflow, false);
                ra_maskflow = compute_maskflow(rotatematrixleft(ra_maskflow, 8), rc_maskflow, 0, 1);
#endif
            
        }
        
        op1 = read32(rb); op2 = rc;
        write16(rb&(~1),ra&0xFFFF);
        
#ifdef MASKFLOW

        write16_maskflow(rb&(~1),ra_maskflow);
        op1_maskflow = zero_maskflow32(); op2_maskflow = rc_maskflow;

#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)){ fprintf(asmoutput,"strb r%u,[r%u,r%u]\n",rd,rn,rm);
            if(CYCLEACCURATE){
                fprintf(asmoutput,"--- 0x%08X: 0x%04X ",(pc-4),inst);
                fprintf(asmoutput,"strb r%u,[r%u,r%u]\n",rd,rn,rm);
            }
        }
        
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 2, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 2);
#endif
        return(0);
    }

    //STRH(1)
    if((inst&0xF800)==0x8000)
    {
        rd=(inst>>0)&0x07;
        rn=(inst>>3)&0x07;
        rb=(inst>>6)&0x1F;
        rb<<=1;
        rb=read_register(rn)+rb;
        rc=read_register(rd);

        op1 = read32(rb); op2 = rc;
        write16(rb,rc&0xFFFF);
        
#ifdef MASKFLOW
        
        rc_maskflow = read_register_maskflow(rd);
        write16_maskflow(rb, rc_maskflow);
        op1_maskflow = read32_maskflow(rb); op2_maskflow = rc_maskflow;
        
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)){ fprintf(asmoutput,"strh r%u,[r%u,#0x%X]\n",rd,rn,rb);
            if(CYCLEACCURATE){
                fprintf(asmoutput,"--- 0x%08X: 0x%04X ",(pc-4),inst);
                fprintf(asmoutput,"strh r%u,[r%u,#0x%X]\n",rd,rn,rb);
            }
        }
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 2, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 2);
#endif
        return(0);
    }

    //STRH(2)
    if((inst&0xFE00)==0x5200)
    {
        rd=(inst>>0)&0x7;
        rn=(inst>>3)&0x7;
        rm=(inst>>6)&0x7;
        rb=read_register(rn)+read_register(rm);
        rc=read_register(rd);

        op1 = read32(rb); op2 = rc;
        write16(rb,rc&0xFFFF);
        
#ifdef MASKFLOW
        
        rc_maskflow = read_register_maskflow(rd);
        write16_maskflow(rb, rc_maskflow);
        op1_maskflow = read32_maskflow(rb); op2_maskflow = rc_maskflow;
        
#endif

        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)){ fprintf(asmoutput,"strb r%u,[r%u,r%u]\n",rd,rn,rm);
            if(CYCLEACCURATE){
                fprintf(asmoutput,"--- 0x%08X: 0x%04X ",(pc-4),inst);
                fprintf(asmoutput,"strh r%u,[r%u,r%u]\n",rd,rn,rm);
            }
        }
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 2, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 2);
#endif
        return(0);
    }

    //SUB(1)
    if((inst&0xFE00)==0x1E00)
    {
        rd=(inst>>0)&7;
        rn=(inst>>3)&7;
        rb=(inst>>6)&7;
        ra=read_register(rn);
        rc=ra-rb;
        op1=ra; op2=rb;
        write_register(rd,rc);
        
#ifdef MASKFLOW
        
        ra_maskflow = read_register_maskflow(rn);
        rc_maskflow = compute_maskflow(ra_maskflow, zero_maskflow32(), 0, 0);
        write_register_maskflow(rd, rc_maskflow);
        op1_maskflow = ra_maskflow; op2_maskflow = zero_maskflow32();
        
#endif

        do_nflag(rc);
        do_zflag(rc);
        do_cflag(ra,~rb,1);
        do_vflag(ra,~rb,1);
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"subs r%u,r%u,#0x%X\n",rd,rn,rb);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0);
#endif
        return(0);
    }

    //SUB(2)
    if((inst&0xF800)==0x3800)
    {
        rb=(inst>>0)&0xFF;
        rd=(inst>>8)&0x07;
        ra=read_register(rd);
        rc=ra-rb;
        op1=ra; op2=rb;
        write_register(rd,rc);

#ifdef MASKFLOW
        
        ra_maskflow = read_register_maskflow(rd);
        rc_maskflow = compute_maskflow(ra_maskflow, zero_maskflow32(), 0, 0);
        write_register_maskflow(rd, rc_maskflow);
        op1_maskflow = ra_maskflow; op2_maskflow = zero_maskflow32();

#endif
        
        do_nflag(rc);
        do_zflag(rc);
        do_cflag(ra,~rb,1);
        do_vflag(ra,~rb,1);
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"subs r%u,#0x%02X\n",rd,rb);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0);
#endif
        return(0);
    }

    //SUB(3)
    if((inst&0xFE00)==0x1A00)
    {
        rd=(inst>>0)&0x7;
        rn=(inst>>3)&0x7;
        rm=(inst>>6)&0x7;
        ra=read_register(rn);
        rb=read_register(rm);
        rc=ra-rb;
        op1=ra; op2=rb;
        write_register(rd,rc);
        
#ifdef MASKFLOW
        
        ra_maskflow = read_register_maskflow(rn);
        rb_maskflow = read_register_maskflow(rm);
        rc_maskflow = compute_maskflow(ra_maskflow, rb_maskflow, 0, 0);
        op1_maskflow = ra_maskflow; op2_maskflow = rb_maskflow;
        write_register_maskflow(rd, rc_maskflow);
        
#endif
        
        do_nflag(rc);
        do_zflag(rc);
        do_cflag(ra,~rb,1);
        do_vflag(ra,~rb,1);
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"subs r%u,r%u,r%u\n",rd,rn,rm);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0);
#endif
        return(0);
    }

    //SUB(4)
    if((inst&0xFF80)==0xB080)
    {
        rb=inst&0x7F;
        rb<<=2;
        
        ra=read_register(13);
        op1 = ra; op2 = rb;
        ra-=rb;
        write_register(13,ra);

#ifdef MASKFLOW
        
        ra_maskflow = read_register_maskflow(13);
        op1_maskflow = ra_maskflow; op2_maskflow = zero_maskflow32();
        
#endif

        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"sub SP,#0x%02X\n",rb);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 0);
#endif
        return(0);
    }

    //SWI
    if((inst&0xFF00)==0xDF00)
    {
        rb=inst&0xFF;

        if((inst&0xFF)==0xCC)
        {
            op1 = 0; op2 = 0;
            write_register(0,cpsr);
            if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"swi 0x%02X\n",rb);
#ifdef MASKFLOW
            if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
            if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
            return(0);
        }
        else
        {
            fprintf(stderr,"\n\nswi 0x%02X\n",rb);
            return(1);
        }
    }

    //SXTB
    if((inst&0xFFC0)==0xB240)
    {
        rd=(inst>>0)&0x7;
        rm=(inst>>3)&0x7;
        ra=read_register(rm);
        rc=ra&0xFF;
        if(rc&0x80) rc|=(~0)<<8;
        
        op1 = 0; op2 = 0;
        write_register(rd,rc);

#ifdef MASKFLOW
        
        rc_maskflow = read_register_maskflow(rm);
        write_register_maskflow(rd, rc_maskflow);
        op1_maskflow = read_register_maskflow(rd); op2_maskflow = rc_maskflow;
        
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"sxtb r%u,r%u\n",rd,rm);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
        return(0);
    }

    //SXTH
    if((inst&0xFFC0)==0xB200)
    {
        rd=(inst>>0)&0x7;
        rm=(inst>>3)&0x7;
        
        ra=read_register(rm);
        rc=ra&0xFFFF;
        if(rc&0x8000) rc|=(~0)<<16;
        op1 = 0; op2 = 0;
        write_register(rd,rc);
        
#ifdef MASKFLOW
        
        rc_maskflow = read_register_maskflow(rm);
        write_register_maskflow(rd, rc_maskflow);
        op1_maskflow = read_register_maskflow(rd); op2_maskflow = rc_maskflow;
        
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"sxth r%u,r%u\n",rd,rm);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
        
        return(0);
    }

    //TST
    if((inst&0xFFC0)==0x4200)
    {
        rn=(inst>>0)&0x7;
        rm=(inst>>3)&0x7;
        
        ra=read_register(rn);
        rb=read_register(rm);
        rc=ra&rb;
        op1 = 0; op2 = 0;

        do_nflag(rc);
        do_zflag(rc);
        
#ifdef MASKFLOW
        
        ra_maskflow = read_register_maskflow(rn);
        rb_maskflow = read_register_maskflow(rm);
        op1_maskflow = ra_maskflow; op2_maskflow = rb_maskflow;
        
#endif

        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"tst r%u,r%u\n",rn,rm);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
        return(0);
    }

    //UXTB
    if((inst&0xFFC0)==0xB2C0)
    {
        rd=(inst>>0)&0x7;
        rm=(inst>>3)&0x7;
        ra=read_register(rm);
        rc=ra&0xFF;
        op1 = 0; op2 = 0;
        write_register(rd,rc);
        
#ifdef MASKFLOW
        
        rb_maskflow = read_register_maskflow(rm);
        write_register_maskflow(rd, rc_maskflow);
        op1_maskflow = read_register_maskflow(rd); op2_maskflow = rc_maskflow;
        
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"uxtb r%u,r%u\n",rd,rm);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
        return(0);
    }

    //UXTH
    if((inst&0xFFC0)==0xB280)
    {
        rd=(inst>>0)&0x7;
        rm=(inst>>3)&0x7;
        ra=read_register(rm);
        
        rc=ra&0xFFFF;
        op1 = 0; op2 = 0;
        write_register(rd,rc);
        
#ifdef MASKFLOW
        
        rb_maskflow = read_register_maskflow(rm);
        write_register_maskflow(rd, rc_maskflow);
        op1_maskflow = read_register_maskflow(rd); op2_maskflow = rc_maskflow;
        
#endif
        
        if(registerdataflow && ((t==1)||PRINTALLASMTRACES)) fprintf(asmoutput,"uxth r%u,r%u\n",rd,rm);
#ifdef MASKFLOW
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5, op1_maskflow, op2_maskflow);
#else
        if(registerdataflow) dataptr = update_dataflow(dataptr,op1,op2, 5);
#endif
        return(0);
    }

    fprintf(stderr,"invalid instruction 0x%08X 0x%04X\n",pc-4,inst);
    return(1);
}
//-------------------------------------------------------------------
int reset ( void )
{
    memset(ram,0xFF,sizeof(ram));

    systick_ctrl=0x00000004;
    systick_reload=0x00000000;
    systick_count=0x00000000;
    systick_calibrate=0x00ABCDEF;
    handler_mode=0;
    cpsr=0;

    reg_norm[13]=fetch32(0x00000000); //cortex-m
    reg_norm[14]=0xFFFFFFFF;
    reg_norm[15]=fetch32(0x00000004); //cortex-m
    if((reg_norm[15]&1)==0)
    {
        fprintf(stderr,"reset vector with an ARM address 0x%08X\n",reg_norm[15]);
        exit(1);
    }
    reg_norm[15]&=~1;
    reg_norm[15]+=2;

    instructions=0;
    fetches=0;
    reads=0;
    writes=0;

    return(0);
}

//-------------------------------------------------------------------

int run ( void )
{
    reset();
    while(1)
    {
        if(output_vcd)
        {
            fprintf(fpvcd,"#%u\n",vcdcount++);
        }
        if(execute()) break;
    }
    dump_counters();
    return(0);
}

//-------------------------------------------------------------------

void readcoeffs(double varaddress[][5], FILE *fp, int number){
    
    int i, j;
    char line[128];
    const char s[2] = " ";
    char *token;
    
    for (i=0;i<number;i++){
        
        fgets(line, sizeof line, fp);
        
        token = strtok(line, s);
        
        for(j=0; j<5; j++){
            
            sscanf(token, "%lf", &varaddress[i][j]);
            token = strtok(NULL, s);
            
        }
    }
}

//-------------------------------------------------------------------

int main ( int argc, char *argv[] )
{
    
    FILE *fp, *fpcoeffs;
    time_t timet;

    unsigned int ra, j, fvr_only;
    char line[128], str[500], filepath[500];
    const char s[2] = " ";
    char *token;
    
    t = 1; registerdataflow = 0; indexno = 1; maskflowfailno = 0, debug = 0, fvr_only = 0, tracestart = 1; runcount = 0, fixedvsrandomtest = 1;

    // Make directories with given permission settings. Default 0777.
    mkdir(OUTPUTFOLDER, 0777);
    mkdir(TRACEFOLDER, 0777);
    mkdir(NONPROFILEDFOLDER, 0777);
    mkdir(ASMOUTPUTFOLDER, 0777);

    randdata = fopen(RANDDATAFILE,"w");
    uartout = fopen(UARTOUTFILE,"w");
    datafile = fopen(DATAFILEPATH,"r");
    
    if(randdata == NULL)
        fprintf(stderr,"Warning: randdata filepointer NULL\n");
     
    if(uartout == NULL)
        fprintf(stderr,"Warning: uartout filepointer NULL\n");
    
    if(datafile == NULL)
        fprintf(stderr,"Warning: datafile filepointer NULL\n");

    srand((unsigned) time(&timet));
	start = malloc(sizeof(dataflow));
    initialise_dataflow(start);
    
#ifdef DIFFTRACELENGTH

    dataptr = malloc(sizeof(dataflow));

#else

    dataptr = create_dataflow(start);

#endif
    
    if(argc<2)
    {
        fprintf(stderr,"bin file not specified\n");
        return(1);
    }

    output_vcd=0;
    for(ra=0;ra<argc;ra++)
    {
        if(strcmp(argv[ra],"--vcd")==0) output_vcd=1;
        if(strcmp(argv[ra],"-fvr")==0){
            sscanf(argv[ra+1], "%d", &tracenumber);
            fixedvsrandom();
            dump_counters();
            return(0);
        }
        if(strcmp(argv[ra],"-nofvr")==0){
            fixedvsrandomtest = 0;
        }
        
        if(strcmp(argv[ra],"-starttrace")==0){
            sscanf(argv[ra+1], "%d", &t);
        }
        if(strcmp(argv[ra],"-runcount")==0){
            sscanf(argv[ra+1], "%d", &runcount);
        }
        if(strcmp(argv[ra],"-starttraceghost")==0){
            sscanf(argv[ra+1], "%d", &tracestart);
        }
    }
    fp=fopen(argv[1],"rb");
    if(fp==NULL)
    {
        fprintf(stderr,"Error opening file [%s]\n",argv[1]);
        return(1);
    }
    memset(rom,0xFF,sizeof(rom));
    ra=fread(rom,1,sizeof(rom),fp);
    fclose(fp);

    if(output_vcd)
    {
        fprintf(stderr,"output vcd enabled\n");
        fpvcd=fopen("output.vcd","wt");
        if(fpvcd==NULL)
        {
            fprintf(stderr,"Error creating file output.vcd\n");
            output_vcd=0;
            return(1);
        }

        fprintf(fpvcd,"$version Generated by thumbulator $end\n");
        fprintf(fpvcd,"$timescale 1ns $end\n");
        fprintf(fpvcd,"$scope module thumb $end\n");

        for(ra=0;ra<16;ra++)
        {
            fprintf(fpvcd,"$var wire 32 r%u r%u $end\n",ra,ra);
        }
        fprintf(fpvcd,"$var wire 16 inst inst $end\n");
        fprintf(fpvcd,"$upscope $end\n");
        fprintf(fpvcd,"$enddefinitions $end\n");
        vcdcount=0;
        fprintf(fpvcd,"#%u\n",vcdcount++);
        for(ra=0;ra<16;ra++)
        {
            fprintf(fpvcd,"b0 r%u\n",ra);
        }
        fprintf(fpvcd,"b0 inst\n");
    }
    
    
    // Compile coefficiants
    fpcoeffs = fopen(COEFFSFILE , "r");

    fgets(line, sizeof line, fp);
    token = strtok(line, s);
        
    for(j=0; j<5; j++){
        
        sscanf(token, "%lf", &constant[j]);
        token = strtok(NULL, s);
            
    }

    readcoeffs(PrvInstr,fpcoeffs, 4);
    readcoeffs(SubInstr,fpcoeffs, 4);
    readcoeffs(Operand1,fpcoeffs, 32);
    readcoeffs(Operand2,fpcoeffs, 32);
    readcoeffs(BitFlip1,fpcoeffs, 32);
    readcoeffs(BitFlip2,fpcoeffs, 32);
    readcoeffs(HWOp1PrvInstr,fpcoeffs, 4);
    readcoeffs(HWOp2PrvInstr,fpcoeffs, 4);
    readcoeffs(HDOp1PrvInstr,fpcoeffs, 4);
    readcoeffs(HDOp2PrvInstr,fpcoeffs, 4);
    readcoeffs(HWOp1SubInstr,fpcoeffs, 4);
    readcoeffs(HWOp2SubInstr,fpcoeffs, 4);
    readcoeffs(HDOp1SubInstr,fpcoeffs, 4);
    readcoeffs(HDOp2SubInstr,fpcoeffs, 4);
    readcoeffs(Operand1_bitinteractions,fpcoeffs, 496);
    readcoeffs(Operand2_bitinteractions,fpcoeffs, 496);
    readcoeffs(BitFlip1_bitinteractions,fpcoeffs, 496);
    readcoeffs(BitFlip2_bitinteractions,fpcoeffs, 496);
    
    memset(ram,0x00,sizeof(ram));
    
#ifdef MASKFLOW
    printf("########################################\n\nINITIALISING MASKFLOW...\n\n");
    reset_maskflow();
#endif

    printf("########################################\n\nGENERATING TRACES...\n\n");
    run();
    
    if(output_vcd)
    {
        fclose(fpvcd);
    }
    
    return(0);
}

////////////////////////////////////////////////////


//-------------------------------------------------------------------
//-------------------------------------------------------------------
//-------------------------------------------------------------------
