/*************************************************************************
	> File Name: 3desmain.cpp
 ************************************************************************/
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <openssl/des.h>
#include <openssl/rand.h>
//#include "df3deshelper.hpp"
 
/************************************************************************
 * 3DES-ECB加密方式
 * 8字节密钥，加密内容8位补齐，补齐方式为：PKCS7。
 *
 * file: test_des3_ecb.c
 * gcc -Wall -O2 -o test_des3_ecb test_des3_ecb.c hex.c -lcrypto
 *
 * author: tonglulin@gmail.com by www.qmailer.net
 ************************************************************************/


unsigned char *hex2bin(const char *data, int size, int *outlen)
{
    int i = 0;
    int len = 0;
    char char1 = '\0';
    char char2 = '\0';
    unsigned char value = 0;
    unsigned char *out = NULL;
 
    if (size % 2 != 0) {
        return NULL;
    }
 
    len = size / 2;
    out = (unsigned char *)malloc(len * sizeof(char) + 1);
    if (out == NULL) {
        return NULL;
    }
 
    while (i < len) {
        char1 = *data;
        if (char1 >= '0' && char1 <= '9') {
            value = (char1 - '0') << 4;
        }
        else if (char1 >= 'a' && char1 <= 'f') {
            value = (char1 - 'a' + 10) << 4;
        }
        else if (char1 >= 'A' && char1 <= 'F') {
            value = (char1 - 'A' + 10) << 4;
        }
        else {
            free(out);
            return NULL;
        }
        data++;
 
        char2 = *data;
        if (char2 >= '0' && char2 <= '9') {
            value |= char2 - '0';
        }
        else if (char2 >= 'a' && char2 <= 'f') {
            value |= char2 - 'a' + 10;
        }
        else if (char2 >= 'A' && char2 <= 'F') {
            value |= char2 - 'A' + 10;
        }
        else {
            free(out);
            return NULL;
        }
 
        data++;
        *(out + i++) = value;
    }
    *(out + i) = '\0';
 
    if (outlen != NULL) {
        *outlen = i;
    }
 
    return out;
}

void SelfTest1()
{
    //printf("Self Test\n");
    //unsigned char keyBase[] = {0x01,0x23,0x45,0x67,0x89,0xab,0xcd,0xef,0xfe,0xdc,0xba,0x98, 0x76,0x54,0x32,0x10,0x89,0xab,0xcd,0xef,0x01,0x23,0x45,0x67};
    //int keyLen = 24;
    //unsigned char src[] = {0x01,0x23,0x45,0x67,0x89,0xab,0xcd,0xe7};
    //unsigned char dst[8];
    //unsigned char decrypt[8];
    //unsigned char *pKey1, *pKey2, *pKey3;
    //DF3DesGetKey(keyBase, keyLen, pKey1, pKey2, pKey3);
    //int i;
    //printf("加密前数据: ");
    //for (i = 0; i < 8; i++) {
    //    printf("%02X", *(src + i));
    //}
    //printf("\n");
    //DF3DesEncrypt(pKey1, pKey2, pKey3, src, dst);
    //printf("加密后数据: ");
    //for (i = 0; i < 8; i++) {
    //    printf("%02X" , *(dst + i));
    //}
    //printf("\n");
    //DF3DesDecrypt(pKey1, pKey2, pKey3, dst, decrypt);
    //printf("解密后数据: ");
    //for (i = 0; i < 8; i++) {
    //    printf("%02X", *(decrypt + i));
    //}
    //printf("\n");
}

int main(int argc, char *argv[])
{
    SelfTest1();
    //using namespace std;
    //int extKey1 = 232;
    //int extKey2 = 17;
    //string lic = GetLicense("", extKey1, extKey2, false, 0);
//    SelfTest();
    int i = 0;
    int len = 0;
    int nlen = 0;
 
    char ch = '\0';
    char *key1 = "0000000000000000";  /* 原始密钥, 十六进制字符串 */
    char *key2 = "0000000000000000";  /* 原始密钥, 十六进制字符串 */
    char *key3 = "0000000000000000";  /* 原始密钥, 十六进制字符串 */
    char *data = "12345678123456781234567812345678";  /* 原始明文, 十六进制字符串 */
    unsigned char src[64] = {0};
    unsigned char out[64] = {0};
    unsigned char tmp[64] = {0};
 
    unsigned char *ptr  = NULL;
    unsigned char block[8] = {0};
    DES_key_schedule ks1, ks2, ks3;
 
    /* 设置密码表 */
    ptr = hex2bin(key1, strlen(key1), &nlen);
    memcpy(block, ptr, sizeof(block));
    free(ptr);
    DES_set_key_unchecked((C_Block *)block, &ks1);
 
    ptr = hex2bin(key2, strlen(key2), &nlen);
    memcpy(block, ptr, sizeof(block));
    free(ptr);
    DES_set_key_unchecked((C_Block *)block, &ks2);
 
    ptr = hex2bin(key3, strlen(key3), &nlen);
    memcpy(block, ptr, sizeof(block));
    free(ptr);
    DES_set_key_unchecked((C_Block *)block, &ks3);
 
    ptr = hex2bin(data, strlen(data), &nlen);
    memcpy(src, ptr, nlen);
    free(ptr);
 
    len = (nlen / 8 + (nlen % 8 ? 1: 0)) * 8;
 
    ch = 8 - nlen % 8;
    memset(src + nlen, ch, (8 - nlen % 8) % 8);

    int loopTimes=10;  
    while(loopTimes--)
    {
        //printf("加密前数据: ");
        //for (i = 0; i < len; i++) {
        //    printf("%02X", *(src + i));
        //}
        //printf("\n");
 
        for (i = 0; i < len; i += 8) {
            DES_ecb3_encrypt((C_Block *)(src + i), (C_Block *)(out + i), &ks1, &ks2, &ks3, DES_ENCRYPT);
        }
 
        printf("加密后数据: ");
        for (i = 0; i < len; i++) {
            printf("%02X" , *(out + i));
        }
        printf("\n");
 
        for (i = 0; i < len; i += 8) {
            DES_ecb3_encrypt((C_Block *)(out + i), (C_Block *)(tmp + i), &ks1, &ks2, &ks3, DES_DECRYPT);
        }
 
        //printf("解密后数据: ");
        //for (i = 0; i < len; i++) {
        //    printf("%02X", *(tmp + i));
        //}
        //printf("\n");
    }
	while(1)
	{}
    return 0;
}
