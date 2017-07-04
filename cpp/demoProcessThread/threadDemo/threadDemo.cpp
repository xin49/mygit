/*************************************************************************
	> File Name: threadDemo.cpp
 ************************************************************************/

#include <iostream>
#include <pthread.h>

using namespace std;

void* ExecuteThread1(void* pArg)
{
    cout << "thread1 create and execute!" << endl;
    cout << "thread1 create and execute!" << endl;
    cout << "thread1 create and execute!" << endl;
    *(int*)pArg = 1;
}


void* ExecuteThread2(void* pArg)
{
    cout << "thread2 create and execute!" << endl;
    cout << "thread2 create and execute!" << endl;
    cout << "thread2 create and execute!" << endl;
    *(int*)pArg = 2;
}

void* ExecuteThread3(void* pArg)
{
    cout << "thread3 create and execute!" << endl;
    cout << "thread3 create and execute!" << endl;
    cout << "thread3 create and execute!" << endl;
    *(int*)pArg = 3;
}

int main()
{
    pthread_t tid1, tid2, tid3;
    int tFlag = 0;
    int ret1 = pthread_create(&tid1, NULL, ExecuteThread1, &tFlag);
    int ret2 = pthread_create(&tid2, NULL, ExecuteThread2, &tFlag);
    int ret3 = pthread_create(&tid3, NULL, ExecuteThread3, &tFlag);

    for(int idx=0; idx<25; idx++)
    {
        cout << "tFlag:" << tFlag << endl;
    }

    pthread_exit(NULL);

    return 0;
}
