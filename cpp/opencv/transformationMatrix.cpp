/*************************************************************************
	> File Name: transformationMatrix.cpp
	> Author: 
	> Mail: 
	> Created Time: 2016年09月05日 星期一 23时40分40秒
 ************************************************************************/

#include<iostream>
#include"opencv/cv.h"
#include"opencv/highgui.h"
using namespace std;

int main(){
    //旋转中心为图像中心  
    CvPoint2D32f center;    
    center.x=float (img->width/2.0+0.5);  
    center.y=float (img->height/2.0+0.5);  
    //计算二维旋转的仿射变换矩阵  
    float m[6];              
    CvMat M = cvMat( 2, 3, CV_32F, m );  
    cv2DRotationMatrix( center, degree,1, &M);  
    //变换图像，并用黑色填充其余值  
    cvWarpAffine(img,img_rotate, &M,CV_INTER_LINEAR+CV_WARP_FILL_OUTLIERS,cvScalarAll(0) );
}
