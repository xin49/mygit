#!/bin/bash

g++ ./hppexport.cpp -I./ -shared -fpic -g -olibhppexport.so
#g++ ./hppexport.hpp -x c++ -shared -fpic -g -olibhppexport.so
