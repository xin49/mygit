///*************************************************************************
//	> File Name: createthread.cpp
// ************************************************************************/
//
//#include <stdio.h>
//#include <unistd.h>
//// usleep(3);
//#include <pthread.h>
//
//// base interface
//// int pthread_create(pthread_t *tid, const pthread_attr_t *attr, void *(*func) (void *), void *arg);
//// int pthread_join (pthread_t tid, void ** status);
//// pthread_t pthread_self (void);
//// int pthread_detach (pthread_t tid);
//// void pthread_exit (void *status);
//
//int g_Flag = 0;
//
//void* Thread1Execute(void* pArg)
//{
//    printf("This is thread1!\n");
//    g_Flag = *(int*)pArg;
//    while(1)
//    {
//        printf("1");
//    }
//    pthread_exit(0);
//}
//
//void* Thread2Execute(void* pArg)
//{
//    printf("This is thread2!\n");
//    g_Flag = *(int*)pArg;
//    while(1)
//    {
//        printf("2");
//    }
//    pthread_exit(0);
//}
//
//int main(void)
//{
//    pthread_t thread1;
//    pthread_t thread2;
//    int thread1Arg = 1;
//    int thread2Arg = 2;
//    printf("g_Flag=%d\n", g_Flag);
//    pthread_create(&thread1, NULL, &Thread1Execute, &thread1Arg);
//    printf("g_Flag=%d\n", g_Flag);
//    pthread_create(&thread2, NULL, &Thread2Execute, &thread2Arg);
//    printf("g_Flag=%d\n", g_Flag);
//    return 0;
//}

#include <iostream>
#include <cstdlib>
#include <pthread.h>
#include <unistd.h>
#include <threadhelper.h>
 
using namespace std;
using namespace threadhelper;
 
#define NUM_THREADS     5
 
void *wait(void *t)
{
   int i;
   long tid;
 
   tid = (long)t;
 
   sleep(1);
   cout << "Sleeping in thread " << endl;
   long int curTId = GetThreadId();
   cout << "Thread with id: " << tid << "; Cur TId:" << curTId << ";  ...exiting " << endl;
   pthread_exit(NULL);
}
 
int main ()
{
   int rc;
   int i;
   pthread_t threads[NUM_THREADS];
   pthread_attr_t attr;
   void *status;
 
   // 初始化并设置线程为可连接的（joinable）
   pthread_attr_init(&attr);
   pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_JOINABLE);
 
   for( i=0; i < NUM_THREADS; i++ ){
      cout << "main() : creating thread, " << i << endl;
      rc = pthread_create(&threads[i], NULL, wait, (void *)&i );
      if (rc){
         cout << "Error:unable to create thread," << rc << endl;
         exit(-1);
      }
   }
 
   // 删除属性，并等待其他线程
   pthread_attr_destroy(&attr);
   for( i=0; i < NUM_THREADS; i++ ){
      rc = pthread_join(threads[i], &status);
      if (rc){
         cout << "Error:unable to join," << rc << endl;
         exit(-1);
      }
      cout << "Main: completed thread id :" << i ;
      cout << "  exiting with status :" << status << endl;
   }
 
   cout << "Main: program exiting." << endl;
   pthread_exit(NULL);
}
