#!/usr/bin/env python3
# coding=utf-8

#         fh_file.py process file
# python3 process file with file object and file api
# 1. open, create, save
# 2. read, write
# 3. seek, search, position
print ("fh_file begin")
# open and create
fp = open('fh_file_test.txt', 'wb+') # write from head and cover file content
# read, write
str = b'Python is a great language.\nYeah its great!!\n'
# write accept byte-like string
# test chinese
fp.write(str)
# str_cn = b'中文' byte-like can just containt ansic code
str_cn = '中文'
str_cn = str_cn.encode('utf-8') # because of file encoding type utf-8 so need encoding to ansi encode('utf-8') --> ansi
fp.write(str_cn) # write in current line, not new line
# read
fp_cont = fp.read(20)
print(fp_cont)
fp.close()
fp = open('fh_file_test.txt', 'rb+') # read file need open file with "r+"
str = fp.read(10) # read from position, length = 10
print (str)
fp.close()
print ("fh_file end")

# diff between w+ and wb+
fp = open("writetest.txt", "w+")
bfp = open("writetestb.txt", "wb+")
fp.write("hello world!")
bfp.write(b"hello world!")
fp.write("你好，我家！")
str_zh = ("你好，我家！").encode('utf-8')
bfp.write(str_zh)
fp.close()
bfp.close()

# test read
fp = open("侠客行.txt", "r+")
print (fp.read(2000))
print (fp.tell())
print (fp.read(2000))
print (fp.tell())
fp.seek(0)
print (fp.tell())
print (fp.read(2000))
