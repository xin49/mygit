#include <iostream>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include <openssl/des.h>
#include <openssl/rand.h>

#include <df_util.hpp>
#include <df_util_sys.hpp>
#include <inihelper.h>
#include <stringhelper.hpp>
/************************************************************************
 * 3DES-ECB
 * key length 8 
 ************************************************************************/
using namespace stringhelper;

typedef const_DES_cblock C_Block;

#ifdef WIN32
const char MacAddressDivSym[] = "-";
#else
const char MacAddressDivSym[] = ":";
#endif

static unsigned char DF_LICENSE_KEY[] = "122211DF";

static unsigned char MacNumTest[] = "080027E7017D0001";

static unsigned char pKeyBase[3][24] = {
    {118,68,143,31,117,245,55,125,
	251,176,233,108,98,243,39,160,
	185,153,207,243,154,85,246,145},

    {213,34,101,105,106,161,57,175,
	194,189,199,253,246,224,157,96,
	220,121,185,114,133,9,227,71},

    {37,206,31,131,179,135,141,159,
	208,139,139,152,252,20,33,188,
	13,161,240,19,147,55,223,147}
};

static unsigned char pMask[3] = {
    'D', 'M', 'V'
};

static unsigned char DFCPTOAC[512] = {
    '2','E','J','D','7','3','3','F','3','N','2','Q','Q','4','3','8','X','N','4','S',
    '9','R','6','9','Z','T','7','6','4','3','W','V','5','8','S','F','L','2','F','7',
    '5','T','8','B','9','9','P','5','Z','5','7','Y','6','W','7','7','9','5','7','4',
    '3','J','6','6','Q','C','2','A','4','L','W','3','7','A','4','Z','J','3','V','8',
    'W','C','6','8','R','2','2','F','8','K','N','Q','9','M','M','P','7','L','8','7',
    'L','G','L','3','T','A','T','6','E','4','K','V','8','9','3','3','9','A','4','8',
    'S','Y','K','2','5','K','E','5','M','6','7','R','G','S','X','5','5','6','5','E',
    '8','D','2','P','H','6','8','8','8','F','3','9','U','T','3','5','L','J','2','3',
    'Z','N','G','T','8','A','8','Z','K','7','6','N','3','L','2','B','L','E','8','6',
    'X','P','8','5','9','W','U','9','4','7','Z','Y','V','K','3','U','8','3','6','H',
    '6','7','J','8','D','J','H','M','K','S','H','4','J','4','J','6','6','5','W','Z',
    '7','E','T','9','9','J','7','N','6','C','C','5','M','2','8','P','M','X','Q','M',
    '9','6','N','2','3','H','Y','P','6','3','H','Z','5','5','7','W','A','7','6','L',
    '5','Y','9','N','V','3','8','J','N','D','N','Z','4','E','4','9','N','9','T','L',
    '6','4','M','5','4','J','Z','K','7','8','9','P','5','F','7','Z','V','7','R','C',
    'V','H','M','4','S','J','5','9','6','J','J','Y','L','V','T','2','2','D','5','S',
    'Y','A','8','C','Y','4','H','C','6','D','2','W','M','8','R','9','N','P','Q','A',
    'K','6','6','2','V','4','9','4','5','Q','Q','9','W','8','V','E','X','D','D','8',
    '9','Z','5','A','R','K','9','F','N','J','U','C','T','R','M','N','T','4','A','6',
    'N','8','B','S','T','H','8','L','K','M','4','H','K','8','3','X','J','G','K','L',
    'T','Z','M','L','N','E','3','E','9','K','S','5','L','R','U','R','4','A','X','V',
    '7','5','J','H','C','3','L','Z','9','2','3','S','Q','7','9','Q','9','8','G','3',
    'Q','P','S','E','4','M','P','D','Y','9','K','B','L','P','6','S','Q','V','2','M',
    'L','Y','7','C','H','A','Z','L','2','K','X','M','Q','Z','V','9','K','9','D','3',
    '6','Q','U','Y','L','K','G','A','K','4','M','K','P','X','Y','8','5','2','L','D',
    '2','6','3','A','T','3','B','J','D','7','U','2'
};

