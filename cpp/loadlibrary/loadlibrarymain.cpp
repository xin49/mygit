/*************************************************************************
	> File Name: loadlibrarymain.cpp
 ************************************************************************/

#include <iostream>
#include <string>
#ifdef WIN32
#include <Windows.h>
#else
#include <dlfcn.h>
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <unistd.h>
#endif

using namespace std;

void* LoadLib(const char* argFileName)
{
	#ifdef WIN32
	return LoadLibrary(argFileName);
	#else
	return dlopen(argFileName, RTLD_LAZY);
	#endif
}

void FreeLib(void** pHLib)
{
	#ifdef WIN32
	FreeLibrary((HMODULE)*pHLib);
	#else
	if(*pHLib != NULL)
	dlclose(*pHLib);
	#endif
	*pHLib = NULL;
}

int main()
{
    void *hLib;
    char* libName = "libdfmeasurepatternmatch.so";
    for(int idx=0; idx<10; idx++)
    {
        hLib = LoadLib(libName);
        if(hLib == NULL)
        {
            cout << "load lib fail" << endl;
        }
        FreeLib(&hLib);       
    }
    return 0;
}
