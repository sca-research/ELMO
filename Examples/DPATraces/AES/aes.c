#include "common.h"
//#include "DWT_clock.h"
//#include "comm.h"

// tables
uint8 tab_sbox[256] = {
	0x63, 0x7c, 0x77, 0x7b, 0xf2, 0x6b, 0x6f, 0xc5, 0x30, 0x01, 0x67, 0x2b, 0xfe, 0xd7, 0xab, 0x76,
	0xca, 0x82, 0xc9, 0x7d, 0xfa, 0x59, 0x47, 0xf0,	0xad, 0xd4, 0xa2, 0xaf, 0x9c, 0xa4, 0x72, 0xc0,
	0xb7, 0xfd, 0x93, 0x26, 0x36, 0x3f, 0xf7, 0xcc,	0x34, 0xa5, 0xe5, 0xf1, 0x71, 0xd8, 0x31, 0x15,
	0x04, 0xc7, 0x23, 0xc3, 0x18, 0x96, 0x05, 0x9a,	0x07, 0x12, 0x80, 0xe2, 0xeb, 0x27, 0xb2, 0x75,
	0x09, 0x83, 0x2c, 0x1a, 0x1b, 0x6e, 0x5a, 0xa0,	0x52, 0x3b, 0xd6, 0xb3, 0x29, 0xe3, 0x2f, 0x84,
	0x53, 0xd1, 0x00, 0xed, 0x20, 0xfc, 0xb1, 0x5b,	0x6a, 0xcb, 0xbe, 0x39, 0x4a, 0x4c, 0x58, 0xcf,
	0xd0, 0xef, 0xaa, 0xfb, 0x43, 0x4d, 0x33, 0x85,	0x45, 0xf9, 0x02, 0x7f, 0x50, 0x3c, 0x9f, 0xa8,
	0x51, 0xa3, 0x40, 0x8f, 0x92, 0x9d, 0x38, 0xf5,	0xbc, 0xb6, 0xda, 0x21, 0x10, 0xff, 0xf3, 0xd2,
	0xcd, 0x0c, 0x13, 0xec, 0x5f, 0x97, 0x44, 0x17,	0xc4, 0xa7, 0x7e, 0x3d, 0x64, 0x5d, 0x19, 0x73,
	0x60, 0x81, 0x4f, 0xdc, 0x22, 0x2a, 0x90, 0x88,	0x46, 0xee, 0xb8, 0x14, 0xde, 0x5e, 0x0b, 0xdb,
	0xe0, 0x32, 0x3a, 0x0a, 0x49, 0x06, 0x24, 0x5c,	0xc2, 0xd3, 0xac, 0x62, 0x91, 0x95, 0xe4, 0x79,
	0xe7, 0xc8, 0x37, 0x6d, 0x8d, 0xd5, 0x4e, 0xa9,	0x6c, 0x56, 0xf4, 0xea, 0x65, 0x7a, 0xae, 0x08,
	0xba, 0x78, 0x25, 0x2e, 0x1c, 0xa6, 0xb4, 0xc6,	0xe8, 0xdd, 0x74, 0x1f, 0x4b, 0xbd, 0x8b, 0x8a,
	0x70, 0x3e, 0xb5, 0x66, 0x48, 0x03, 0xf6, 0x0e,	0x61, 0x35, 0x57, 0xb9, 0x86, 0xc1, 0x1d, 0x9e,
	0xe1, 0xf8, 0x98, 0x11, 0x69, 0xd9, 0x8e, 0x94,	0x9b, 0x1e, 0x87, 0xe9, 0xce, 0x55, 0x28, 0xdf,
	0x8c, 0xa1, 0x89, 0x0d, 0xbf, 0xe6, 0x42, 0x68,	0x41, 0x99, 0x2d, 0x0f, 0xb0, 0x54, 0xbb, 0x16
};
uint8 Logtable[256] = {   
  0,   0,  25,   1,  50,   2,  26, 198,  75, 199,  27, 104,  51, 238, 223,   3,    
100,   4, 224,  14,  52, 141, 129, 239,  76, 113,   8, 200, 248, 105,  28, 193,    
125, 194,  29, 181, 249, 185,  39, 106,  77, 228, 166, 114, 154, 201,   9, 120,    
101,  47, 138,   5,  33,  15, 225,  36,  18, 240, 130,  69,  53, 147, 218, 142,    
150, 143, 219, 189,  54, 208, 206, 148,  19,  92, 210, 241,  64,  70, 131,  56,    
102, 221, 253,  48, 191,   6, 139,  98, 179,  37, 226, 152,  34, 136, 145,  16,    
126, 110,  72, 195, 163, 182,  30,  66,  58, 107,  40,  84, 250, 133,  61, 186,    
 43, 121,  10,  21, 155, 159,  94, 202,  78, 212, 172, 229, 243, 115, 167,  87,    
175,  88, 168,  80, 244, 234, 214, 116,  79, 174, 233, 213, 231, 230, 173, 232,    
 44, 215, 117, 122, 235,  22,  11, 245,  89, 203,  95, 176, 156, 169,  81, 160,    
127,  12, 246, 111,  23, 196,  73, 236, 216,  67,  31,  45, 164, 118, 123, 183,    
204, 187,  62,  90, 251,  96, 177, 134,  59,  82, 161, 108, 170,  85,  41, 157,    
151, 178, 135, 144,  97, 190, 220, 252, 188, 149, 207, 205,  55,  63,  91, 209,    
 83,  57, 132,  60,  65, 162, 109,  71,  20,  42, 158,  93,  86, 242, 211, 171,    
 68,  17, 146, 217,  35,  32,  46, 137, 180, 124, 184,  38, 119, 153, 227, 165,    
103,  74, 237, 222, 197,  49, 254,  24,  13,  99, 140, 128, 192, 247, 112,   7,    
};  
uint8 Alogtable[256] = {   
  1,   3,   5,  15,  17,  51,  85, 255,  26,  46, 114, 150, 161, 248,  19,  53,    
 95, 225,  56,  72, 216, 115, 149, 164, 247,   2,   6,  10,  30,  34, 102, 170,    
229,  52,  92, 228,  55,  89, 235,  38, 106, 190, 217, 112, 144, 171, 230,  49,    
 83, 245,   4,  12,  20,  60,  68, 204,  79, 209, 104, 184, 211, 110, 178, 205,    
 76, 212, 103, 169, 224,  59,  77, 215,  98, 166, 241,   8,  24,  40, 120, 136,    
131, 158, 185, 208, 107, 189, 220, 127, 129, 152, 179, 206,  73, 219, 118, 154,    
181, 196,  87, 249,  16,  48,  80, 240,  11,  29,  39, 105, 187, 214,  97, 163,    
254,  25,  43, 125, 135, 146, 173, 236,  47, 113, 147, 174, 233,  32,  96, 160,    
251,  22,  58,  78, 210, 109, 183, 194,  93, 231,  50,  86, 250,  21,  63,  65,    
195,  94, 226,  61,  71, 201,  64, 192,  91, 237,  44, 116, 156, 191, 218, 117,    
159, 186, 213, 100, 172, 239,  42, 126, 130, 157, 188, 223, 122, 142, 137, 128,    
155, 182, 193,  88, 232,  35, 101, 175, 234,  37, 111, 177, 200,  67, 197,  84,    
252,  31,  33,  99, 165, 244,   7,   9,  27,  45, 119, 153, 176, 203,  70, 202,    
 69, 207,  74, 222, 121, 139, 134, 145, 168, 227,  62,  66, 198,  81, 243,  14,    
 18,  54,  90, 238,  41, 123, 141, 140, 143, 138, 133, 148, 167, 242,  13,  23,    
 57,  75, 221, 124, 132, 151, 162, 253,  28,  36, 108, 180, 199,  82, 246,   1,    
}; 
// constants
uint8 Rcon[10][4] = {
	{ 0x01, 0x00, 0x00, 0x00 },
	{ 0x02, 0x00, 0x00, 0x00 },
	{ 0x04, 0x00, 0x00, 0x00 },
	{ 0x08, 0x00, 0x00, 0x00 },
	{ 0x10, 0x00, 0x00, 0x00 },
	{ 0x20, 0x00, 0x00, 0x00 },
	{ 0x40, 0x00, 0x00, 0x00 },
	{ 0x80, 0x00, 0x00, 0x00 },
	{ 0x1b, 0x00, 0x00, 0x00 },
	{ 0x36, 0x00, 0x00, 0x00 }
};
//uint8 keys[16 * 11] = {0};
// -------------------