static int evaluateIncCode1 = 41;
static int evaluateIncCode2 = 117;
static int evaluateTurbCode = 45;    
const int DF3DesEncrypt_Flag = 0;
const int DF3DesDecrypt_Flag = 1;

const int asnapiRetVal_SuccessBase			= 0xAB98172D;
const int asnapiRetVal_OutOfDate 				= asnapiRetVal_SuccessBase - 8; //过期UKey
const int asnapiRetVal_LicensingFailed	= asnapiRetVal_SuccessBase - 7;
const int asnapiRetVal_Illegal					= asnapiRetVal_SuccessBase - 6;
const int asnapiRetVal_UkeyNotFound			= asnapiRetVal_SuccessBase - 5;
const int asnapiRetVal_UkeyReadError		= asnapiRetVal_SuccessBase - 4;
const int asnapiRetVal_UkeyReadOk				= asnapiRetVal_SuccessBase - 3;
const int asnapiRetVal_DfsnWriteFailed	= asnapiRetVal_SuccessBase - 2;
const int asnapiRetVal_DfsnWriteOk			= asnapiRetVal_SuccessBase - 1;
  //-------------
const int asnapiRetVal_PartialLegal			= asnapiRetVal_SuccessBase + 1;
const int asnapiRetVal_FullLegal				= asnapiRetVal_SuccessBase + 2;
const int asnapiRetVal_PartialEval			= asnapiRetVal_SuccessBase + 3;
const int asnapiRetVal_FullEval					= asnapiRetVal_SuccessBase + 4;

const int PLUGIN_ASN_SETTING_STRING_LENGTH = 128;
const int MAX_TYPE_ID = PLUGIN_ASN_SETTING_STRING_LENGTH*4-1;
const int ASNAPIARG_MAX_INFO = 1024;

typedef struct _DF_AsnApiArg
{
    char* lsn;//注册码
    int ilsn;//注册码长度
    int numOfAsnPlg;//被授权的模块个数
    /*和dfasn不一样*/char vilidDate[512];//授权有效期
   	int pAsnPlgTpidSeq[MAX_TYPE_ID];//被授权的模块typeid序列, 暂时1024种模块(1024种typeid)
    char pInfo[ASNAPIARG_MAX_INFO];//info
    int numInfo;
    char arrInfo[10][ASNAPIARG_MAX_INFO];
    char* pMachNum;
    int retVal;//功能号, 0注册, 1授权检查(注册码+ukey)
    int k1;
    int k2;
    int code1;
    int code2;
    bool useTurb;
    int turbCode;
}TDF_AsnApiArg;

typedef TDF_AsnApiArg* PDF_AsnApiArg;

void DF3DesEncrypt(unsigned char* pArgKey1, unsigned char* pArgKey2, unsigned char* pArgKey3, unsigned char* pBufSrc, unsigned char* pBufDst)
{
    DES_key_schedule ks1, ks2, ks3;
    DES_set_key_unchecked((C_Block *)pArgKey1, &ks1);
    DES_set_key_unchecked((C_Block *)pArgKey2, &ks2);
    DES_set_key_unchecked((C_Block *)pArgKey3, &ks3);
    DES_ecb3_encrypt((C_Block *)(pBufSrc), (C_Block *)(pBufDst), &ks1, &ks2, &ks3, DES_ENCRYPT);
}

void DF3DesDecrypt(unsigned char* pArgKey1, unsigned char* pArgKey2, unsigned char* pArgKey3, unsigned char* pBufSrc, unsigned char* pBufDst)
{
    DES_key_schedule ks1, ks2, ks3;
    DES_set_key_unchecked((C_Block *)pArgKey1, &ks1);
    DES_set_key_unchecked((C_Block *)pArgKey2, &ks2);
    DES_set_key_unchecked((C_Block *)pArgKey3, &ks3);
    DES_ecb3_encrypt((C_Block *)(pBufSrc), (C_Block *)(pBufDst), &ks1, &ks2, &ks3, DES_DECRYPT);
}

