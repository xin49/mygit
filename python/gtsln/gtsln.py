#!/usr/bin/env python3
# coding=utf-8

from xml.dom.minidom import parse
from xml.dom.minidom import getDOMImplementation
import xml.dom.minidom

impl = getDOMImplementation()
doc = impl.createDocument(None, "doc", None)
root = doc.documentElement
#save to file
f_hdl = open("gtsln.xml", "wb")
doc.writexml(f_hdl)
f_hdl.close()