/* Public Functions */
void rawKeyExpansion(uint8* key, uint8* keys);
void AES_Encrypt_unprotected(uint8* dst, uint8* key_aes, uint8* pt_aes);
// -------------------


/* Private Functions */
// AES
void AddRoundKey(uint8* src1, uint8* src2, uint8* res);
void Sbox(uint8* src, uint8* dst);
void ShiftRows(uint8* src, uint8* dst);
void MixColumn(uint8* src, uint8* dst);
// asm AES
extern void F_addRoundKey(uint8* src1, uint8* src2, uint8* res);
extern void F_sbox(uint8* src, uint8* dst);
extern void F_shiftRows(uint8* src, uint8* dst);
extern void F_mixColumn(uint8* src, uint8* dst);
// for keys generation
static void vecSetSub(uint8* src, uint8* dst, int start_index, int num);
static void vecExtraSub(uint8* src, uint8* dst, int start_index, int num);
static void Tbox(uint8* src, uint8* dst, int round);
// ------------------

void AES_Encrypt_unprotected(uint8* dst, uint8* key_aes, uint8* pt_aes)
{

	int i = 0;
	uint8 ptstate[16] = {0}; 
	uint8 ptstate2[16] = {0}; 
	
	// key Expansion
	//rawKeyExpansion(key_aes, keys);

	//ResetCYCCNT();
	
	AddRoundKey(pt_aes, key_aes, ptstate);

   for(i = 0;i < 9;i++)
   {
		Sbox(ptstate, ptstate2);
		ShiftRows(ptstate2, ptstate);
		MixColumn(ptstate, ptstate2);
		// prepare input key
		AddRoundKey(&(keys[16 * (i + 1)]), ptstate2, ptstate);
	}	
	Sbox(ptstate, ptstate2);
	ShiftRows(ptstate2, ptstate);
	AddRoundKey(&(keys[160]), ptstate, dst);
	
	//sys_val = ReadCYCCNT();
	
}


