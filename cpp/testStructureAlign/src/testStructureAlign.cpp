/*************************************************************************
	> File Name: testStructureAlign.cpp
	> Author: 
	> Mail: 
	> Created Time: 2016年08月12日 星期五 10时58分07秒
 ************************************************************************/
//test result: the align type abay wiki Data structure alignment
#include<iostream>
#include<stdio.h>

#define OFFSET(st, field)     (size_t)&(((st*)0)->field)

typedef struct _TTest1
{
    int test1;
}TTest1;

#pragma pack(push)
#pragma pack(8)
typedef struct _TBase
{
    double x;
    double y;
} TBase;
#pragma pack(pop)

typedef struct _DF_TVCommonSetCoorSysInputParam
{
    int  Coordisystype;
    TBase  CoordiOrigin;
    double       Coordi_Xaxisangle;
    double       realworldunitwidth;
    double       realworldunitheight;
    double       pixelunitwidth;
    double       pixelunitheight;
} __attribute__((aligned(8))) DF_TVCommonSetCoorSysInputParam;

typedef struct _TStruct1
{
    char k;//1
    char k1;//1
    int x;//4
    TBase y;//16
    double z;//8
    char j;//1
}TStruct1;

int main(void)
{
    int val1 = sizeof(TStruct1);
    printf("size TStruct1 = %d, k = %d, x = %d, y = %d, z = %d\n",
          val1, 
          OFFSET(TStruct1, k), 
          OFFSET(TStruct1, x), 
          OFFSET(TStruct1, y), 
          OFFSET(TStruct1, z) 
          );

    val1 = sizeof(DF_TVCommonSetCoorSysInputParam);
    printf("size DF_TVCommonSetCoorSysInputParam = %d, p1=%d,p2=%d,p3=%d,p4=%d,p5=%d\n", 
           val1,
          OFFSET(DF_TVCommonSetCoorSysInputParam, Coordisystype),
          OFFSET(DF_TVCommonSetCoorSysInputParam, CoordiOrigin),
          OFFSET(DF_TVCommonSetCoorSysInputParam, Coordi_Xaxisangle),
          OFFSET(DF_TVCommonSetCoorSysInputParam, realworldunitwidth),
          OFFSET(DF_TVCommonSetCoorSysInputParam, realworldunitheight)
          );
    return 1;
}
