/*************************************************************************
	> File Name: baseTypeSize.cpp
	> Author: 
	> Mail: 
	> Created Time: 2016年10月12日 星期三 21时39分00秒
 ************************************************************************/

#include<iostream>
using namespace std;

#define COUTTYPESIZE(type) cout << "size of type :" << sizeof(type) << endl

void baseTypeSize()
{
    COUTTYPESIZE(char);
    COUTTYPESIZE(int);
    COUTTYPESIZE(short int);
    COUTTYPESIZE(long int);
    COUTTYPESIZE(float);
    COUTTYPESIZE(double);
    COUTTYPESIZE(wchar_t);
}

int main()
{
    baseTypeSize();
    return 0;
}
