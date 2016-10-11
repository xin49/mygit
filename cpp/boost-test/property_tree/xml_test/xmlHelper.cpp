/*************************************************************************
	> File Name: xmlHelper.cpp
	> Author: 
	> Mail: 
	> Created Time: 2016年10月10日 星期一 22时07分25秒
 ************************************************************************/

#include <iostream>
#include <boost/typeof/typeof.hpp>  
#include <boost/property_tree/ptree.hpp>  
#include <boost/property_tree/xml_parser.hpp>  
#include "xmlHelper.h"

using namespace std;
using namespace boost::property_tree;  

class TXmlHelper: public ptree
{
public:
	string nodeName;
};
typedef TXmlHelper* PXmlHelper;
typedef ptree* PPtree;

#define TR(x) PXmlHelper pXmlTmp = PXmlHelper(x);

string AttributeName(string attrName)
{
    return string("<xmlattr>.")+attrName;
}

string AttributeName(string nodeName, string attrName)
{
    return nodeName + string(".<xmlattr>.")+attrName;
}

void XmlDocumentSetNodeAttributeValue(void* node, char* attrVal, char* attrName)
{
    TR(node);
    pXmlTmp->put(AttributeName(attrName), attrVal);
}

void* XmlDocumentSetNode(void* pNode, char* nodeName)
{
    TR(pNode);
    TXmlHelper xmlChild;
    PXmlHelper pXmlChild2;
    pXmlChild2 = &(TXmlHelper&)pXmlTmp->add_child(nodeName, xmlChild);
    return pXmlChild2;
}

void* XmlDocumentSetNodeValue(void* pNode, char* nodeName, char* attrVal, char* attrName)
{
    TR(pNode);
    return &pXmlTmp->put(AttributeName(nodeName, attrName), attrVal);
}

void* XmlDocumentReadFromFile(char* fileName)
{
	void* pNode = XmlDocumentCreateNode();
	TR(pNode);
	xml_parser::read_xml(fileName, *(PPtree)pXmlTmp);
	return pNode;
}

void* XmlDocumentReadFromStream(std::stringstream &stream)
{
	void* pNode = XmlDocumentCreateNode();
	TR(pNode);
	xml_parser::read_xml(stream, *(PPtree)pXmlTmp);
	return pNode;
}

void XmlDocumentWriteToFile(void* pNode, char* fileName)
{
    TR(pNode); 
	xml_writer_settings<string> settings('\t', 1);
    write_xml(fileName, *(PPtree(pXmlTmp)), std::locale(),settings);
}

void XmlDocumentWriteToSteam(void* pNode,  std::stringstream &stream)
{
    TR(pNode);
	xml_writer_settings<string> settings('\t', 1);
    write_xml(stream, *(PPtree(pXmlTmp)), settings);
}

void* XmlDocumentCreateNode()
{
    PXmlHelper pXmlTmp = new TXmlHelper;
    return pXmlTmp;
}

char* XmlDocumentGetNodeName(void* pNode)
{
	TR(pNode);
    return (char*)pXmlTmp->data().c_str();
}

void* XmlDocumentGetNode(void* pNodePar, char* argNodeName)
{
	TR(pNodePar);
    pNodeGet = &pXmlTmp->get_child(argNodeName);
    return pNodeGet;
}

char* XmlDocumentGetNodeAttrValue(void* pNode, char* attrName)
{
    TR(pNode);
    string tmp = pXmlTmp->get<string>(AttributeName(attrName));
    return (char*)tmp.c_str();
}

void XmlDocumentFree(void* pNode)
{
    TR(pNode);
	delete(pXmlTmp);
}

int& Shared(int &x)
{
    return x;
    cout << x << endl;
}

int* Pointered(int &x)
{
    return &Shared(x);
}

void test()
{
	stringstream tmp("123");
	void* pNode1 = XmlDocumentReadFromFile("/root/test/xml/test.xml");
	XmlDocumentWriteToFile(pNode1, "/root/test/xml/pNode1.xml");
	XmlDocumentWriteToSteam(pNode1, tmp);

	void* pNode2 = XmlDocumentReadFromStream(tmp);
	XmlDocumentWriteToFile(pNode2, "/root/test/xml/pNode2.xml");
	XmlDocumentFree(pNode1);
	XmlDocumentFree(pNode2);
}
