/*************************************************************************
	> File Name: xmlHelper.h
 ************************************************************************/

#ifndef _XMLHELPER_H
#define _XMLHELPER_H

void* XmlHelperCreateNode();

void XmlHelperFree(void* pNode);

void* XmlHelperReadFromFile(char* fileName);

void* XmlHelperAddNode(void* pNode, char* nodeName, void* pNodeAdd);

void* XmlHelperSetNode(void* pNode, char* nodeName);

void* XmlHelperSetNodeValue(void* pNode, char* nodeName, char* attrVal, char* attrName="value");

void XmlHelperSetNodeAttributeValue(void* node, char* attrVal, char* attrName="value");

char* XmlHelperGetNodeName(void* pBPT);

void* XmlHelperGetNode(void* pNodePar, char* argNodeName);

char* XmlHelperGetNodeAttrValue(void* pNode, char* argNodeName, char* attrName="value");

char* XmlHelperGetNodeAttr(void* pNode, char* attrName="value");

std::string XmlHelperGetNodeAttrValueString(void* pNode, char* argNodeName, char* attrName="value");

std::string XmlHelperGetNodeAttrString(void* pNode, char* attrName="value");

void XmlHelperWriteToFile(void* pNode, char* fileName);

int XmlHelperGetChildCount(void* pNode);

void test();

void XmlHelperRead(void* pArgObj, void* pArgStorage);

void XmlHelperWrite(void* pArgObj, void* pArgStorage);

#endif
