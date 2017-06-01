#!/usr/bin/env python3
# coding=utf-8

class TProtocolBase:
    ' n protocol base class'
    libName = ''

aPtlBase = TProtocolBase()
bPtlBase = TProtocolBase()
aPtlBase.libName = 'liba'
bPtlBase.libName = 'libb'
print (aPtlBase)
print (aPtlBase.libName)
print (bPtlBase)
print (bPtlBase.libName)


