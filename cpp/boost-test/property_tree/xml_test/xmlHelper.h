/*************************************************************************
	> File Name: xmlHelper.h
 ************************************************************************/

#ifndef _XMLHELPER_H
#define _XMLHELPER_H

void* XmlDocumentCreateNode();

void* XmlDocumentReadFromFile(char* fileName);

void* XmlDocumentSetNode(void* pNode, char* nodeName);

void* XmlDocumentSetNodeValue(void* pNode, char* nodeName, char* attrVal, char* attrName="v");

void XmlDocumentSetNodeAttributeValue(void* node, char* attrVal, char* attrName="v");

char* XmlDocumentGetNodeName(void* pBPT);

void* XmlDocumentGetNode(void* pNodePar, char* argNodeName);

char* XmlDocumentGetNodeAttrValue(void* pNode, char* attrName="v");

void XmlDocumentWriteToFile(void* pNode, char* fileName);

void test();

#endif
