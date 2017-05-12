/*************************************************************************
	> File Name: macro.cpp
 ************************************************************************/

#include<iostream>
using namespace std;

#define TypeDefine_Int(typ) \
        typedef struct _TTest{\
            typ a;\
            typ b;\
            typ c;\
        }TTest;

TypeDefine_Int(int)

#define AddName(name) \
TTest a##name##b;

AddName(alala)

#define TypName(name) \
    struct T##name##Val;\
    T##name##Val* P##name##Val;

    

TypName(Int)


int main()
{
    cout << sizeof(TTest) << ";" <<sizeof(aalalab) << endl;
    return 0;
}
