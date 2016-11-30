#!/usr/bin/env python3
# coding=utf-8

#test xml
# Architectures and APIs -> SAX and DOM
# choice DOM
# e.g

from xml.dom.minidom import parse
import xml.dom.minidom

# Open XML document using minidom parser
DOMTree = xml.dom.minidom.parse("/home/ouo/test/xml/nibuhao.xml")
root = DOMTree.documentElement#get Root node
if root.hasAttribute("shelf"):
   print ("Root element : %s" % root.getAttribute("shelf"))
else:
    print("Root element has not value")
#1. create doc
#2. get child with name or path
#3. add/delete child
#4. get node attribute
#5. Traversion
nodes = root.getElementsByTagName("movie")
for node in nodes:
    print("****node*****")
