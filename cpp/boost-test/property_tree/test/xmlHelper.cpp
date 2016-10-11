/*************************************************************************
	> File Name: xmlHelper.cpp
 ************************************************************************/

#include<iostream>
#include "xmlHelper.h"

#define NODENAME(pBPT) XmlDocumentGetNodeName(pBPT)
#define NODEATTRNAME(attrName) (pt::xml_parser::xmlattr<string>()+ string(".")+ string(attrName))
using namespace boost::property_tree;

string BoostPTreeNodeAttr(const char* argNode, const char* argAttr)
{
	string nodeName(argNode);
	string attribute(argAttr);
	nodeName = nodeName + ".<xmlattr>." + argAttr;
	return nodeName;
}

void* XmlDocumentCreate(char* nodeName)
{
	PPTreeXmlHelper pBPT = new TPTreeXmlHelper;
	pBPT->nodeName = string(nodeName);
	return pBPT;
}

void* XmlDocumentCreateNode(char* argNodeName, char* content)
{
	PPTreeXmlHelper pBPT = new TPTreeXmlHelper;
	pBPT->put(argNodeName, content);
	return pBPT;
}

void* XmlDocumentCreateNodeWithAttr(char* argNodeName, char* content, char* attrName, char* val)
{
	PPTreeXmlHelper pBPT = new TPTreeXmlHelper;
	pBPT->put(argNodeName, content);
	pBPT->put(BoostPTreeNodeAttr(argNodeName, attrName), val);
	return pBPT;
}

void XmlDocumentAddChildList(void* pBPT, void* pBPTChild, char* nodeName)
{
	PPTreeXmlHelper pBPTTmp = (PPTreeXmlHelper)pBPT;
	PPTreeXmlHelper pBPTChildTmp = (PPTreeXmlHelper)pBPTChild;
	pBPTTmp->add_child(nodeName, *pBPTChildTmp);
}

//void XmlDocumentAddChild(void* pBPT, void* pBPTChild)
//{
//	PPTreeXmlHelper pBPTTmp = (PPTreeXmlHelper)pBPT;
//	PPTreeXmlHelper pBPTChildTmp = (PPTreeXmlHelper)pBPTChild;
//	pBPTTmp->insert(pBPTTmp->begin()->second.get_child("").begin(), pBPTChildTmp->begin(), pBPTChildTmp->end());
//}

void* XmlDocumentSetNode(void* pBPT, char* nodeName)
{
	PPTreeXmlHelper pBPTTmp = (PPTreeXmlHelper)pBPT;
	PPTreeXmlHelper child = &(pBPTTmp->add_child(nodeName, ptree()));
	return child;
}

void* XmlDocumentSetNodeValue(void* pBPT, char* nodeName, char* content)
{
	PPTreeXmlHelper pBPTTmp = (PPTreeXmlHelper)pBPT;
	return &(pBPTTmp->put(nodeName, content));
}

void* XmlDocumentSetNodeAttributeValue(void* pBPT, char* nodeName, char* content, char* attrName, char* val)
{
	PPTreeXmlHelper pBPTTmp = (PPTreeXmlHelper)pBPT;
	pBPTTmp->put(nodeName, content);
	pBPTTmp->put(BoostPTreeNodeAttr(nodeName, attrName), val);
}
//TBoostPTree &XmlDocumentGetChild(PPTreeXmlHelper pBPT, bool &findNode, char* nodeName, bool caseSens)
//{
//    findNode = false;
// 	TBoostPTree::iterator childIt = child.begin();
//	for(; childIt != child.end(); childIt ++)
//	{
//		if(childIt->first == nodeName)
//		{
//            findNode = true;
//            break;
//		}
//	}
//	return childIt->second;   
//}
//
//TBoostPTree &XmlDocumentGetNode(PPTreeXmlHelper pBPT, bool &findNode, char* nodeName, bool caseSens)
//{
//
//}

char* XmlDocumentGetNodeName(void* pBPT)
{
    string str_tmp = PPTreeXmlHelper(pBPT)->begin()->first;
    return (char*)str_tmp.c_str();
}

char* XmlDocumentGetNodeValue(void* pBPT, char* nodeName)
{
//	PPTreeXmlHelper pBPTTmp = (PPTreeXmlHelper)pBPT;
//	pBPTTmp->
//    return (char*)PPTreeXmlHelper(pBPT)
}

char* XmlDocumentGetNodeAttrValue(void* pBPT, char* attrName)
{
	PPTreeXmlHelper(pBPT)->valueTmp = PPTreeXmlHelper(pBPT)->get<string>(NODEATTRNAME(attrName));
    return (char*)PPTreeXmlHelper(pBPT)->valueTmp.c_str();
}

void* XmlDocumentLoadFromFile(char* fileName)
{
    PPTreeXmlHelper pBPT = new TPTreeXmlHelper;
	pt::read_xml(fileName, *PBoostPTree(pBPT));
	return pBPT;
}

void XmlDocumentWriteToFile(void* pXmlDoc, char* fileName)
{
	boost::property_tree::xml_writer_settings<string> settings('\t', 1);
	pt::write_xml(fileName, *PBoostPTree(pXmlDoc), std::locale(),settings);
}

void PrintXmlNodeInfo(void* pBPT)
{
	PPTreeXmlHelper pBPTTmp = (PPTreeXmlHelper)pBPT;
//	for(TPTreeXmlHelper::iterator it = pBPTTmp->begin(); it != pBPTTmp->end(); it++)
//	{
//		if ("<xmlattr>" == pos->first)
//		{
//			strTmp = pos->second.get<string>("title");     // 输出：windows
//			cout<<strTmp<<"\t";
//
//			strTmp = pos->second.get<string>("size");      // 输出：10Mb
//			cout<<strTmp<<"\t";
//
//			strTmp = pos->second.get<string>("noexits", "This is default");
//			cout<<strTmp<<endl;  // 输出：This is default
//		}
//		else if ("<xmlcomment>" == pos->first)
//		{
//			strTmp = pos->second.data();     // 第一次输出：File First Comment
//			cout<<strTmp<<endl;     // 第二次输出：File Second Comment
//		}
//		else if ("<xmlcomment>" == pos->first)
//	}
}
