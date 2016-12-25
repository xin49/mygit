#!/usr/bin/env python3
# coding=utf-8

import os
from xlrd import open_workbook
from xlutils.filter import BaseReader
# name|id
#     name
#     PunchCardRecord()
#         monday
#             start
#             end
#         ......
#     SafeNoPunchCardRecord()
#         OutRecord
#             monday
#                 start
#                 end
#             ......
#         VacRecord
#             monday
#                 start
#                 end
#             ......
#         RegRecord
#             monday
#                 start
#                 end
#             ......

def CreateExcelData(fileName, fileType):
    wkbook = open_workbook(fileName)
class TTimeRange:
    def _init_(self, begin, end):
        self.begin = begin
        self.end = end

def IsDate(date, timeIntLst):
    subStrLst = date.split("-", 4)
    if (len(subStrLst) == 3):
        years = int(subStrLst[0])
        days = int(subStrLst[1])
        hours = int(subStrLst[2])
        timeIntLst[0] = years*365*24+days*24+hours
        return True
    return False

def TimeText2TimeInt(text, timeIntLst):
    timeIntLst[0] = -1
    return(IsDate(text, timeIntLst))
# 1 create, read excel e.g xls from file
# wkbook = open_workbook(os.path.join('/home/ouo/code/test/excel/请假报表2016.11.14.xls'))
wkbook = open_workbook('/home/ouo/code/test/excel/请假报表2016.11.14.xls')
print(wkbook)
# 2 get workbook module sheet
sheets = wkbook.sheets()
print(sheets)
print(len(sheets))
sht1 = wkbook.sheet_by_index(0)
sht2 = wkbook.sheet_by_name("请假报表")
row=sht1.row(0)
print(sht1)
print(sht2)
# 3 get row and rol or cells from sheet
print("number of rows", sht1.nrows)
print("number of cols", sht1.ncols)
cells1 = sht1.row(0)
print("row 0 text = ", cells1, len(cells1))
cells2 = sht1.col(0)
print("col 0 text = ", cells2, len(cells2))
# 4 get cell content
cel = sht1.cell(0, 2)
print(cel)
cel = cells1[2]
print(cel)
print(cel.value)
cellStr = sht1.cell(1, 4).value
timeLst=[-1]
if(TimeText2TimeInt(cellStr, timeLst)):
print(timeLst[0])
print("end")
