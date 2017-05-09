/*************************************************************************
	> File Name: setpstring.cpp
 ************************************************************************/

#include <iostream>
using namespace std;
#include "setpstring.h"

void SetPString(std::string* pArgStr)
{
    std::cout << "SetPString In" << std::endl;
    std::cout << "PString adress:" << pArgStr << "PString size:" << sizeof(*pArgStr) << std::endl;
    *pArgStr = "Already Setting";
    std::cout << "PString adress:" << pArgStr << "PString size:" << sizeof(*pArgStr) << std::endl;
}
