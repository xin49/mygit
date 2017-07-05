#!/usr/bin/env python3
# coding=utf-8

import os

cmd = "7z a"
src = " tmp.txt"
dst = " tmp.7z"
cmd = cmd + dst + src

print(cmd)
os.system(cmd)



