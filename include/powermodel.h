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

int hweight(unsigned int n)
{
    unsigned int c; // the total bits set in n
    for (c = 0; n; n >>= 1)
    {
        c += n & 1;
    }
    return c;
}

//-------------------------------------------------------------------

int hdistance(unsigned int x, unsigned int y)
{
    int dist = 0;
    unsigned  val = x ^ y;
    
    // Count the number of bits set
    while (val != 0)
    {
        // A bit is set, so increment the count and clear the bit
        dist++;
        val &= val - 1;
    }
    
    // Return the number of differing bits
    return dist;
}

#ifdef POWERMODEL_HW

//-------------------------------------------------------------------

void hwpowermodel(){
    
    char str[500], filepath[500];
    FILE *fp, *fp_nonprofiled;
    double differentialvoltage, supplycurrent, power;
    
    int hw_op1, hw_op2, hd_op1, hd_op2, instructiontype, i, j, count, index = 1;
    double PrvInstr_data = 0, SubInstr_data = 0, Operand1_data = 0, Operand2_data = 0, BitFlip1_data = 0, BitFlip2_data = 0, HWOp1PrvInstr_data = 0, HWOp2PrvInstr_data = 0, HDOp1PrvInstr_data = 0, HDOp2PrvInstr_data = 0, HWOp1SubInstr_data = 0, HWOp2SubInstr_data = 0, HDOp1SubInstr_data = 0, HDOp2SubInstr_data = 0, Operand1_bitinteractions_data = 0, Operand2_bitinteractions_data = 0, BitFlip1_bitinteractions_data = 0, BitFlip2_bitinteractions_data = 0;
    
    previous = start;
    current = start->next;
    subsequent = start->next->next;
    
    strcpy(str, TRACEFOLDER);
    strcat(str, TRACEFILE);
    sprintf(filepath, str, t);
    fp = fopen(filepath, "w+");
    
    if(t==1 || PRINTALLNONPROFILEDTRACES){
        
        strcpy(str, NONPROFILEDFOLDER);
        strcat(str, NONPROFILEDFILE);
        sprintf(filepath, str, t);
        fp_nonprofiled = fopen(filepath, "w+");
        
    }

    while(subsequent->next != NULL){
        
        instructiontype = current->instruction_typedec;
        
        // Test for key guessing space
        // if(t == 1)
        //  keyflowfailtest(current);
        
        // Instruction was not profiled
        
        if(instructiontype == 5){
            
            dataptr->instruction_type[0] = 1;
            instructiontype = 0;
            
            if(t==1 || PRINTALLNONPROFILEDTRACES)
                fprintf(fp_nonprofiled,"%d\n",index);
        }
        
        else{
            hw_op1 = hweight(current->op1);
            hw_op2 = hweight(current->op2);
            
            hd_op1 = hdistance(previous->op1, current->op1);
            hd_op2 = hdistance(previous->op2, current->op2);
        }
        
        power = (double)hw_op2;
        
        if(instructiontype == 2 | instructiontype == 3){
            if(CYCLEACCURATE){
#ifdef BINARYTRACES
                fwrite(&power, sizeof(power), 1, fp);
                fwrite(&power, sizeof(power), 1, fp);
#else
                fprintf(fp,"%0.40f\n",power);
                fprintf(fp,"%0.40f\n",power);
#endif
                index += 2;
            }
            else{
#ifdef BINARYTRACES
                fwrite(&power, sizeof(power), 1, fp);
#else
                fprintf(fp,"%0.40f\n",power);
#endif
                index += 1;
            }
        }
        else{
#ifdef BINARYTRACES
            fwrite(&power, sizeof(power), 1, fp);
#else
            fprintf(fp,"%0.40f\n",power);
#endif
            index += 1;
        }
    
    previous = previous->next;
    current = current->next;
    subsequent = subsequent->next;
    
}

fclose(fp);

if(t==1 || PRINTALLNONPROFILEDTRACES) fclose(fp_nonprofiled);

}

#else

//-------------------------------------------------------------------