void DF3DesCalc(unsigned char* pArgKey1, unsigned char* pArgKey2, unsigned char* pArgKey3, unsigned char* pBufSrc, unsigned char* pBufEncrypt, int argFlag=DF3DesEncrypt_Flag)
{
    if(argFlag == DF3DesEncrypt_Flag)
        DF3DesEncrypt(pArgKey1, pArgKey2, pArgKey3, pBufSrc, pBufEncrypt);
    else
        DF3DesDecrypt(pArgKey1, pArgKey2, pArgKey3, pBufEncrypt, pBufSrc);
}

void DF3DesGetKey(unsigned char* pArgKeyBase, int argKeyLen, std::string& argKey1, std::string& argKey2, std::string& argKey3)
{
    int segLen = 8;
    int keyBaseLen = 3*segLen;
    std::string strKeyBase;
    strKeyBase.resize(keyBaseLen);
    memset(&strKeyBase[0], 0, keyBaseLen);
    if(argKeyLen < keyBaseLen)
    {
        memcpy(&strKeyBase[0], pArgKeyBase, argKeyLen);
        memcpy(&strKeyBase[2*segLen], &strKeyBase[0], segLen);
    }
    else
    {
        memcpy(&strKeyBase[0], pArgKeyBase, keyBaseLen);
    }
    argKey1 = strKeyBase.substr(0*segLen, segLen);
    argKey2 = strKeyBase.substr(1*segLen, segLen);
    argKey3 = strKeyBase.substr(2*segLen, segLen);
}

void MaskKeyBase(unsigned char* pArgMask, int argMaskLen, unsigned char* pArgKeyBase, int argKeyLen)
{
    unsigned char* pKeyBaseTmp = (unsigned char*)malloc(argKeyLen);
    memcpy(pKeyBaseTmp, pArgKeyBase, argKeyLen);
    int idxTmp;
    //for(int idx=0; idx<argMaskLen; idx++)
    //{
    //    idxTmp = ((idx+1)*argKeyLen) / argMaskLen - 1;
    //    pArgKeyBase[idxTmp] = pKeyBaseTmp[idxTmp]^pArgMask[idx];
    //}
    free(pKeyBaseTmp);
}

using namespace std;

TStringList& GetMacAddress(TStringList& lstOut)
{
	using namespace std;
	using namespace df_util_sys;
	using namespace df_util;

    lstOut.clear();
    string str;
    #ifdef WIN32
	CmdExec("wmic nic where netconnectionid!=NULL get macaddress", lstOut);
    lstOut.Print();
    if(lstOut.Count() > 1)
    {
        lstOut.delete(0);
    }
    lstOut.Print();
    #else
	CmdExec("ifconfig -a | grep -i \"HWaddr\"", lstOut);
    for(int idx=0; idx<lstOut.Count(); idx++)
    {
		str = LowerCase(lstOut[idx].c_str());
		str = str.substr(Pos("hwaddr ", str.c_str())+strlen("hwaddr "), str.length());
		lstOut[idx] = str.substr(0, Pos(" ", str.c_str()));
    }
    #endif
    return lstOut;
}

string GetMachineNumStr()
{
    TStringList strLst;
    GetMacAddress(strLst);
    string str;
    if(strLst.Count()>0)
    {
        str = strLst[0];
        str = StringDelSym(str, MacAddressDivSym);
    }
    return str;
}

std::string DFMaskMacString(std::string argSrc)
{
    unsigned char maskArr[] = {27,167,234,73,15,142,125,250};
    std::string maskStr = string((char*)maskArr);
    std::string strRst;
    strRst.resize(8);
    strRst[0] = maskStr[0] ^ HexStringToStr(argSrc.substr(10, 2))[0];
    strRst[1] = maskStr[1] ^ HexStringToStr(argSrc.substr(0, 2))[0];
    strRst[2] = maskStr[2] ^ HexStringToStr(argSrc.substr(2, 2))[0];
    strRst[3] = maskStr[3] ^ HexStringToStr(argSrc.substr(8, 2))[0];
    strRst[4] = maskStr[4] ^ HexStringToStr(argSrc.substr(4, 2))[0];
    strRst[5] = maskStr[5] ^ HexStringToStr(argSrc.substr(6, 2))[0];
    strRst[6] = maskStr[6] ^ HexStringToStr(argSrc.substr(8, 2))[0];
    strRst[7] = maskStr[7] ^ HexStringToStr(argSrc.substr(10, 2))[0];
    return strRst;
}

