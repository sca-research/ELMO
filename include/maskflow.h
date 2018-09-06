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
bit32_maskflow ra_maskflow,rb_maskflow,rc_maskflow,op1_maskflow,op2_maskflow;
bit32_maskflow *initialisemaskflow32(void){
    
    bit32_maskflow *bit32;
    bit32 = malloc(sizeof(bit32_maskflow));
    memset(bit32->maskflow, 0x00, sizeof(((bit32_maskflow *)0)->maskflow));
    bit32->next = NULL;
    bit32->count = 0;
    
    return bit32;
    
}

//-------------------------------------------------------------------


bit32_maskflow zero_maskflow32(void){

    bit32_maskflow bit32;
    memset(&bit32, 0x00, sizeof(bit32_maskflow));

    return bit32;
    
}

//-------------------------------------------------------------------

bit16_maskflow zero_maskflow16(void){

    bit16_maskflow bit16;
    memset(&bit16, 0x00, sizeof(bit16_maskflow));

    return bit16;
}

//-------------------------------------------------------------------

unsigned int getmask(bit32_maskflow *bit32){

    int index = 0;
    bit32_maskflow *current_mask;
    current_mask = masktable;
    
    while(current_mask->next != NULL){
        
        if((memcmp(bit32->maskflow, current_mask->maskflow, sizeof(((bit32_maskflow *)0)->maskflow))) == 0){

            current_mask->count++;

//            print32(*bit32);
//            print32(*current_mask);

            return index;
            
        }

        index++;
        current_mask = current_mask->next;
    
    }

    memcpy(current_mask->maskflow, bit32->maskflow, sizeof(((bit32_maskflow *)0)->maskflow));
    current_mask->count++;
    current_mask->next = initialisemaskflow32();

    return index;
}

//-------------------------------------------------------------------

void generatemaskdata(void){

    no_masks = 0;
    bit32_maskflow *current_mask, *next_mask;
    current_mask = masktable;
    current_mask = current_mask->next; // skip mask 0

   /* printf("DISPLAYING MASK INFROMATION...\n");

    while(current_mask->next != NULL){
        printf("MASK %d: %d\n", no_masks, current_mask->count);
        print32(*current_mask);
        no_masks++;
        current_mask = current_mask->next;
    }
    
    printf("\n%d MASKS DETECTED...\n\n", no_masks);*/
    
}

//-------------------------------------------------------------------

int getmasktracelen(int maskno){
    int i;
    bit32_maskflow *current_mask, *next_mask;
    current_mask = masktable;
    current_mask = current_mask->next; // skip mask 0
    
    for(i=0;i<maskno;i++)
        current_mask = current_mask->next;
    
    return(current_mask->count);
    
}


//-------------------------------------------------------------------

void printmask(unsigned int mask){
    
    int i;
    bit32_maskflow *current_mask;
    current_mask = masktable;
    current_mask = current_mask->next; // skip mask 0

    for(i=0;i<mask;i++)
        current_mask = current_mask->next;
    //print32(*current_mask);
    
}

//-------------------------------------------------------------------

void maskflowfailtest(void){
    
    FILE *fp_maskflow;
    int order, mask, op1mask, op2mask;
    char *answer;
    answer = malloc(sizeof(char));
    
    current = start->next;
    
    // Initialise the mask table
    masktable = initialisemaskflow32();
    masktable->next = initialisemaskflow32();
    
    fp_maskflow = fopen(MASKFLOWOUTPUTFILE, "w+");
    
    while(current->next != NULL){
        
        op1mask = getmask(&current->op1_maskflow);
        op2mask = getmask(&current->op2_maskflow);
        
        if(current->instruction_typedec == 2 | current->instruction_typedec == 3){
            if(CYCLEACCURATE){
                fprintf(fp_maskflow,"%d %d\n", op1mask, op2mask);
                fprintf(fp_maskflow,"%d %d\n", op1mask, op2mask);
            }
            else{
                fprintf(fp_maskflow,"%d %d\n", op1mask, op2mask);
            }
        }
        else{
            fprintf(fp_maskflow,"%d %d\n", op1mask, op2mask);
            //printf("%d %d\n", getmask(&current->op1_maskflow), getmask(&current->op2_maskflow));
        }
        //print32(current->op1_maskflow);
        current = current->next;
        
    }
    generatemaskdata();

    fclose(fp_maskflow);
}

