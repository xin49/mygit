/*************************************************************************
	> File Name: main.h
 ************************************************************************/

#ifndef _MAIN_H
#define _MAIN_H

//enmu cmd range in [base, end]
const int ECmdUndefined = -1;
const int ECmdBase = ECmdUndefined + 1;
const int ECmdGetMacCode = ECmdBase + 1;
const int ECmdGetMacAddress = ECmdBase + 2;
const int ECmdGetLicense = ECmdBase + 3;
const int ECmdCheckLicense = ECmdBase + 4;
const int ECmdEnd = ECmdUndefined + 10;
//enmu cmd name
const char ECmdUndefinedName[] = "Undefine";
const char ECmdBaseName[] = "Base";
const char ECmdGetMacCodeName[] = "GetMacCode";
const char ECmdGetMacAddressName[] = "GetMacAdress";
const char ECmdGetLicenseName[] = "GetLicense";
const char ECmdCheckLicenseName[] = "CheckLicense";
const char ECmdEndName[] = "End";
//flag
const int FIsMacAddr = 0;
const int FIsMacCode = 1;
//flag name
const char FIsMacAddrName[] = "IsMacAddr";
const char FIsMacCodeName[] = "IsMacCode";

#endif
