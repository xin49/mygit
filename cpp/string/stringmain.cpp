/*************************************************************************
	> File Name: stringmain.cpp
 ************************************************************************/

#include <iostream>
#include <stringhelper.hpp>

using namespace std;

int main()
{
    string str = ToHexString("10");
    str = HexStringReverse(str);
    cout << str << endl;
    return 0;
}
