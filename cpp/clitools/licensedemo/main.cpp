/*************************************************************************
	> File Name: main.cpp
 ************************************************************************/

#include <main.h>

#include <iostream>
#include <dfconsoleasn.h>

using namespace std;

string GetMacCode(string argMacAddr)
{
    string macCodeRst = DFGetMaskMacString(mac1);
    cout << argMacAddr << "    " << macCodeRst << endl;
    return macCodeRst;
}

string GetMacAdress(string argMacCode)
{
    string macAddrRst = DFGetMacAddress(argMacCode);
    cout << argMacCode << "    " << macAddrRst << endl;
    return macAddrRst;
}

string GetLicense(string argMacCode, string argValidDate)
{
    string lsn = CalcAsn(argMacCode, glbKey1, glbKey2, argValidDate, 232, 17, true, 0);
    cout << argMacCode << "    " << argValidDate << "    " << lsn << endl;
    return lsn;
}

string CheckLicense(string argMacAddr, string argLsn)
{
    string macCode = StringReverse(DFMaskMacString(StripOutSubString(argMacAddr, "-")));
    string validDate = "";
    CheckLicense(StripOutSubString(argLsn, "-"), macCode, validDate);
    GetMacCode(argMacAddr);
    cout << argLsn << "    " << validDate << end;
}
 

int GetCommandLine(string argCli)
{
    return 0;
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

        int cliIdx = GetCommandLine(argCli[1]);
        switch(cliIdx)
        {
            case ECmdUndefined: break;
            case ECmdBase: break;
            case ECmdGetMacCode:
            {
                GetMacCode(argCli[2]);
                break;
            }
            case ECmdGetMacAddress:
            {
                GetMacAdress(argCli[2]);
                break;
            }
            case ECmdGetLicense:
            {
                GetLicense(argCli[2], argCli[3]);
                break;
            }
            case ECmdCheckLicense:
            {
                CheckLicense(argCli[2], argCli[3]);
                break;
            }
            case ECmdEnd: break;
            default: break;
        }
        return 0;
    }
    return -1;
}
