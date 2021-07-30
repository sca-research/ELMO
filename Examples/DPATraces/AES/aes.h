/*******************************************************
* aes: functions for AES masked with AES               *
*                                                      *
* CopyRight : Qianmei 2021/3/6                         *
*******************************************************/
#ifndef AES_H
#define AES_H

#include "common.h"
 
void rawKeyExpansion(uint8* key, uint8* keys);
void AES_Encrypt_unprotected(uint8* dst, uint8* key, uint8* pt);

#endif
