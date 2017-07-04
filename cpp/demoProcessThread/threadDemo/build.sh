#!/bin/bash

Cc=$1
CpuTar=$2
OsTar=$3
ExPrm=$4

OutputName=$(basename $(pwd))

$Cc $ExPrm *.cpp -lpthread -o$OutputName
