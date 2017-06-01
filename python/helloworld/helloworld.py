#!/usr/bin/env python3
# coding=utf-8

import keyword

def SayHello():
    print("Hello")

print ('Hello World!')

# print key words
print (keyword.kwlist)
# ['False', 'None', 'True', 'and', 'as', 'assert', 'break', 'class', 'continue', 'def', 'del', 'elif', 'else', 'except', 'finally', 'for', 'from', 'global', 'if', 'import', 'in', 'is', 'lambda', 'nonlocal', 'not', 'or', 'pass', 'raise', 'return', 'try', 'while', 'with', 'yield']

# comment
# comment 1
# comment 2

# code stages
if True:
    print('True') # use indent set code stages

# use the '\' symbol to link the one line code
nums = 1 + 2 + \
        3 + \
        4
print (nums)

# use [], {}, () not need '\' to link one line code

# string: '' and "" and """ multi-line """, '\',
input("\n\n按下enter键后退出。")

# std data type
# Python3 中有六个标准的数据类型：
#     Number（数字）
#     String（字符串）
#     List（列表）
#     Tuple（元组）
#     Sets（集合）
#     Dictionary（字典）

# initial data base
a, b, c, d = 20, 5.5, True, 4+3j
dataLst = [a, b, c, d]
for dItem in dataLst:
    print(dItem)
    print(type(dItem))
print ("print list")
print (dataLst)

SayHello()

import socket

HOST = '192.168.0.106'
PORT = 65535

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect((HOST, PORT))

idx = 0
while idx < 256:
    cmd = b"Please input msg:\n"
    s.send(cmd)
    idx += 1

