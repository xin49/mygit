#!/bin/bash

for libName in ./* 
do
    if [[ "$libName" == * ]]
    then
        rst2=$(nm $libName | grep " T _ZN2cv9ExceptionC1")
        if [ "$rst2" != ""  ]
        then
            echo $libName defined symbol
        fi
    fi
done
