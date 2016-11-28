#!/usr/bin/env python3
# coding=utf-8

# xml processing
# xml apis: 
#   Sax(simple api for xml): read and write on file not stored in memory
#   Dom(document object model): w3c standard, read xml to memory
# choice DOM apis

from xml.dom.minidom import parse
import xml.dom.minidom

# 1. read from file
doc = xml.dom.minidom.parse("/home/ouo/code/test/xml/nibuhao.xml")

# 2. get root
root = doc.documentElement

# 3. get node attribute
if root.hasAttribute("shelf"):
    print("Root element: %s" % root.getAttribute("shelf"))

# 4. get node list with name(tagname)
movies = root.getElementsByTagName("movie")
idx = 0
for movie in movies:
    print(idx)
    if movie.hasAttribute("title"):
        print("Title: %s" % movie.getAttribute("title"))

# 5. "" = '', list get item with index [idx]
    type = movie.getElementsByTagName('type')[0]

# 6. get child list(child is text), and get content with data, warning attribute diff with content
    print("Type: %s" % type.childNodes[0].data)
    idx += 1

# need:
# 1. create new doc, 2. write to file, 3. create node with name, attribute, else
# create new doc with object getDOMImplementation in xml.dom.minidom
from xml.dom.minidom import getDOMImplementation
impl = getDOMImplementation()
doc = impl.createDocument(None, "doc", None)