//-------------------------------------------------------------------

bit32_maskflow rotatematrixleft(bit32_maskflow bit32_in, unsigned int rotateno){
    
    int i, j;
    bit32_maskflow bit32 = zero_maskflow32();
    
    for(i=0;i<128;i++){
        for(j=0;j<32;j++){
            bit32.maskflow[i][(j+rotateno)%32] = bit32_in.maskflow[i][j];
        }
    }

    return bit32;
}

//-------------------------------------------------------------------

bit32_maskflow bit16merge(bit16_maskflow bit16_1, bit16_maskflow bit16_2){
    
    int i, j;
    bit32_maskflow bit32 = zero_maskflow32();
    
    for(i=0;i<128;i++){
        for(j=0;j<16;j++){
            bit32.maskflow[i][j] = bit16_1.maskflow[i][j];
            bit32.maskflow[i][j+16] = bit16_2.maskflow[i][j];
        }
    }

    return bit32;
}

//-------------------------------------------------------------------

bit16_maskflow bit32tobit16(bit32_maskflow bit32, unsigned int highbits){
    
    int i, j;
    bit16_maskflow bit16 = zero_maskflow16();

    for(i=0;i<128;i++)
        for(j=0;j<16;j++){
            if(highbits)
                bit16.maskflow[i][j] = bit32.maskflow[i][j+16];
            else
                bit16.maskflow[i][j] = bit32.maskflow[i][j];
        }

    return bit16;
}

//-------------------------------------------------------------------

bit32_maskflow bit8tobit16(bit32_maskflow bit8, unsigned int highbits){
    bit32_maskflow bit16 = zero_maskflow32();
    int i, j, k;

    for(i=0;i<128;i++){
        for(j=0;j<8;j++){
            if(highbits)
                bit16.maskflow[i][j] = bit8.maskflow[i][j+8];
            else
                bit16.maskflow[i][j] = bit8.maskflow[i][j];

            //bit16.maskflow[i][j+16] = 0;
        }
    }

    return bit16;
}

//-------------------------------------------------------------------

void initialise_secret_maskflow(unsigned int addr){
    
    int i, j, k;
    
    bit32_maskflow bit32;
    
    for(k=0;k<4;k++){
        bit32 = zero_maskflow32();
        for(i=(k*32);i<((k*32)+32);i++)
            for(j=0;j<32;j++)
                if((i%32)==j)
                    bit32.maskflow[i][j] = 1;
        write32_maskflow((addr+(k*4)), bit32);
    }

    return;
}
//-------------------------------------------------------------------

void reset_maskflow(void){
    int i;
    memset(ram_maskflow, 0x00, sizeof(ram_maskflow));
    //for(i=0;i<(RAMSIZE>>1);i++)
    //  ram_maskflow[i] = zero_maskflow16();
    
    memset(reg_norm_maskflow, 0x00, sizeof(reg_norm_maskflow));
    
    return;
}

//-------------------------------------------------------------------

void write16_maskflow ( unsigned int addr, bit32_maskflow data )
{
    
    // Case RAM
    addr&=RAMADDMASK;
    addr>>=1;
    ram_maskflow[addr] = bit32tobit16(data,false);
    
}

//-------------------------------------------------------------------

void write32_maskflow ( unsigned int addr, bit32_maskflow data )
{
    if((addr&0xF0000000) != 0xE0000000){
        // Case RAM
        write16_maskflow(addr+0, bit16merge(bit32tobit16(data,false),zero_maskflow16()));
        write16_maskflow(addr+2, bit16merge(bit32tobit16(data,true), zero_maskflow16()));
        //print32(bit16merge(zero_maskflow16(),bit32tobit16(data,true)));
        //printf("%x",addr);
        //print32(read32_maskflow(addr));
    }

    return;
}

