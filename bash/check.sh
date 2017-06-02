#!/bin/bash

for libName in ./* 
do
    if [[ "$libName" == *.so ]]
    then
        #echo $libName
        rst1=$(ldd $libName | grep un)
        rst2=$(nm $libName | grep " T DF_ProcessImageapi")
        if [ "$rst1" != "" ] && [ "$rst2" != ""  ]
        then
            echo $libName
        fi
    fi
done
