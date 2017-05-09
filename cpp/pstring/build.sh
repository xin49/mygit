#!/bin/bash

ProjName=setpstring
OutDir=./binary
ToolChain=g++

mkdir -p $OutDir
$ToolChain ./setpstring.cpp -I./ -fPIC -shared -o$OutDir/lib$ProjName.so


ProjName=setpstringmain
$ToolChain ./setpstringmain.cpp -I./ -ldl -fPIC -o$OutDir/$ProjName
