#include <string.h>
#include <stdio.h>
#include <iostream>

namespace stringhelper
{
    using namespace std;

    static string StringDelSym(std::string argSrc, char* pArgSym)
    {
        TStringList strLst;
        df_util::StringToStringList(argSrc, pArgSym, strLst);
        string strTmp;
        for(int idx=0; idx<(long)strLst.size(); idx++)
        {
            strTmp += strLst[idx];
        }
        return strTmp;
    }

    static string ToHexString(string argSrc)
    {
        int strLen = argSrc.size();
        string rstStr;
        rstStr.resize(strLen*2);
        unsigned char pHexBuf[] = {'0', '0'};
        for(int idx=0; idx<strLen; idx++)
        {
            unsigned char byteTmp = (unsigned char)argSrc[idx];
            sprintf(pHexBuf, "%x", byteTmp);
            if(pHexBuf[1] == 0)
            {
                pHexBuf[1] = pHexBuf[0];
                pHexBuf[0] = '0';
            }
            memcpy(&rstStr[idx*2], pHexBuf, 2);
        }
        return rstStr;
    }

    static string HexStringReverse(string argSrc)
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

    static string HexStringToStr(string argSrc)
    {
        int val;
        int strLen = argSrc.size()/2;
        string strRst;
        strRst.resize(strLen);
        for(int idx=0; idx<strLen; idx++)
        {
            istringstream(argSrc.substr(idx*2, 2)) >> std::hex >> val;
            strRst[idx] = val;
        }
        return strRst;
    }

    static string StringReverse(string argSrc)
    {
        reverse(argSrc.begin(), argSrc.end());
        return argSrc;
    }
}
