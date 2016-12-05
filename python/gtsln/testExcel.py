#!/usr/bin/env python3
# coding=utf-8

import os
from xlrd import open_workbook
from xlutils.filter import BaseReader

# 1 read excel e.g xls from file
# wkbook = open_workbook(os.path.join('/home/ouo/code/test/excel/请假报表2016.11.14.xls'))
wkbook = open_workbook('/home/ouo/code/test/excel/请假报表2016.11.14.xls')
print(wkbook)
# 2 get workbook module sheet
sheets = wkbook.sheets()
print(sheets)
print(len(sheets))
sht1 = wkbook.sheet_by_index(0)
sht2 = wkbook.sheet_by_name("请假报表")
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
print("end")
