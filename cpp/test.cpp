/*************************************************************************
	> File Name: test.cpp
	> Author: 
	> Mail: 
	> Created Time: 2016年08月25日 星期四 17时48分55秒
 ************************************************************************/

#include<iostream>
#include<stdio.h>
#include<stdlib.h>
#include <dlfcn.h>
//#include"opencv/cv.h"
//#include"opencv/highgui.h"

using namespace std;

timespec diff(timespec start, timespec end)
{
timespec temp;
if ((end.tv_nsec-start.tv_nsec)<0) {
temp.tv_sec = end.tv_sec-start.tv_sec-1;
temp.tv_nsec = 1000000000+end.tv_nsec-start.tv_nsec;
} else {
temp.tv_sec = end.tv_sec-start.tv_sec;
temp.tv_nsec = end.tv_nsec-start.tv_nsec;
}
return temp;
}

int sum(int a, int b){
    return (a+b);
}

inline int inlineSum(int a, int b){
    return (a+b);
}

int calc1(int a, int b, int c, int d){
    return ((a + b) * c) >> d;
}

int inlineCalc1(int a, int b, int c, int d){
    return ((a + b) * c) >> d;
}

int main()
{
/* test malloc, Pointer, free
    printf("sizeof(int)%d\n", sizeof(int));
    int *pIntTmp = (int*)malloc(2 * sizeof(int));
    char *pCharTmp = (char*)pIntTmp;
    for(int j =0; j < 2; j++)
    {
        pIntTmp[j]=j;
        printf("pIntTmp[%d]=%d\n", j, pIntTmp[j]);
    }
    printf("//////////\n");
    for(int j =0; j < 8; j++)
    {
        pCharTmp[j]=char(65+j);
        printf("pIntTmp[%d]=%c\n", j, pCharTmp[j]);
    }
    //out of memory limit, crash at free memory
    free(pIntTmp);
*/
/*
    IplImage* pImgSrc = cvLoadImage("/root/图片/Taissa-Farmiga-29.jpg");
    cvSaveImage("pImgSrc.jpg", pImgSrc);
*/
    //timespec time1, time2;
    //int temp;
    //clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);
    //for(int j = 0; j < 10; j++)
    //    for (int i = 0; i< 242000000; i++)
    //        temp+=temp;
    //clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2);
    //cout<<diff(time1,time2).tv_sec<<"s"<<diff(time1,time2).tv_nsec/1000000<<"ms"<<endl;

/*test add and mul used time */
/*
    timespec time1, time2;
    int i, j, k;
    i = 0;
    j = 1;
    k = 1;
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);
    while(i < 1000000000)
    {
        j += k;
        i++;
    }
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2);
    cout<<"Add Used Times:"<<diff(time1,time2).tv_sec<<"s"<<diff(time1,time2).tv_nsec/1000000<<"ms"<<endl;

    i = 0;
    j = 1;
    k = 1;
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);
    while(i < 1000000000)
    {
        j *= k;
        i++;
    }
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2);
    cout<<"Mul Used Times:"<<diff(time1,time2).tv_sec<<"s"<<diff(time1,time2).tv_nsec/1000000<<"ms"<<endl;

    i = 0;
    j = 1;
    k = 1;
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);
    while(i < 1000000000)
    {
        j >> 15;
        i++;
    }
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2);
    cout<<">> Used Times:"<<diff(time1,time2).tv_sec<<"s"<<diff(time1,time2).tv_nsec/1000000<<"ms"<<endl;*/
/* Add Used Times:2s90ms Mul Used Times:2s565ms */

/* test inline func spend time 

    timespec time1, time2;
    int i, j, k;
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);
    while(i < 1000000000)
    {
        k = calc1(1, 2, 3, 4);
        i++;
    }
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2);
    cout<<"sum Used Times:"<<diff(time1,time2).tv_sec<<"s"<<diff(time1,time2).tv_nsec/1000000<<"ms"<<endl;

    i = 0;
    j = 1;
    k = 1;
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time1);
    while(i < 1000000000)
    {
        k = inlineCalc1(1, 2, 3, 4);
        i++;
    }
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &time2);
    cout<<"inlineSum Used Times:"<<diff(time1,time2).tv_sec<<"s"<<diff(time1,time2).tv_nsec/1000000<<"ms"<<endl;
 inline function not spent less time obvious */
//sum Used Times:3s741ms
//inlineSum Used Times:3s403ms
/* */
    dlopen("1.so", 0);
    printf("df");
    return 0;
}
//note

//malloc(size) just create size byte memory with void*(Pointer)
//use memory as array with array type(int*, char*, float* ......)

//Test clock_gettime

//test opencv

/* Add Used Times:2s90ms Mul Used Times:2s565ms, 
 * << and >> spent less time */
