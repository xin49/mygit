/*************************************************************************
	> File Name: templatetypedefmain.cpp
 ************************************************************************/

#include<iostream>
using namespace std;

template<typename T>
class TTest{
public:
    T arg1;
};

template <typename N>
typedef TTest<N> TNTest;
//using TNTest = TTest<N>;

int main()
{
    TTest<int> testInt;
    testInt.arg1 = 5;
    cout << testInt.arg1 << endl;
    return 0;
}
