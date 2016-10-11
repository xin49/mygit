/*************************************************************************
	> File Name: xmlHelper.h
 ************************************************************************/

#ifndef _XMLHELPER_H
#define _XMLHELPER_H
#include "property_treeTest.h"
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/xml_parser.hpp>
#include <boost/foreach.hpp>

namespace pt = boost::property_tree;
typedef pt::ptree TBoostPTree;
typedef TBoostPTree* PBoostPTree;
using namespace std;

class TPTreeXmlHelper: public TBoostPTree
{
public:
    string fFileName;
    string nodeName;
    string valueTmp;
};
typedef TPTreeXmlHelper* PPTreeXmlHelper;

string BoostPTreeNodeAttr(const char* argNode, const char* argAttr);

void* XmlDocumentCreate(char* nodeName);

void* XmlDocumentCreateNode(char* argNodeName, char* content);

void* XmlDocumentCreateNodeWithAttr(char* argNodeName, char* content, char* attrName, char* val="default");
//void* XmlDocumentCreateNode(char* argNodeName, char* content, char* val, char* attrName);

void XmlDocumentAddChildList(void* pBPT, void* pBPTChild, char* nodeName);

void XmlDocumentAddChild(void* pBPT, void* pBPTChild);

void* XmlDocumentSetNode(void* pBPT, char* nodeName);

void* XmlDocumentSetNodeValue(void* pBPT, char* nodeName, char* content);

void* XmlDocumentSetNodeAttributeValue(void* pBPT, char* nodeName, char* content, char* attrName, char* val="default");

char* XmlDocumentGetNodeName(void* pBPT);

char* XmlDocumentGetNodeValue(void* pBPT);

char* XmlDocumentGetNodeAttrValue(void* pBPT, char* attrName);

void XmlDocumentSetNodeAttributeValue(void* pBPT, char* attrName, char* attrVal, char* relPath="");

void* XmlDocumentLoadFromFile(char* fileName);

void XmlDocumentWriteToFile(void* pXmlDoc, char* fileName);
#endif
