/*************************************************************************
	> File Name: loadimage.cpp
 ************************************************************************/

#include<iostream>
#include<opencv/highgui.h>
#include<opencv/cv.h>

using namespace std;

int main()
{
    IplImage* pImgSrc;
    pImgSrc = cvLoadImage("/home/ouo/code/test/images/animal/hasschi.jpeg", 0);
    cvShowImage("hasschi.jpeg", pImgSrc);
    cvWaitKey(0);
    cvReleaseImage(&pImgSrc);

    return 0;
}
