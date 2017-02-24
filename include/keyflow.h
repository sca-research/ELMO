//-------------------------------------------------------------------

bit32_keyflow *initialisekeyflow32(void){
    
    bit32_keyflow *bit32;
    bit32 = malloc(sizeof(bit32_keyflow));
    memset(bit32->keyflow, 0x00, sizeof(((bit32_keyflow *)0)->keyflow));
    bit32->next = NULL;
    bit32->count = 0;
    
    return bit32;
    
}

//-------------------------------------------------------------------


bit32_keyflow zero_keyflow32(void){

    bit32_keyflow bit32;
    memset(&bit32, 0x00, sizeof(bit32_keyflow));

    return bit32;
    
}

//-------------------------------------------------------------------

bit16_keyflow zero_keyflow16(void){

    bit16_keyflow bit16;
    memset(&bit16, 0x00, sizeof(bit16_keyflow));

    return bit16;
}

//-------------------------------------------------------------------

unsigned int getmask(bit32_keyflow *bit32){

    int index = 0;
    bit32_keyflow *current_mask;
    current_mask = masktable;
    
    while(current_mask->next != NULL){
        
        if((memcmp(bit32->keyflow, current_mask->keyflow, sizeof(((bit32_keyflow *)0)->keyflow))) == 0){

            current_mask->count++;

//            print32(*bit32);
//            print32(*current_mask);

            return index;
            
        }

        index++;
        current_mask = current_mask->next;
    
    }

    memcpy(current_mask->keyflow, bit32->keyflow, sizeof(((bit32_keyflow *)0)->keyflow));
    current_mask->count++;
    current_mask->next = initialisekeyflow32();

    return index;
}

//-------------------------------------------------------------------

void generatemaskdata(void){

    no_masks = 0;
    bit32_keyflow *current_mask, *next_mask;
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
    bit32_keyflow *current_mask, *next_mask;
    current_mask = masktable;
    current_mask = current_mask->next; // skip mask 0
    
    for(i=0;i<maskno;i++)
        current_mask = current_mask->next;
    
    return(current_mask->count);
    
}


//-------------------------------------------------------------------

void printmask(unsigned int mask){
    
    int i;
    bit32_keyflow *current_mask;
    current_mask = masktable;
    current_mask = current_mask->next; // skip mask 0

    for(i=0;i<mask;i++)
        current_mask = current_mask->next;
    print32(*current_mask);
    
}

//-------------------------------------------------------------------

void keyflowfailtest(void){
    
    FILE *fp_keyflow;
    int order, mask, op1mask, op2mask;
    char *answer;
    answer = malloc(sizeof(char));
    
    current = start->next;
    
    // Initialise the mask table
    masktable = initialisekeyflow32();
    masktable->next = initialisekeyflow32();
    
    fp_keyflow = fopen(KEYFLOWOUTPUTFILE, "w+");
    
    while(current->next != NULL){
        
        op1mask = getmask(&current->op1_keyflow);
        op2mask = getmask(&current->op2_keyflow);
        
        if(current->instruction_typedec == 2 | current->instruction_typedec == 3){
            if(CYCLEACCURATE){
                fprintf(fp_keyflow,"%d %d\n", op1mask, op2mask);
                fprintf(fp_keyflow,"%d %d\n", op1mask, op2mask);
            }
            else{
                fprintf(fp_keyflow,"%d %d\n", op1mask, op2mask);
            }
        }
        else{
            fprintf(fp_keyflow,"%d %d\n", op1mask, op2mask);
            //printf("%d %d\n", getmask(&current->op1_keyflow), getmask(&current->op2_keyflow));
        }
        //print32(current->op1_keyflow);
        current = current->next;
        
    }
    generatemaskdata();

    fclose(fp_keyflow);
}

//-------------------------------------------------------------------

bit32_keyflow rotatematrixleft(bit32_keyflow bit32_in, unsigned int rotateno){
    
    int i, j;
    bit32_keyflow bit32 = zero_keyflow32();
    
    for(i=0;i<128;i++){
        for(j=0;j<32;j++){
            bit32.keyflow[i][(j+rotateno)%32] = bit32_in.keyflow[i][j];
        }
    }

    return bit32;
}

//-------------------------------------------------------------------

bit32_keyflow bit16merge(bit16_keyflow bit16_1, bit16_keyflow bit16_2){
    
    int i, j;
    bit32_keyflow bit32 = zero_keyflow32();
    
    for(i=0;i<128;i++){
        for(j=0;j<16;j++){
            bit32.keyflow[i][j] = bit16_1.keyflow[i][j];
            bit32.keyflow[i][j+16] = bit16_2.keyflow[i][j];
        }
    }

    return bit32;
}

//-------------------------------------------------------------------

bit16_keyflow bit32tobit16(bit32_keyflow bit32, unsigned int highbits){
    
    int i, j;
    bit16_keyflow bit16 = zero_keyflow16();

    for(i=0;i<128;i++)
        for(j=0;j<16;j++){
            if(highbits)
                bit16.keyflow[i][j] = bit32.keyflow[i][j+16];
            else
                bit16.keyflow[i][j] = bit32.keyflow[i][j];
        }

    return bit16;
}

//-------------------------------------------------------------------

bit32_keyflow bit8tobit16(bit32_keyflow bit8, unsigned int highbits){
    bit32_keyflow bit16 = zero_keyflow32();
    int i, j, k;

    for(i=0;i<128;i++){
        for(j=0;j<8;j++){
            if(highbits)
                bit16.keyflow[i][j] = bit8.keyflow[i][j+8];
            else
                bit16.keyflow[i][j] = bit8.keyflow[i][j];

            //bit16.keyflow[i][j+16] = 0;
        }
    }

    return bit16;
}

//-------------------------------------------------------------------

