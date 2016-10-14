/*************************************************************************
	> File Name: point.cpp
	> Created Time: 2016年10月14日 星期五 22时52分09秒
 ************************************************************************/

#include<iostream>
using namespace std;

int main()
{
    int var = 20;
    int* ip = &var;

    cout << ip << endl;
    //0x7ffff704612c in linux variable in low half page memory
    return 0;
}
