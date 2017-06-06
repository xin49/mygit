/*************************************************************************
	> File Name: initarrorsprintf.cpp
 ************************************************************************/

#include <iostream>
#include <stdio.h>
#include <cstring>
using namespace std;

bool Compare(const char* pCh)
{
    char arrCh[10];
    sprintf(arrCh, "nihao");
    return memcmp(arrCh, pCh, sizeof(arrCh));
}

int main(int argc, char** argv)
{
    char arrChToCompare[10] = "nihao";
    bool b = Compare(arrChToCompare);
}
