#!/usr/bin/env python3
# coding=utf-8

import os
from xlrd import open_workbook
from xlutils.filter import BaseReader
import testStruct

# excel helper api
# python3 excele struct
# workbook
#     sheets
#         rows
#         cols
#         cells
#         
# 1. open excel file get workbook
# wkbook=open_workbook(fileName)
# sheets=wkbook.sheets()
# sheet=sheets[idx]
# rows=sheet.get_rows()

wkbook = open_workbook('/home/ouo/code/test/excel/请假报表2016.11.14.xls')
sheets = wkbook.sheets()
sheet_cnt = len(sheets)
for sheet in sheets:
    print(sheet)
    rows=sheet.get_rows()
    for row in rows:
        print(row)
        for text in row:
            print(text)

SHEEP_TYPE_UNDEF = 0

def GetSheetType(sheet):
    return SHEEP_TYPE_UNDEF

def AppendTEmployeeTime(row, time_type, data_base):
    Get
def ProcessGTRow(row, sheet_type, data_bases):
    time_type=sheet_type
    data_base=TEmployee(row[0], 0)
    AppendTEmployeeTime(row, time_type, data_base)
    data_bases.append(data_base)

def ProcessGTExcel(sheet, sheet_type):
    data_bases=[]
    rows=sheet.get_rows()
    for row in rows:
        ProcessGTRow(row, sheet_type, data_bases)
    return  data_bases

# Traversal
def TraversalSheet(sheet, CBProcessSheet):
    sheet_type=GetSheetType(sheet)
    data_bases=CBProcessSheet(sheet, sheet_type)

def TraversalExcel(wkbook):
    sheets=wkbook.sheets()
    for sheet in sheets:
        data_bases=TraversalSheet(sheet)

