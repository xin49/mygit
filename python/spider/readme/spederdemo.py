#!/usr/bin/env python3
# coding=utf-8

#simple spider incude(1. requests html source code; 2. re get target)
#import requests
#urlBd = 'http://www.baidu.com'
#htmlBd = requests.get(urlBd)
#print(htmlBd.text)

# 1 use requests get html source
# 2.1 use re pattern to match target info
import re

textSrc = '<a herf = "wwww.baidu.com">....'
urls = re.findall("<a herf = (.*?)>", textSrc, re.S)
for item in urls:
    print(item)

# we need get the head of html
html = '''
<html>
<title> spider base knowledge </title>
<body>
.......
</body>
</html>
'''
print(re.search('<title>(.*?)</title>', html, re.S).group(1))

pages = "http://tieba.baidu.com/p/4342201077?pn=1"
for i in range(10):
    print(re.sub("pn=\d", "pn=%d"%i, pages)) 

# 2.2 user xpath get target info like ts index path
# xpath
from lxml import etree
html='''
<div id="test1"> content1 </div>
<div id="test2"> content2 </div>
<div id="test3"> content3 </div>
'''
treeHtml = etree.HTML(html)
content = treeHtml.xpath("/")
for item in content:
    print(item)
