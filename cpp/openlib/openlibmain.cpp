/*************************************************************************
	> File Name: openlibmain.cpp
 ************************************************************************/

#include <iostream>
#include "../com/inc/util_sys.hpp"

using namespace std;
using namespace util_sys;
typedef void *THelloWorld(void);
int main()
{
    void pLib = LoadLib("../hppexport/libhppexport.so");
    if(pLib != NULL)
    {
        THelloWorld HelloWorld = GetProcAddr(pLib, "HelloWorld");
        if(HelloWorld != NULL)
        {
            HelloWorld();
        }
    }
    return 0;
}