void initialise_secret_keyflow(unsigned int addr){
    
    int i, j, k;
    
    bit32_keyflow bit32;
    
    for(k=0;k<4;k++){
        bit32 = zero_keyflow32();
        for(i=(k*32);i<((k*32)+32);i++)
            for(j=0;j<32;j++)
                if((i%32)==j)
                    bit32.keyflow[i][j] = 1;
        write32_keyflow((addr+(k*4)), bit32);
    }

    return;
}
//-------------------------------------------------------------------

void reset_keyflow(void){
    int i;
    memset(ram_keyflow, 0x00, sizeof(ram_keyflow));
    //for(i=0;i<(RAMSIZE>>1);i++)
    //  ram_keyflow[i] = zero_keyflow16();
    
    memset(reg_norm_keyflow, 0x00, sizeof(reg_norm_keyflow));
    
    return;
}

//-------------------------------------------------------------------

void write16_keyflow ( unsigned int addr, bit32_keyflow data )
{
    
    // Case RAM
    addr&=RAMADDMASK;
    addr>>=1;
    ram_keyflow[addr] = bit32tobit16(data,false);
    
}

//-------------------------------------------------------------------

void write32_keyflow ( unsigned int addr, bit32_keyflow data )
{
    if((addr&0xF0000000) != 0xE0000000){
        // Case RAM
        write16_keyflow(addr+0, bit16merge(bit32tobit16(data,false),zero_keyflow16()));
        write16_keyflow(addr+2, bit16merge(bit32tobit16(data,true), zero_keyflow16()));
        //print32(bit16merge(zero_keyflow16(),bit32tobit16(data,true)));
        //printf("%x",addr);
        //print32(read32_keyflow(addr));
    }

    return;
}

//-------------------------------------------------------------------

bit32_keyflow read16_keyflow ( unsigned int addr )
{
    bit32_keyflow keyflow;
    
    addr&=RAMADDMASK;
    addr>>=1;
    keyflow=bit16merge(ram_keyflow[addr], zero_keyflow16());
    
    return(keyflow);
}

//-------------------------------------------------------------------

bit32_keyflow read32_keyflow ( unsigned int addr )
{
    bit32_keyflow keyflow = zero_keyflow32();
    bit16_keyflow keyflow16_1, keyflow16_2;
    
    if((addr&0xF0000000) != 0xE0000000){
    
        // Case RAM
        keyflow16_1 = bit32tobit16(read16_keyflow(addr+0),false);
        keyflow16_2 = bit32tobit16(read16_keyflow(addr+2),false);
        keyflow = bit16merge(keyflow16_1, keyflow16_2);
    }
    
    return(keyflow);
}

//-------------------------------------------------------------------

bit32_keyflow read_register_keyflow ( unsigned int reg )
{
    bit32_keyflow data;
    reg&=0xF;
    data=reg_norm_keyflow[reg];
    
    return(data);
}

//-------------------------------------------------------------------

void write_register_keyflow ( unsigned int reg, bit32_keyflow data )
{
    reg&=0xF;
    reg_norm_keyflow[reg] = data;
    
}

//-------------------------------------------------------------------

bit32_keyflow compute_keyflow(bit32_keyflow op1, bit32_keyflow op2, int immediate, int function ){

    int i,j,k, temp;

    bit32_keyflow output;

    switch(function){


        case(0): // Multiply
            return(zero_keyflow32());
            break;

        case(1): // exclusive-or
            
            for(i=0;i<128;i++)
                for(j=0;j<32;j++)
                    output.keyflow[i][j] = op1.keyflow[i][j] ^ op2.keyflow[i][j];
            
            //  if(registerdataflow)
            //    print32(op2);
            
            break;
            
        case(2): // Shift left
            
            for(i=0;i<128;i++)
                for(j=0;j<32;j++)
                    output.keyflow[i][j] = op1.keyflow[i][j] | op2.keyflow[i][j];
            
            for(i=0;i<128;i++)
                for(j=0;j<32;j++){
                    if((j-immediate)>=0)
                        output.keyflow[i][j] = op1.keyflow[i][(j-immediate)];
                    else
                        output.keyflow[i][j] = 0;
                    }
            //return(zero_keyflow32());
            break;

        case(3): // Shift right
            
            for(i=0;i<128;i++)
                for(j=0;j<32;j++)
                    output.keyflow[i][j] = op1.keyflow[i][j] | op2.keyflow[i][j];
            
            for(i=0;i<128;i++)
                for(j=0;j<32;j++){
                    if((j+immediate)<32)
                        output.keyflow[i][j] = op1.keyflow[i][(j+immediate)];
                    else
                        output.keyflow[i][j] = 0;
                }
            //return(zero_keyflow32());
            break;

        case(4): // Rotate right
            
            for(i=0;i<128;i++)
                for(j=0;j<32;j++)
                    output.keyflow[i][j] = op1.keyflow[i][j] | op2.keyflow[i][j];
            
            for(i=0;i<128;i++)
                for(j=0;j<32;j++){
                    output.keyflow[i][j] = op1.keyflow[i][(j+immediate)%32];
                }
            //return(zero_keyflow32());
            break;
    }
    
    return output;
}

//-------------------------------------------------------------------

void set_mask_dataflow(unsigned int addr, unsigned int start){
    
    int i, j, k;
    
    bit32_keyflow bit32;
    bit32 = read16_keyflow(addr);

    if(addr&1)
    {
        for(i=start;i<start+8;i++)
            bit32.keyflow[i][i-start+8] = 1;
    }
    else
    {
        for(i=start;i<start+8;i++)
            bit32.keyflow[i][i-start] = 1;
    }
   // print32(bit32);

    write16_keyflow(addr, bit32);
    
    return;
}

//-------------------------------------------------------------------
