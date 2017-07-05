#!/bin/bash

OutputName=$(basename $(pwd))

Cli=$1
ExtPr=$2

Root=/home/ouo/code
DFVision=$Root/dfvisionsrc
DFVisionConsole=/home/ouo/code/dfvisionsrc/cpp/DFVisionConsole_Proj
Boost=$DFVision/cpp/boost_1_61_0


#include
ThreadHelperInc=$DFVisionConsole/DFVisionConsole_Common/include
BoostInc=$Boost/boost

#Directory
BoostDir=$Boost/stage/lib/x86_64-linux

#Library
BoostLibs="boost_thread \
    -lboost_system"

$Cli $ExtPr ./*.cpp -I$ThreadHelperInc -I$BoostInc -l$BoostLibs -lpthread -L$BoostDir -fPIC -o$OutputName