std::string DFGetMaskMacString()
{
    return ToHexString(DFMaskMacString(GetMachineNumStr().substr(0, 16)));
}

void DF3DesCalcBuffer(unsigned char* pArgSrcBuf, int argBufLen, int argSegLen, unsigned char* pArgKeyBase, int argKeyBaseLen, unsigned char* pArgMask, int argMaskLen, unsigned char* pArgDstBuf, int argFlag)
{
    if(argSegLen > 8)
        return;
    int segNum = argBufLen / argSegLen;
    int realKeyBaseLen = argSegLen * 3;//3des encrypt
    if(realKeyBaseLen > argKeyBaseLen)
        return;
    unsigned char* pSrcBufTmp;
    unsigned char* pDstBufTmp;
    std::string key1, key2, key3;
    for(int idx=0; idx<segNum; idx++)
    {
        pSrcBufTmp = &pArgSrcBuf[idx*argSegLen];
        pDstBufTmp = &pArgDstBuf[idx*argSegLen];
        MaskKeyBase(pArgMask, argMaskLen, pArgKeyBase, realKeyBaseLen);
        DF3DesGetKey(pArgKeyBase, realKeyBaseLen, key1, key2, key3); 
        DF3DesCalc((unsigned char*)&key1[0], (unsigned char*)&key2[0], (unsigned char*)&key3[0], pSrcBufTmp, pDstBufTmp, argFlag);
    }
    int segEnd = argBufLen % argSegLen;
    realKeyBaseLen = segEnd * 3;
    if(segEnd > 0)
    {
        pSrcBufTmp = &pArgSrcBuf[segNum*argSegLen];
        pDstBufTmp = &pArgDstBuf[segNum*argSegLen];
        MaskKeyBase(pArgMask, argMaskLen, pArgKeyBase, realKeyBaseLen);
        DF3DesGetKey(pArgKeyBase, realKeyBaseLen, key1, key2, key3); 
        DF3DesCalc((unsigned char*)&key1[0], (unsigned char*)&key2[0], (unsigned char*)&key3[0], pSrcBufTmp, pDstBufTmp, argFlag);
    }
}

void DF3DesCalcString(string& argSrc, int argSegLen, string argKeyBase, string argMask, string& argDst, int argFlag=DF3DesEncrypt_Flag)
{
    DF3DesCalcBuffer((unsigned char*)argSrc.c_str(), argSrc.size(), argSegLen, (unsigned char*)argKeyBase.c_str(), argKeyBase.size(), (unsigned char*)argMask.c_str(), argMask.size(), (unsigned char*)argDst.c_str(), argFlag);
}

string CmtCpToAc(string argSrc)
{ 
    int strLen = argSrc.size();
    string str = "";
    string strTmp;
    strTmp.resize(2);
    for(int idx=0; idx<strLen; idx++)
    {
        strTmp[0] = DFCPTOAC[(unsigned char)argSrc[idx]*2];
        strTmp[1] = DFCPTOAC[(unsigned char)argSrc[idx]*2+1];
        str += strTmp;
    }
    string ac = str;
    return ac;
}

string CmtAcToCp(string argSrc)
{ 
    using namespace df_util;
    int strLen = argSrc.size()/2;
    string str, cp;
    cp.resize(argSrc.size());
    memset(&cp[0], 0, argSrc.size());
    for(int idx=0; idx<strLen; idx++)
    {
        str = ToStr(argSrc[idx*2]) + ToStr(argSrc[idx*2+1]);
        for(int j=0; j<256; j++)
        {
            string strTmp = ToStr(DFCPTOAC[j*2]) + ToStr(DFCPTOAC[j*2+1]);
            if(strTmp == str)
            {
                cp[idx] = j;
                break;
            }
        }
    }
    return cp;
}


