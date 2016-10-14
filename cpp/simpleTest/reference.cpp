/*************************************************************************
	> File Name: reference.cpp
	> Created Time: 2016年10月14日 星期五 23时04分56秒
 ************************************************************************/

#include<iostream>
using namespace std;

//return reference value
//transfer reference value type int&x
//return reference value type int&
//call function like retReference(x)
//get return value int&y = retReference(x)
//x, local_x, y have same adress
//reference just like point use
//use the same adress
int& retReference(int& x)
{
    x = 10;
    cout << &x << endl;
    return x;
}

int& retReference()
{
    static int x = 10;    
    cout << &x << endl;
    return x;
}

typedef struct _TMyType{
    int x;
}TMyType;
typedef TMyType* PMyType;

int& retReferenceStruct(PMyType argPMe)
{
    cout << &argPMe->x << endl;
    return argPMe->x;
}

int main()
{
    int x;
    int& y = retReference(x);
    cout << &x << endl;
    cout << &y << endl;
    cout << x << endl;
    cout << y << endl;

    int& z = retReference();
    cout << &z << endl;
    cout << z << endl;

    PMyType pMyT = new TMyType;
    pMyT->x = 10;
    
    cout << "////////////////" << endl;
    int& k = retReferenceStruct(pMyT);
    cout << pMyT->x << endl;
    cout << &pMyT->x << endl;
    return 0;
}
