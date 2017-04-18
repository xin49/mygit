#include <string.h>
#include <stdio.h>
#include <iostream>

    using namespace std;

    string ToHexString(string argSrc)
    {
        int strLen = argSrc.size();
        string rstStr;
        rstStr.resize(strLen*2);
        unsigned char pHexBuf[2];
        for(int idx=0; idx<strLen; idx++)
        {
            unsigned char byteTmp = (unsigned char)argSrc[idx];
            sprintf(pHexBuf, "%x", byteTmp);
            memcpy(&rstStr[idx*2], pHexBuf, 2);
        }
        return rstStr;
    }

    string HexStringReverse(string argSrc)
    {
        int srcLen = argSrc.size();
        if(srcLen%2 == 0)
        {
            string rstStr;
            rstStr.resize(srcLen);
            int symCnt = srcLen / 2; 
            int maxIdx = symCnt - 1;
            for(int idx=0; idx<symCnt; idx++)
            {
                rstStr[2*idx] = argSrc[2*(maxIdx-idx)];
                rstStr[2*idx+1] = argSrc[2*(maxIdx-idx)+1];
            }
            return rstStr;
        }
        return "";
    }
