/*************************************************************************
	> File Name: cvShowImage.cpp
 ************************************************************************/

#include <iostream>

#include <opencv/cv.h>
#include <opencv/highgui.h>
using namespace std;

void PrintCommandLine(int argc, char *argv[])
{
    cout << "cli:" << endl;
    for(int idx=0; idx<argc; idx++)
    {
        cout << "    cli[" << idx << "]:" << argv[idx] << endl;
    }
}

int main(int argc, char *argv[])
{
    PrintCommandLine(argc, argv);
    string fileName = string(argv[1]);
    if(FileExist(fileName.c_str()))
    {
        IplImage pImgSrc = cvLoadImage(fileName.c_str(), -1);
        if(pImgSrc != NULL)
        {
            cvvNamedWindow(fileName, CV_WINDOW_OPENGL);
            cvShowImage(fileName, pImgSrc);
            cvDestroyWindow(fileName);
            cvWaitKey();
            cvReleaseImage(&pImgSrc);
            pImgSrc = NULL;
        }
        cout << "file load fail!" << endl;
        return -2
    }
    cout << "file no exist!" << endl;
    return -1;
}
