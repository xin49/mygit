/*************************************************************************
	> File Name: loaddemo.cpp
 ************************************************************************/

#include <iostream>
#include "opencv/cv.h"
#include "opencv/highgui.h"

using namespace std;

int main(void)
{
    IplImage* pImgSrc = cvLoadImage("/home/ouo/code/test/images/human/stoya/stoya-m.jpg", -1);
    cvSaveImage("loaddemo.bmp", pImgSrc);
    cvShowImage("loaddemo", pImgSrc);
    cvWaitKey(0);
    cvReleaseImage(&pImgSrc);
    return 0;
}
