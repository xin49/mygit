/*************************************************************************
	> File Name: loadlibrarymain.cpp
 ************************************************************************/

#include<iostream>
#include <dlfcn.h>

using namespace std;

int main()
{
    void *handle;
    char* libName = "/home/ouo/code/dfvisionsrc/svn/DF_Vision_SDK/linuxbin_x64/libdfimageprocessbrightcontrast.so";
    handle = dlopen(libName, RTLD_LAZY);
    if(handle == NULL)
    {
        cout << "load lib fail" << endl;
    }
    return 0;
}