//-------------------------------------------------------------------

bit32_maskflow read16_maskflow ( unsigned int addr )
{
    bit32_maskflow maskflow;
    
    addr&=RAMADDMASK;
    addr>>=1;
    maskflow=bit16merge(ram_maskflow[addr], zero_maskflow16());
    
    return(maskflow);
}

//-------------------------------------------------------------------

bit32_maskflow read32_maskflow ( unsigned int addr )
{
    bit32_maskflow maskflow = zero_maskflow32();
    bit16_maskflow maskflow16_1, maskflow16_2;
    
    if((addr&0xF0000000) != 0xE0000000){
    
        // Case RAM
        maskflow16_1 = bit32tobit16(read16_maskflow(addr+0),false);
        maskflow16_2 = bit32tobit16(read16_maskflow(addr+2),false);
        maskflow = bit16merge(maskflow16_1, maskflow16_2);
    }
    
    return(maskflow);
}

//-------------------------------------------------------------------

bit32_maskflow read_register_maskflow ( unsigned int reg )
{
    bit32_maskflow data;
    reg&=0xF;
    data=reg_norm_maskflow[reg];
    
    return(data);
}

//-------------------------------------------------------------------

void write_register_maskflow ( unsigned int reg, bit32_maskflow data )
{
    reg&=0xF;
    reg_norm_maskflow[reg] = data;
    
}

//-------------------------------------------------------------------

bit32_maskflow compute_maskflow(bit32_maskflow op1, bit32_maskflow op2, int immediate, int function ){

    int i,j,k, temp;

    bit32_maskflow output;

    switch(function){


        case(0): // Multiply
            return(zero_maskflow32());
            break;

        case(1): // exclusive-or
            
            for(i=0;i<128;i++)
                for(j=0;j<32;j++)
                    output.maskflow[i][j] = op1.maskflow[i][j] ^ op2.maskflow[i][j];
            
            //  if(registerdataflow)
            //    print32(op2);
            
            break;
            
        case(2): // Shift left
            
            for(i=0;i<128;i++)
                for(j=0;j<32;j++)
                    output.maskflow[i][j] = op1.maskflow[i][j] | op2.maskflow[i][j];
            
            for(i=0;i<128;i++)
                for(j=0;j<32;j++){
                    if((j-immediate)>=0)
                        output.maskflow[i][j] = op1.maskflow[i][(j-immediate)];
                    else
                        output.maskflow[i][j] = 0;
                    }
            //return(zero_maskflow32());
            break;

        case(3): // Shift right
            
            for(i=0;i<128;i++)
                for(j=0;j<32;j++)
                    output.maskflow[i][j] = op1.maskflow[i][j] | op2.maskflow[i][j];
            
            for(i=0;i<128;i++)
                for(j=0;j<32;j++){
                    if((j+immediate)<32)
                        output.maskflow[i][j] = op1.maskflow[i][(j+immediate)];
                    else
                        output.maskflow[i][j] = 0;
                }
            //return(zero_maskflow32());
            break;

        case(4): // Rotate right
            
            for(i=0;i<128;i++)
                for(j=0;j<32;j++)
                    output.maskflow[i][j] = op1.maskflow[i][j] | op2.maskflow[i][j];
            
            for(i=0;i<128;i++)
                for(j=0;j<32;j++){
                    output.maskflow[i][j] = op1.maskflow[i][(j+immediate)%32];
                }
            //return(zero_maskflow32());
            break;
    }
    
    return output;
}

//-------------------------------------------------------------------

void set_mask_dataflow(unsigned int addr, unsigned int start){
    
    int i, j, k;
    
    bit32_maskflow bit32;
    bit32 = read16_maskflow(addr);

    if(addr&1)
    {
        for(i=start;i<start+8;i++)
            bit32.maskflow[i][i-start+8] = 1;
    }
    else
    {
        for(i=start;i<start+8;i++)
            bit32.maskflow[i][i-start] = 1;
    }
   // print32(bit32);

    write16_maskflow(addr, bit32);
    
    return;
}

//-------------------------------------------------------------------
