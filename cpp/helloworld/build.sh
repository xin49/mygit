#!/bin/sh

CC=$1
CPU_TARGET=$2
OS_TARGET=$3
Param=$4

Out_Dir=./$CPU_TARGET-$OS_TARGET
OUTPUT_NAME=$(basename $(pwd))
mkdir -p $Out_Dir

$CC ./helloworld.cpp -o$Out_Dir/$OUTPUT_NAME $Param
