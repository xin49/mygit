#!/usr/bin/env python3
# coding=utf-8

# xml processing
# xml apis: 
#   Sax(simple api for xml): read and write on file not stored in memory
#   Dom(document object model): w3c standard, read xml to memory
# choice DOM apis

from xml.dom.minidom import parse
import xml.dom.minidom

# 1. read from file( xml struct parse to document )
doc = xml.dom.minidom.parse("/home/ouo/code/test/xml/nibuhao.xml")
print(doc)
# 2 create xml doc ( implementation create document )
import xml.dom
domImp = xml.dom.getDOMImplementation()# dom interface inclue xml, html, and else
print(domImp)
docNew = domImp.createDocument(None, "Root", None) # is doc equal to root? is root equal a node? but it is document
print(docNew)
ele = doc.documentElement # element? element is subclass of node, inherited all property about node
print(ele)
ele.tagName
print(ele.getAttribute("shelf"))
# 3 get the root use doc.documentElement get root
root = docNew.documentElement
# 4 read tagName, just use member tagName, can read and write it
print(ele.tagName)
print(root.tagName)
print(ele.nodeName) # ele just inherited node, we can use element as node
# 5 read content
# 6 read attribute get attribute.value or get attr object 
print(ele.attributes)
attrMap = ele.attributes # NamedNodeMap -> attrMap
attr = attrMap.item(0)
print(attr.name)
print(attr.value)
print(ele.getAttribute('shelf'))
# 7 get child with tagName
clds = ele.getElementsByTagName('movie')
print(clds)
nodes = ele.childNodes # node include element and else, so can not use nodelist to get child node
print(nodes)
cld1 = clds[0]
print(cld1) # you can get child element with tagName, 1 get ele-list 2 get ele
# 8 get child with index
# maybe you not need get child with index, but you can get the first and last child
##fir_child = ele.firstChild
##la_child = ele.lastChild
##print(fir_child.data)
##print(la_child.data) you still get the node(maybe the content node)
# 9 get child with path(full tagName)
# cld2 = doc.getElementsByTagName('collection.movies.type')
# print(cld2) no
# 10 write tagName
ele.tagName = "baby"
print(ele.tagName)
print('end')
# 11 write content
# 12 write attribute
ele.setAttribute('shelf', 'angerla')
print(ele.getAttribute('shelf'))
# 13 new node or new element
eleNew = doc.createElement('newelement')
print(eleNew.tagName)
# 14 add node or element to child bottom
ele1 = doc.createElement('newelement')
ele2 = doc.createElement('newelement')
ele2.appendChild(ele1)
cld4 = ele2.getElementsByTagName('newelement')
print(cld4)
print(cld4[0].tagName)
# 15 add node next
# 16 wirte to file
doc.writexml(open('/home/ouo/code/test/xml/pythonsave.xml', 'w'), indent="  ", addindent="  ", newl='\n')
## 3. get node attribute
#if root.hasAttribute("shelf"):
#    print("Root element: %s" % root.getAttribute("shelf"))
#
## 4. get node list with name(tagname)
#movies = root.getElementsByTagName("movie")
#idx = 0
#for movie in movies:
#    print(idx)
#    if movie.hasAttribute("title"):
#        print("Title: %s" % movie.getAttribute("title"))
#
## 5. "" = '', list get item with index [idx]
#    type = movie.getElementsByTagName('type')[0]
#
## 6. get child list(child is text), and get content with data, warning attribute diff with content
#    print("Type: %s" % type.childNodes[0].data)
#    idx += 1
#
## need:
## 1. create new doc, 2. write to file, 3. create node with name, attribute, else
## create new doc with object getDOMImplementation in xml.dom.minidom
##from xml.dom.minidom import getDOMImplementation
##impl = getDOMImplementation()
##doc = impl.createDocument(None, "doc", None)