void rawKeyExpansion(uint8* key, uint8* keys)
{
	int i, j;
	uint8 temp1[4] = { 0 };
	uint8 temp2[4] = { 0 };

	// the 0th key
	for (i = 0; i < 16; i++) keys[i] = key[i];

	// the ith key
	for (i = 0; i < 10; i++)
	{
		// the 0th sub 
		vecExtraSub(&(keys[i * 16]), temp1, 12, 4);
		Tbox(temp1, temp2, i);
		vecExtraSub(&(keys[i * 16]), temp1, 0, 4);
		for (j = 0; j < 4; j++) temp2[j] ^= temp1[j];
		vecSetSub(temp2, &(keys[(i + 1) * 16]), 0, 4);
		// the 1th sub
		vecExtraSub(&(keys[i * 16]), temp1, 4, 4);
		for (j = 0; j < 4; j++) temp2[j] ^= temp1[j];
		vecSetSub(temp2, &(keys[(i + 1) * 16]), 4, 4);
		// the 2th sub
		vecExtraSub(&(keys[i * 16]), temp1, 8, 4);
		for (j = 0; j < 4; j++) temp2[j] ^= temp1[j];
		vecSetSub(temp2, &(keys[(i + 1) * 16]), 8, 4);
		// the 3th sub
		vecExtraSub(&(keys[i * 16]), temp1, 12, 4);
		for (j = 0; j < 4; j++) temp2[j] ^= temp1[j];
		vecSetSub(temp2, &(keys[(i + 1) * 16]), 12, 4);
	}

}

// for AES

void AddRoundKey(uint8* src1, uint8* src2, uint8* res)
{
	F_addRoundKey(src1, src2, res);
}

void Sbox(uint8* src, uint8* dst)
{
	F_sbox(src, dst);
}

void ShiftRows(uint8* src, uint8* dst)
{
	F_shiftRows(src, dst);
}

void MixColumn(uint8* src, uint8* dst)
{
	F_mixColumn(src, dst);
}

// for raw key expansion
void vecSetSub(uint8* src, uint8* dst, int start_index, int num)
{
	for (int i = 0; i < num; i++) dst[start_index + i] = src[i];
}

void vecExtraSub(uint8* src, uint8* dst, int start_index, int num)
{
	for (int i = 0; i < num; i++) dst[i] = src[i + start_index];
}

void Tbox(uint8* src, uint8* dst, int round)
{
	int i;
	// rotate to left 1 byte
	dst[0] = src[1];
	dst[1] = src[2];
	dst[2] = src[3];
	dst[3] = src[0];
	// subByte
	for (i = 0; i < 4; i++) dst[i] = tab_sbox[dst[i]];
	// xor Rcon
	for (i = 0; i < 4; i++) dst[i] = dst[i] ^ Rcon[round][i];

}





