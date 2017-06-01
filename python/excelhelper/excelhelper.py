#!/usr/bin/env python3
# coding=utf-8

import os
from xlrd import open_workbook
from xlutils.filter import BaseReader

def GetSheetCols(argSheet, argColId):
    col = argSheet.col(argColId)
    colval = []
    for cell in col:
        if(cell.value != ''):
            colval.append(cell.value)
    return(colval)

def RemoveDuplicate(argList):
    result = []
    for val in argList:
        if not (val in result):
            result.append(val)
    return(result)

def GetListIndex(argId, argLst):
    idx2dlst = []
    for id in argId:
        idxlst = []
        index = 0
        for val in argLst:
            if(val == id):
                idxlst.append(index)
            index = index + 1
        idx2dlst.append(idxlst)
    return(idx2dlst)

def IsDate(datestr, dateLst):
    subStrLst = datestr.split("-", 4)
    if (len(subStrLst) == 3):
        dateLst[0] = int(subStrLst[0])
        dateLst[1] = int(subStrLst[1])
        dateLst[2] = int(subStrLst[2])
        return True
    return False

def DateValue(dateLst):
    result = dateLst[0] * 365 + dateLst[1] * 31 + dateLst[2]
    return result

def IsTime(timestr, timeLst):
    subStrLst = timestr.split(":", 3)
    if (len(subStrLst) == 2):
        timeLst[0] = int(subStrLst[0])
        timeLst[1] = int(subStrLst[1])
        return True
    return False

def TimeValue(timeLst):
    result = timeLst[0] * 60 + timeLst[1]
    return result

# excel helper interface
def CreateExcel()
