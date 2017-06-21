/*
 
 #############################################################################################
 # Default                       # Alternative                  # Define                     #
 #############################################################################################
 # ASCII traces                  # Binary traces                # BINARYTRACES               #
 # Instruction accurate traces   # Cycle accurate traces        # CYCLEACCURATE              #
 # ELMO power model              # Hamming weight model         # POWERMODEL_HW              #
 # Modelled differential voltage # Convert to power             # POWERTRACES                #
 # All traces are same length    # Traces of different length   # DIFFTRACELENGTH            #
 # Not mean centered             # Mean centred (need to        # MEANCENTRE                 #
 #                               # evaluate higher order masks) #                            #
 #############################################################################################
 
 To include fixed vs random, mask flow and energy modelling evaluations define FIXEDVSRANDOM, MASKFLOW and ENERGYMODEL respectively.

 */

unsigned int read32 ( unsigned int );
unsigned int read_register ( unsigned int );

#define DBUGFETCH   0
#define DBUGRAM     0
#define DBUGRAMW    0
#define DBUGREG     0
#define DISS        0
#define DBUG        0

//#define FIXEDVSRANDOM
#define MASKFLOW
//#define ENERGYMODEL

//#define DIFFTRACELENGTH
#define BINARYTRACES
#define MEANCENTRE
#define POWERTRACES
//#define POWERMODEL_HW

// Toggle between 1 (for on) or 0 (for off)
#define PRINTALLASMTRACES 0
#define PRINTALLNONPROFILEDTRACES 0
#define CYCLEACCURATE 1

#define FIXEDVSRANDOMFAIL 4.5
#define PRINTTRACENOINTERVAL 1

// Make sure power traces and cycle accurate model are used if using energy model
#ifdef ENERGYMODEL
#ifndef POWERTRACES
#define POWERTRACES
#endif
#ifndef CYCLEACCURATE
#define CYCLEACCURATE
#endif
#endif

// Make sure traces are mean centred if using mask flow
#ifdef MASKFLOW
#ifndef MEANCENTRE
#define MEANCENTRE
#endif
#endif

#define COEFFSFILE "coeffs.txt"

#define OUTPUTFOLDER "output"
#define TRACEFOLDER "output/traces/"
#define NONPROFILEDFOLDER "output/nonprofiledindexes/"
#define ASMOUTPUTFOLDER "output/asmoutput/"
#define TRACEFILE "trace%05d.trc"
#define NONPROFILEDFILE "indextrace%05d.txt"
#define ASMOUTPUTFILE "asmtrace%05d.txt"
#define MASKFLOWOUTPUTFILE "output/masks.txt"
#define FIXEDVSRANDOMFILE "output/fixedvsrandomfail.txt"
#define ENERGYTRACEFILE "output/energytrace.txt"
#define ASMOUTPUTFILE "asmtrace%05d.txt"

// Change to give path to data file if being used
#define DATAFILEPATH "Examples/randdata100000.txt"

#define RANDDATAFILE "output/randdata.txt"
#define UARTOUTFILE "output/uartout.txt"

#define RESISTANCE 360
#define SUPPLYVOLTAGE 3

//8 MHz
#define CLOCKCYCLETIME 0.000000125

#define ROMADDMASK 0xFFFFF
#define RAMADDMASK 0xFFFFF

#define ROMSIZE (ROMADDMASK+1)
#define RAMSIZE (RAMADDMASK+1)

unsigned short rom[ROMSIZE>>1];
unsigned short ram[RAMSIZE>>1];

#define CPSR_N (1<<31)
#define CPSR_Z (1<<30)
#define CPSR_C (1<<29)
#define CPSR_V (1<<28)
#define CPSR_Q (1<<27)

FILE *fpvcd, *randdata, *uartout, *indexesfile, *datafile, *asmoutput, *maskflow;

unsigned int vcdcount;
unsigned int output_vcd;

unsigned int systick_ctrl;
unsigned int systick_reload;
unsigned int systick_count;
unsigned int systick_calibrate;

unsigned int t;
unsigned int tracestart;

unsigned int runcount;

unsigned int no_masks;
unsigned int *maskfixedvsrandomfail;
unsigned int tracelength;
unsigned int registerdataflow;
unsigned int indexno;
unsigned int tracenumber;
unsigned int maskflowfailno;
unsigned int start_mask_dataflow;
unsigned int debug;
unsigned int fixedvsrandomtest;

unsigned int halfadd;
unsigned int cpsr;
unsigned int handler_mode;
unsigned int reg_norm[16]; //normal execution mode, do not have a thread model
unsigned long fetches;
unsigned long reads;
unsigned long writes;
unsigned long systick_ints;

double energy;

// Coeffiecients for power model
double constant[5], PrvInstr[4][5], SubInstr[4][5], Operand1[32][5], Operand2[32][5], BitFlip1[32][5], BitFlip2[32][5],  HWOp1PrvInstr[4][5], HWOp2PrvInstr[4][5], HDOp1PrvInstr[4][5], HDOp2PrvInstr[4][5], HWOp1SubInstr[4][5], HWOp2SubInstr[4][5], HDOp1SubInstr[4][5], HDOp2SubInstr[4][5], Operand1_bitinteractions[496][5], Operand2_bitinteractions[496][5], BitFlip1_bitinteractions[496][5], BitFlip2_bitinteractions[496][5];

struct bit32maskflow{
    
    uint8_t maskflow[128][32];
    unsigned int count;
    unsigned int fixedvsrandomfail;
    struct bit32maskflow *next;
    
};

typedef struct bit32maskflow bit32_maskflow;

struct bit16maskflow{
    
    uint8_t maskflow[128][16];
    unsigned int count;
    unsigned int fixedvsrandomfail;
    struct bit16maskflow *next;
    
};

typedef struct bit16maskflow bit16_maskflow;

struct data_flow {
    
    unsigned int op1;
    unsigned int op1_binary[32];
    unsigned int op1_bitflip[32];
    unsigned int op2;
    unsigned int op2_binary[32];
    unsigned int op2_bitflip[32];
    unsigned int instruction_type[6];
    unsigned int instruction_typedec;
    bit32_maskflow op1_maskflow;
    bit32_maskflow op2_maskflow;
    double power;
    struct data_flow *next;
    
};

typedef struct data_flow dataflow;

dataflow *dataptr, *current, *previous, *subsequent, *start;

bit32_maskflow *masktable;

bit16_maskflow ram_maskflow[RAMSIZE>>1];
bit32_maskflow reg_norm_maskflow[16];

void write16_maskflow ( unsigned int addr, bit32_maskflow data );
void write32_maskflow ( unsigned int addr, bit32_maskflow data );

