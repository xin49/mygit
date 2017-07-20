/*************************************************************************
	> File Name: main.cpp
 ************************************************************************/

#include <iostream>
#include <stdio.h>
using namespace std;

int main()
{
    string str = "    ";
    int i[] = {-12345, -1234, -123, -1, 0, 5, 15, 234, 4321, 54321};
    for(int idx=0; idx<10; idx++)
    {
        sprintf(&str[0], "%4d", i[idx]);
        //keep data bit count and fill space in right/high bit
        cout << str << endl;
    }

    return 0;
}