void elmopowermodel(){
    
    char str[500], filepath[500];
    FILE *fp, *fp_nonprofiled;
    double differentialvoltage, supplycurrent, power;
    
    int hw_op1, hw_op2, hd_op1, hd_op2, instructiontype, i, j, count, index = 1;
    double PrvInstr_data = 0, SubInstr_data = 0, Operand1_data = 0, Operand2_data = 0, BitFlip1_data = 0, BitFlip2_data = 0, HWOp1PrvInstr_data = 0, HWOp2PrvInstr_data = 0, HDOp1PrvInstr_data = 0, HDOp2PrvInstr_data = 0, HWOp1SubInstr_data = 0, HWOp2SubInstr_data = 0, HDOp1SubInstr_data = 0, HDOp2SubInstr_data = 0, Operand1_bitinteractions_data = 0, Operand2_bitinteractions_data = 0, BitFlip1_bitinteractions_data = 0, BitFlip2_bitinteractions_data = 0;
    #ifdef MEMORY_EXTENSION
    double Memory_data=0;
    #endif
    previous = start;
    current = start->next;
    subsequent = start->next->next;
    
    strcpy(str, TRACEFOLDER);
    strcat(str, TRACEFILE);
    sprintf(filepath, str, t);
    fp = fopen(filepath, "w+");
    
    if(t==1 || PRINTALLNONPROFILEDTRACES){
    
        strcpy(str, NONPROFILEDFOLDER);
        strcat(str, NONPROFILEDFILE);
        sprintf(filepath, str, t);
        fp_nonprofiled = fopen(filepath, "w+");
        
    }

    while(subsequent->next != NULL){
        
        PrvInstr_data = 0; SubInstr_data = 0; Operand1_data = 0; Operand2_data = 0; BitFlip1_data = 0; BitFlip2_data = 0; HWOp1PrvInstr_data = 0; HWOp2PrvInstr_data = 0; HDOp1PrvInstr_data = 0; HDOp2PrvInstr_data = 0; HWOp1SubInstr_data = 0; HWOp2SubInstr_data = 0; HDOp1SubInstr_data = 0; HDOp2SubInstr_data = 0; Operand1_bitinteractions_data = 0; Operand2_bitinteractions_data = 0; BitFlip1_bitinteractions_data = 0; BitFlip2_bitinteractions_data = 0;
        
        instructiontype = current->instruction_typedec;
        
        // Test for key guessing space
       // if(t == 1)
          //  keyflowfailtest(current);
        
        // Instruction was not profiled

        if(instructiontype == 5){

            dataptr->instruction_type[0] = 1;
            instructiontype = 0;

            if(t==1 || PRINTALLNONPROFILEDTRACES)
                fprintf(fp_nonprofiled,"%d\n",index);
        }

        else{
            hw_op1 = hweight(current->op1);
            hw_op2 = hweight(current->op2);

            hd_op1 = hdistance(previous->op1, current->op1);
            hd_op2 = hdistance(previous->op2, current->op2);

            for(i=0;i<32;i++){

                if(current->op1_binary[i] == previous->op1_binary[i])
                    current->op1_bitflip[i] = 0;
                else
                    current->op1_bitflip[i] = 1;
                
                if(current->op2_binary[i] == previous->op2_binary[i])
                    current->op2_bitflip[i] = 0;
                else
                    current->op2_bitflip[i] = 1;
            }
            
            // For each bit of two inputs
            
            for(i=0;i<32;i++){
                
                // Input hamming weights
                Operand1_data = Operand1_data + Operand1[i][instructiontype]*current->op1_binary[i];
                Operand2_data = Operand2_data + Operand2[i][instructiontype]*current->op2_binary[i];
                
                // Input hamming distance
                BitFlip1_data = BitFlip1_data + BitFlip1[i][instructiontype]*current->op1_bitflip[i];
                BitFlip2_data = BitFlip2_data + BitFlip2[i][instructiontype]*current->op2_bitflip[i];
                
            }
            
            // For each instruction type
            
            for(i=0;i<4;i++){
                
                // Previous and subsequent factors
                PrvInstr_data = PrvInstr_data + PrvInstr[i][instructiontype]*previous->instruction_type[i+1];
                SubInstr_data = SubInstr_data + SubInstr[i][instructiontype]*subsequent->instruction_type[i+1];
                
                // Hamming weight of previous
                HWOp1PrvInstr_data = HWOp1PrvInstr_data + HWOp1PrvInstr[i][instructiontype]*previous->instruction_type[i+1]*hw_op1;
                HWOp2PrvInstr_data = HWOp2PrvInstr_data + HWOp2PrvInstr[i][instructiontype]*previous->instruction_type[i+1]*hw_op2;
                
                // Hamming distance of previous
                HDOp1PrvInstr_data = HDOp1PrvInstr_data + HDOp1PrvInstr[i][instructiontype]*previous->instruction_type[i+1]*hd_op1;
                HDOp2PrvInstr_data = HDOp2PrvInstr_data + HDOp2PrvInstr[i][instructiontype]*previous->instruction_type[i+1]*hd_op2;
                
                // Hamming weight of subsequence
                HWOp1SubInstr_data = HWOp1SubInstr_data + HWOp1SubInstr[i][instructiontype]*subsequent->instruction_type[i+1]*hw_op1;
                HWOp2SubInstr_data = HWOp2SubInstr_data + HWOp2SubInstr[i][instructiontype]*subsequent->instruction_type[i+1]*hw_op2;
                
                // Hamming distance of subsequent
                HDOp1SubInstr_data = HDOp1SubInstr_data + HDOp1SubInstr[i][instructiontype]*subsequent->instruction_type[i+1]*hd_op1;
                HDOp2SubInstr_data = HDOp2SubInstr_data + HDOp2SubInstr[i][instructiontype]*subsequent->instruction_type[i+1]*hd_op2;
                
            }

            // Higher order bit interactions

            count = 0;
            
            for(i=0;i<32;i++){
                for(j=i+1;j<32;j++){

                    // Input hamming weights
                    Operand1_bitinteractions_data = Operand1_bitinteractions_data + Operand1_bitinteractions[count][instructiontype]*current->op1_binary[i]*current->op1_binary[j];
                    Operand2_bitinteractions_data = Operand2_bitinteractions_data + Operand2_bitinteractions[count][instructiontype]*current->op2_binary[i]*current->op2_binary[j];

                    // Input hamming distance
                    BitFlip1_bitinteractions_data = BitFlip1_bitinteractions_data + BitFlip1_bitinteractions[count][instructiontype]*current->op1_bitflip[i]*current->op1_bitflip[j];
                    BitFlip2_bitinteractions_data = BitFlip2_bitinteractions_data + BitFlip2_bitinteractions[count][instructiontype]*current->op2_bitflip[i]*current->op2_bitflip[j];

                    count++;

                }
            }
        }
	// Memory Extension:using the HD op1's coefficient
    #ifdef MEMORY_EXTENSION
    Memory_data=HDOp1PrvInstr[0][instructiontype]*hdistance(previous->readbus, current->readbus)+HDOp1PrvInstr[0][instructiontype]*hdistance(previous->writebus, current->writebus);

    #endif

        // Modelled differential voltage is total of different factors

        differentialvoltage = constant[instructiontype] + PrvInstr_data + SubInstr_data + Operand1_data + Operand2_data + BitFlip1_data + BitFlip2_data + HWOp1PrvInstr_data + HWOp2PrvInstr_data + HDOp1PrvInstr_data + HDOp2PrvInstr_data + HWOp1SubInstr_data + HWOp2SubInstr_data + HDOp1SubInstr_data + HDOp2SubInstr_data + Operand1_bitinteractions_data + Operand2_bitinteractions_data + BitFlip1_bitinteractions_data + BitFlip2_bitinteractions_data;

    #ifdef MEMORY_EXTENSION
    differentialvoltage=differentialvoltage+Memory_data;
    #endif
        // Convert from differential voltage to power

#ifdef POWERTRACES
        
        supplycurrent = differentialvoltage/RESISTANCE;
        power = supplycurrent*SUPPLYVOLTAGE;
        
#else
        
        power = differentialvoltage;

#endif
        
        if(instructiontype == 2 | instructiontype == 3){
            if(CYCLEACCURATE){
#ifdef BINARYTRACES
                fwrite(&power, sizeof(power), 1, fp);
                fwrite(&power, sizeof(power), 1, fp);
#else
                fprintf(fp,"%0.40f\n",power);
                fprintf(fp,"%0.40f\n",power);
#endif
                index += 2;
            }
            else{
#ifdef BINARYTRACES
                fwrite(&power, sizeof(power), 1, fp);
#else
                fprintf(fp,"%0.40f\n",power);
#endif
                index += 1;
            }
        }
        else{
#ifdef BINARYTRACES
            fwrite(&power, sizeof(power), 1, fp);
#else
            fprintf(fp,"%0.40f\n",power);
#endif
            index += 1;
        }

        previous = previous->next;
        current = current->next;
        subsequent = subsequent->next;
        
}
    
    fclose(fp);
    
    if(t==1 || PRINTALLNONPROFILEDTRACES) fclose(fp_nonprofiled);
        
}

#endif

//-------------------------------------------------------------------

void freedataflow(){
    
    previous = start;
    subsequent = previous->next;
    
    while((previous = subsequent) != NULL){
        
        subsequent = subsequent->next;
        free (previous);
        
    }
    
}
