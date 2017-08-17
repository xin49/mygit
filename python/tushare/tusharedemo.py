#!/usr/bin/env python3
# coding=utf-8

import tushare as ts
import sys

cli = sys.argv
if(len(cli) > 1):
    stockCode = cli[1]
    data = ts.get_realtime_quotes(stockCode) #Single stock symbol
    curPrice = data.get_value(0, "price")
    print(curPrice)
