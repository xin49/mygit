/*************************************************************************
	> File Name: variableScope.cpp
	> Author: 
	> Mail: 
	> Created Time: 2016年10月12日 星期三 22时05分51秒
 ************************************************************************/

#include<iostream>
using namespace std;

void Func1(double formalVal);

int globalVal1 = 1;

int main ()
{
    int localVal = 1;

    Func1(3.145);
}

int globalVal2 = 2;

void Func1(double formalVal)
{

    {
        int lLocalVal = 100;
        cout << lLocalVal << endl;
    }
    //cout << lLocalVal << endl; error
}