std::string IniHelperReadStdString(const char* pArgFileName, const char* pArgSect, const char* pArgKey, const char* pArgDefVal)
{
    void* hIni = IniHelperCreate(pArgFileName);
    std::string str = IniHelperReadPChar(hIni, pArgSect, pArgKey, pArgDefVal);
    IniHelperDestroy(&hIni);
    return str;
}

string GetLicense(string argMacNumStr, int argExtKey1, int argExtKey2, 
                bool argIsUseTurbCode, unsigned char argTurbCode)
{
    if(argMacNumStr == "")
        return("");
    string keyBaseStr = string((char*)&pKeyBase[0]);
    string maskStr = string((char*)pMask);
    int srcBufLen = 8;
    string macNum = StringReverse(HexStringToStr(argMacNumStr));
    string dstStr;
    dstStr.resize(srcBufLen+2);
    dstStr[srcBufLen] = argExtKey1;
    dstStr[srcBufLen+1] = argExtKey2;
    DF3DesCalcString(macNum, 8, keyBaseStr, maskStr, dstStr);
    dstStr[srcBufLen] ^= macNum[7];
    dstStr[srcBufLen+1] ^= macNum[7];
    if(argIsUseTurbCode == true)
    {
        for(int idx=0; idx<10; idx++)
            dstStr[idx] ^= argTurbCode;
    }
    string result = CmtCpToAc(dstStr);
    return result;
}

string CalcAsn(string argMacNumStr, unsigned char argExtKey1, unsigned char argExtKey2,
                string argDate, unsigned char argCode1, unsigned char argCode2,
                bool argIsUseTurbCode, unsigned char argTurbCode)
{
    if(argMacNumStr == "")
        return("");
    string keyBaseStr = string((char*)&pKeyBase[0]);
    string maskStr = string((char*)pMask);
    int srcBufLen = 8;
    argDate = StringDelSym(argDate, '-');
    argDate = string((char*)DF_LICENSE_KEY) + argDate;
    string vilidData = StringReverse(HexStringToStr(argDate));
    string macNum = StringReverse(HexStringToStr(argMacNumStr));
    string license;
    license.resize(macNum.size());
    for(int idx=0; idx<macNum.size(); idx++)
        license[idx] = macNum[idx] ^ vilidData[idx];
    string dstStr;
    dstStr.resize(srcBufLen+2);
    dstStr[srcBufLen] = argExtKey1;
    dstStr[srcBufLen+1] = argExtKey2;
    bool isWrongPsw;
    if((dstStr[srcBufLen] != argCode1) || (dstStr[srcBufLen+1] != argCode2))
    {
        isWrongPsw = true; 
    }
    DF3DesCalcString(license, 8, keyBaseStr, maskStr, dstStr);
    if(isWrongPsw == true)
    {
        for(int idx=0; idx<10; idx++)
        {
            dstStr[idx] = (unsigned char)rand();
        }
    }
    dstStr[srcBufLen] ^= argMacNumStr[7];
    dstStr[srcBufLen+1] ^= argMacNumStr[7];
    if(argIsUseTurbCode = true)
    {
        for(int idx=0; idx<10; idx++)
            dstStr[idx] ^= argTurbCode;
    }
    dstStr[srcBufLen] ^= macNum[7];
    dstStr[srcBufLen+1] ^= macNum[7];
    dstStr = CmtCpToAc(dstStr);
    string result = dstStr.substr(0, 5) + string("-") + dstStr.substr(5, 5) + string("-") +
                    dstStr.substr(10, 5) + string("-") + dstStr.substr(15, 5);
    return(result);
}

int CheckUKey(void* pArgAsnPrm, std::string argLsn, int arg1, int arg2)//vritual
{
    return asnapiRetVal_Illegal; 
}

std::string GetDFDab(std::string pArgFileName)
{
    std::string str = IniHelperReadStdString(pArgFileName.c_str(), "DFLICENSE", "DFLICENSECODE", "");
    return str;
}

