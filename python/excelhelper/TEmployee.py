#!/usr/bin/env python3
# coding=utf-8

import excelhelper

"""
THuman:
    property:
        name, id, sex, age

TEmployee:
    property:
        name, id, sex, age, checkin(kaoqin), leave(qingjia), overtime(jiaban)

checkin(kaoqin) describe
    list of record
    TRecord:
    property:
        name, typeid, days, timerange
    days| type int calc days number e.g=2017*365+2*31+15
        year
        month
        days

TDays:
    years, months, days
TTimes:
    hours, mins, secs

TRange:
    min, max
TTimeRange
    TRange， other

"""
class TRecord:
    date=0
    inTime=0
    outTime=0

    def __init__(self, argDate, argIn, argOut):
        self.date = argDate
        self.inTime = argIn
        self.outTime = argOut

class TEmployee:
    name=''
    id=0
    title = ''
    record=[]

    # class construct function __init__()// _ _ init _ _
    def __init__(self, name, id):
        self.name = name
        self.id = id 

wbsrc = open_workbook('/home/ouo/code/test/excel/xiong/src.xls')
shtsrc = wbsrc.sheets()[0]
colval = GetSheetCols(shtsrc, 1)
nameval = RemoveDuplicate(colval)
nameval.remove(nameval[0])
