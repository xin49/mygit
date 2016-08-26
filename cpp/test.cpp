/*************************************************************************
	> File Name: test.cpp
	> Author: 
	> Mail: 
	> Created Time: 2016年08月25日 星期四 17时48分55秒
 ************************************************************************/

#include<iostream>
#include<stdio.h>
#include<stdlib.h>
#include"opencv/cv.h"
#include"opencv/highgui.h"

using namespace std;

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
    IplImage* pImgSrc = cvLoadImage("/root/图片/Taissa-Farmiga-29.jpg");
    cvSaveImage("pImgSrc.jpg", pImgSrc);

    return 0;
}
//note
//malloc(size) just create size byte memory with void*(Pointer)
//use memory as array with array type(int*, char*, float* ......)

