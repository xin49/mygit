 // watch value when value change will stop and show old and new value
 // 1 b function: set break pointer to function defind
 // 2 enable/disanble index: set break pointer enable or disanble
 // 3 b sourcefiles:line: set break to source files line
 // 4 b break point if condition: b 222 if val == test
 // 5 print memory: x/nfu adress
 // 6 watch memory: watch *adress

#include<iostream>
#include<opencv/highgui.h>
#include<opencv/cv.h>

using namespace std;

void Loops(int argLoopTime)
{
    int roll;
    for(int idx=0; idx<argLoopTime; idx++)
    {
        roll = rand();
        std::cout << roll << std::endl;
    }
}

void Memory(int argSz)
{
    int staticIntArray[] = {0, 1, 2, 3, 4};
    for(int idx=0; idx<5; idx++)
        std::cout << staticIntArray[idx] << std::endl;
}

int main()
{
    //IplImage* pImgSrc;
    //pImgSrc = cvLoadImage("/home/ouo/code/test/images/animal/hasschi.jpeg", 0);
    //cvShowImage("hasschi.jpeg", pImgSrc);
    //cvWaitKey(0);
    //cvReleaseImage(&pImgSrc);
    Loops(7);
    Memory(10);
    return 0;
}
