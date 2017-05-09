/*************************************************************************
	> File Name: setpstringmain.cpp
 ************************************************************************/

#include<iostream>
#include <dlfcn.h>
#include <unistd.h>

using namespace std;

#include <setpstring.h>

typedef void (*TSetPStringFunc)(std::string* pArgStr);
int main()
{
    void* hLib = dlopen("/home/ouo/code/mygit/cpp/pstring/binary/libsetpstring.so", RTLD_LAZY);
    TSetPStringFunc SetPString = (TSetPStringFunc)dlsym(hLib, "SetPString");
    std::string str;
    std::cout << "str adress:" << &str << "str size:" << sizeof(str) << std::endl;
    str = "Before Setting";
    std::cout << "str adress:" << &str << "str size:" << sizeof(str) << std::endl;
    SetPString(&str);
    std::cout << "str adress:" << &str << "str size:" << sizeof(str) << std::endl;

    return 0;
}