bool InTime(std::string argTime)
{
#include <time.h>    
    using namespace df_util;
    time_t now;
    now = time(0);
    tm valTime;
    TStringList strLst;
    StringToStringList(argTime, "-", strLst);
    if(strLst.Count() == 3)
    {
        valTime.tm_year = StrToInt32(strLst[0]);
        valTime.tm_mon = StrToInt32(strLst[1]);
        valTime.tm_mday = StrToInt32(strLst[2]);
        if(difftime(now, mktime(&valTime)) < 0)
            return true;
    }       
    return false;
}

int CheckLicense(std::string argLsn)
{
    using namespace std;
    if(argLsn == "")
        return asnapiRetVal_Illegal;
    string keyBaseStr = string((char*)&pKeyBase[0]);
    string maskStr = string((char*)pMask);
    string strEncrypted = CmtAcToCp(argLsn);
    string strDecrypted;
    strDecrypted.resize(argLsn.size());
    DF3DesCalcString(strDecrypted, 8, keyBaseStr, maskStr, strEncrypted, DF3DesDecrypt_Flag);
    string macNum = StringReverse(DFMaskMacString(GetMachineNumStr().substr(0, 16)));
    std::string license = strDecrypted.substr(0, 8);
    string validDate;
    validDate.resize(license.size());
    for(int idx=0; idx<validDate.size(); idx++)
        validDate[idx] = license[idx] ^ macNum[idx];
    validDate = HexStringReverse(ToHexString(validDate));
    if(validDate[0] == '0')
        validDate.erase(0, 1);
    string dfLsnKey = validDate.substr(0, 8);
    string dateStr = validDate.substr(8, 4) + "-" + validDate.substr(12, 2) + "-" + validDate.substr(14, 2);
    if(dfLsnKey != string((char*)DF_LICENSE_KEY))
        return asnapiRetVal_Illegal;
    if(InTime(dateStr))
        return asnapiRetVal_OutOfDate;
    return asnapiRetVal_FullEval;
}

int DF_ProcessImageapi3(void* pArgAsnPrm, int arg1, int arg2)
{
#include <dfconsole_global_definition.h>
    using namespace std;
    PDF_AsnApiArg pAsnPrm = (PDF_AsnApiArg)pArgAsnPrm;
    if(pAsnPrm == NULL)
        return;
    pAsnPrm->retVal = asnapiRetVal_Illegal;
    string locLsn = GetLicense(DFGetMaskMacString(), arg1, arg2, false, 0);
    if(locLsn == "")
        return;
    #ifdef WIN32
    // 1 CheckUKey
    pAsnPrm->retVal = CheckUKey(pAsnPrm, locLsn, arg1, arg2);
    if((pAsnPrm->retVal == asnapiRetVal_PartialLegal)||(pAsnPrm->retVal == asnapiRetVal_OutOfDate))
        return;
    #endif
    string iniLsn = GetDFDab(FILEPATH_CONF + FILENAME_INI_DFDAB);
    if(iniLsn == "")
        return;
    // 2 CheckLicense
    pAsnPrm->retVal = CheckLicense(iniLsn);
    if((pAsnPrm->retVal == asnapiRetVal_FullEval)||(pAsnPrm->retVal == asnapiRetVal_OutOfDate))
        return;
    // 3 compare license
    if(iniLsn == GetLicense(DFGetMaskMacString(), arg1+evaluateIncCode1, arg2+evaluateIncCode2, true, evaluateTurbCode))
    {
        pAsnPrm->retVal = asnapiRetVal_PartialEval;
        return;
    }
}

int DF_ProcessImageapi4(void* pArgbuf)
{
    memcpy(pArgbuf, &DFGetMaskMacString()[0], 16);
}

int DF_ProcessImageapi5(void* pArgAsnPrm, int arg1, int arg2)
{
    //PDF_AsnApiArg pAsnPrm = (PDF_AsnApiArg)pArgAsnPrm;
}

void SelfTest1()
{
    //TDF_AsnApiArg asnPrm;
    //DF_ProcessImageapi3(&asnPrm, 232, 17);
}
