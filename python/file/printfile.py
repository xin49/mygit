#!/usr/bin/env python3
# coding=utf-8

# learning file object

import sys

if __name__ == '__main__':
    argLst = sys.argv
    print(argLst)
    fp = open(argLst[1], "r+")
    lineLst = fp.readlines()
    fp.close()
    #rstLst = []
    #for str in lineLst:
    #    str = str.replace(argLst[2], "", 1)
    #    rstLst.append(str)
    #fp = open(argLst[1], "w+")
    #fp.writelines(rstLst)
    #fp.close()
    print("----" + argLst[1] + "----")
    for str in lineLst:
        print(str)

