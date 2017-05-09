#!/bin/bash

Mygit=/home/ouo/code/mygit/cpp/string
Openssl=/home/ouo/code/openssl-master
OpensslLib="\
    -lcrypto
"
DFVision=/home/ouo/code/dfvisionsrc/cpp/DFVisionConsole_Proj
DFVisionSDK=/home/ouo/code/dfvisionsrc/DF_Vision_SDK
DFVisionCom=$DFVision/DFVisionConsole_Common
TARGET_OS=Linux
TARGET_CPU=x86_64

g++ -fpermissive *.cpp $DFVisionCom/src/inihelper.cpp -I$DFVisionCom/include -I$Mygit -L$Openssl $OpensslLib -ldl -fPIC -o3desmain -w -g

ctags -R $DFVisionCom .
