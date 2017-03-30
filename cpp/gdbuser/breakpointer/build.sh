#!/bin/bash

Proj_Name=breakpointer

Src="./breakpointer.cpp"
Tool_Chains="g++"
Lib1=" -lopencv_superres"
Lib2=" -lopencv_stitching"
Lib3=" -lopencv_photo"
Lib4=" -lopencv_ocl"
Lib5=" -lopencv_objdetect"
Lib6=" -lopencv_ml"
Lib7=" -lopencv_legacy"
Lib8=" -lopencv_imgproc"
Lib9=" -lopencv_highgui"
Lib10=" -lopencv_gpu"
Lib11=" -lopencv_flann"
Lib12=" -lopencv_features2d"
Lib13=" -lopencv_core"
Lib14=" -lopencv_contrib"
Opencv_Lib=$Lib1$Lib2$Lib3$Lib4$Lib5$Lib6$Lib7$Lib8$Lib9$Lib10$Lib11$Lib12$Lib13$Lib14

$Tool_Chains $Src $Opencv_Lib -o $Proj_Name -g -w
