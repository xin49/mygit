/*************************************************************************
	> File Name: typepointcpy.cpp
 ************************************************************************/

#include<iostream>
#include <cstdlib>
#include <typeinfo>
using namespace std;

typedef struct _TTypeAllPointer{
    int* pInt;
    float* pFloat;
    double* pDouble;
}TTypeAllPointer;

template <int N>
struct TType{
};

int StringToTypebuf(string argStr, void* pArgBuf, int argTypId)
{
    switch(argTypId)
    {
        case ETypebufTypeInt32:{
            memcpy(pArgBuf, &StrTo<TTypebufTypeInt32>(argStr), sizeof(TTypebufTypeInt32));
            return 1;
        }
        case ETypebufTypeInt64:{
            memcpy(pArgBuf, &StrTo<TTypebufTypeInt64>(argStr), sizeof(TTypebufTypeInt64));
            return 1;
        }
        case ETypebufTypePtrInt:{
            return 0;
        }
        case ETypebufTypeFloat32:{
            memcpy(pArgBuf, &StrTo<TTypebufTypeFloat32>(argStr), sizeof(TTypebufTypeFloat32));
            return 1;
        }
        case ETypebufTypeFloat64:{
            memcpy(pArgBuf, &StrTo<TTypebufTypeFloat64>(argStr), sizeof(TTypebufTypeFloat64));
            return 1;
        }
        case ETypebufTypeBool:{
            memcpy(pArgBuf, &StrTo<TTypebufTypeBool>(argStr), sizeof(TTypebufTypeBool));
            return 1;
        }
        case ETypebufTypeBuffer:
        case ETypebufTypeNode:
        case ETypebufTypeStream:
        case ETypebufTypePString:
        default:{
            return 1;
        }
    }
}

string TypebufToString(void* pArgBuf, int argTypId)
{
    switch(argTypId)
    {
        case ETypebufTypeInt32:{
            PTypebufTypeInt32 pBuf = (PTypebufTypeInt32)pArgBuf;
            return ToStr(*pBuf);
        }
        case ETypebufTypeInt64:{
            PTypebufTypeInt64 pBuf = (PTypebufTypeInt64)pArgBuf;
            return ToStr(*pBuf);
        }
        case ETypebufTypePtrInt:{
            return "";
        }
        case ETypebufTypeFloat32:{
            PTypebufTypeFloat32 pBuf = (PTypebufTypeFloat32)pArgBuf;
            return ToStr(*pBuf);
        }
        case ETypebufTypeFloat64:{
            PTypebufTypeFloat64 pBuf = (PTypebufTypeFloat64)pArgBuf;
            return ToStr(*pBuf);
        }
        case ETypebufTypeBool:{
            PTypebufTypeBool pBuf = (PTypebufTypeBool)pArgBuf;
            return ToStr(*pBuf);
        }
        case ETypebufTypeBuffer:
        case ETypebufTypeNode:
        case ETypebufTypeStream:
        case ETypebufTypePString:
        default:{
            return "";
        }
    }
}

class TTypebufTypeHelper
{
public:
    PTypebufTypeInt32 pInt32;
}

void TypebufCopy(void* pArgBufSrc, int argTypSrc, void* pArgBufDst, int argTypDst)
{
    typeof (typeid(int)) a;
    switch(argTypSrc)
    {
        case 0:{
            static int* a = pArgBufSrc;
            break;
        }
        case 1:{
            static double* a = pArgBufSrc;
            break;
        }
        default:{
            break;
        }
    }

    switch(argTypDst)
    {
        case 0:{
            static int* b = pArgBufSrc;
            break;
        }
        case 1:{
            static double* b = pArgBufSrc;
            break;
        }
        default:{
            break;
        }
    }
}

//template <class Type> Type GetAdressType(void* argAdress, TTypeAllPointer argAllPointer)
//{
//    for(int idx=0; idx < 3; idx++)
//    {
//        if(argAdress == argAllPointer[])
//    }
//}

int main(void)
{
    int a = 6;
    float b = 7.8;
    double c = 12.6;
    int* pA = &a;
    float* pB = &b;
    double* pC = &c;
    void* pV = pC;
    *pC = *pB;
    *pB = *pA;
    cout << *pC << "," << c << endl;
    cout << *pB << "," << b << endl;
    cout << typeid(a).name() << "," << typeid(int).name() << endl;
    cout << typeid(pC).name() << endl;
    cout << typeid(pV).name() << endl;
    //cout << GetTypebufType(0) << endl;
    //TTypeAllPointer tmp;
    //tmp.pInt = (int*)malloc(20);
    //*tmp[0] = *pA;
    //cout << *(tmp->pInt) << endl;
    //free(tmp.pInt);
    return 0;
}
