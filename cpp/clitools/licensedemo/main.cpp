/*************************************************************************
	> File Name: main.cpp
 ************************************************************************/

#include <iostream>
#include <main.h>

using namespace std;

string GetMacCode(string argMacAddr)
{

}

string GetMacAdress(string argMacCode)
{

}

string GetLicense(string argMacCode, string argValidDate)
{

}

string CheckLicense(string argMacCode, string argLsn)
{

}
 
int main(int argCliCnt, char** argCli)
{
    if(argCliCnt >= 3)
    {
        for(int idx=0; idx<argCliCnt; idx++)
        {
            cout << argCli[idx] << "    ";
        }
        cout << endl;
        return 0;
    }
    return -1;
}
