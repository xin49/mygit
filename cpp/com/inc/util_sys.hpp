#ifndef UTIL_SYS_HPP
#define UTIL_SYS_HPP

#include <string>
#ifdef WIN32
#include <Windows.h>
#else
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <unistd.h>
#endif

namespace util_sys{
    using namespace std;
    //sys
    #ifdef WIN32
    static string DELIM_PATH		("\\");	
    #else
    static string DELIM_PATH		("/");
    #endif
    
    #ifdef WIN32
    static string PREFIX_LIB		("");
    #else
    static string PREFIX_LIB		("lib");
    #endif
    
    #ifdef WIN32
    static string EXT_LIB			(".dll");
    #else
    static string EXT_LIB			(".so");
    #endif

    static void* LoadLib(const char* argFileName);
    static void FreeLib(void** pHLib);
    static void* GetProcAddr(void* hLib, const char* argProcName);

    static string ExtractFileExt(const string& str)
    {
    	int idx = str.find_last_of(".");
    	if(idx < 0)
    	{
    		return "";
    	}
    	else
    	{
    		//#ifdef WIN32
    		return str.substr(str.find_last_of("."), str.length()-1);
    		//#else
    		//return str.substr(str.find_first_of("."), str.length()-1);
    		//#endif
    	}
    }
    static void* LoadLib(const char* argFileName)
    {
    	string fileName(argFileName);
    	if(ExtractFileExt(fileName) != EXT_LIB)
    		fileName = fileName + EXT_LIB;
    	#ifdef WIN32
    	return LoadLibrary(fileName.c_str());
    	#else
    	long a = fileName.find(PREFIX_LIB);
    	if(a != 0)
    		fileName = PREFIX_LIB+fileName;
    	return dlopen(fileName.c_str(), RTLD_LAZY);
    	#endif
    }
    
    static void FreeLib(void** pHLib)
    {
    	#ifdef WIN32
    	FreeLibrary((HMODULE)*pHLib);
    	#else
    	if(*pHLib != NULL)
    	dlclose(*pHLib);
    	#endif
    	*pHLib = NULL;
    }
    
    static void* GetProcAddr(void* hLib, const char* argProcName)
    {
    	#ifdef WIN32
    	return GetProcAddress(HMODULE(hLib), argProcName);
    	#else
    	return dlsym(hLib, argProcName);
    	#endif
    }
}

#endif
