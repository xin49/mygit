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

class TXmlHelper: public basic_ptree<std::string, std::string>
{
public:
	string strTmp;
	string nodeName;
	ptree& ptreeNode;
	TXmlHelper* add_childddd(const path_type &path, TXmlHelper* pArgNode)
	{
        path_type p(path);
//        self_type &parent = force_path(p);
        // Got the parent.
//        key_type fragment = p.reduce();
		ptree& nd = ptree::add_child(path, *pArgNode);
		return pArgNode;
	};
};
typedef TXmlHelper* PXmlHelper;
typedef ptree* PPtree;

class TXmlHelperEx;
typedef TXmlHelperEx* PXmlHelperEx;

bool nage(TXmlHelperEx* p1, TXmlHelperEx* p2);
template<typename T> bool compare_no(const T* p1 , const T* p2)
{
	return strcmp(p1->nodeName.c_str(), p2->nodeName.c_str()) == 0;

}



class TXmlHelperEx
{
public:
	string nodeName;
	ptree ptreeNode;
	vector<TXmlHelperEx*> lst;
	PXmlHelperEx get_child(const string &argName)
	{
		for(unsigned int idx=0; idx<lst.size(); idx++)
		{
			if(lst[idx]->nodeName == argName)
				return lst[idx];
		}
		return NULL;
	};
	PXmlHelperEx add_child(const string &argName, TXmlHelperEx* pArgNode)
	{
		ptreeNode.add_child(argName, pArgNode->ptreeNode);
		pArgNode->nodeName = argName;
		lst.push_back(pArgNode);
		return pArgNode;
	};
	bool find_child(PXmlHelperEx pArgNode, int* pFoundIdx)
	{
		for(unsigned int idx=0; idx<lst.size(); idx++)
			if(pArgNode->nodeName == lst[idx]->nodeName)
				if(pFoundIdx != NULL)
				{
					*pFoundIdx = idx;
					return true;
				}
		return false;
	}
	PXmlHelperEx put_child(const string &argName, PXmlHelperEx pArgNode)
	{
		int foundIdx;
		PXmlHelperEx pNode;
		if(find_child(pArgNode, &foundIdx) == true)
		{
			pNode = lst[foundIdx];
			return pNode;
		}
		else
		{
			return add_child(argName, pArgNode);
		}
	};
	PXmlHelperEx put(const string &argName, const string& argVal)
	{
		int foundIdx;
		PXmlHelperEx pNode = new TXmlHelperEx;
		pNode->nodeName = argName;
		pNode = get_child(argName);
		ptreeNode.put(argName, argVal);
		return this;
	}
};
bool nage(TXmlHelperEx* p1, TXmlHelperEx* p2)
{
	return strcmp(p1->nodeName.c_str(), p2->nodeName.c_str()) < 0;
}

#define TR(x) PXmlHelper pXmlTmp = (PXmlHelper)x;

string AttributeName(string attrName)
{
    return string("<xmlattr>.")+attrName;
}

string AttributeName(string nodeName, string attrName)
{
    return nodeName + string(".<xmlattr>.")+attrName;
}

void XmlHelperSetNodeAttributeValue(void* node, char* attrVal, char* attrName)
{
    TR(node);
    pXmlTmp->put(AttributeName(attrName), attrVal);
}

void* XmlHelperAddNode(void* pNode, char* nodeName, void* pNodeAdd)
{
    TR(pNode);
    PXmlHelper pXmlChild = (PXmlHelper)pNodeAdd;
    return &(TXmlHelper&)pXmlTmp->add_child(nodeName, *pXmlChild);
}

void* XmlHelperSetNode(void* pNode, char* nodeName)
{
    TR(pNode);
    TXmlHelper xmlChild;
    PXmlHelper pXmlChild2;
    pXmlTmp->add_child(nodeName, xmlChild);
    pXmlChild2 = &pXmlTmp->get_child(nodeName);
    return pXmlChild2;
}

void* XmlHelperSetNodeValue(void* pNode, char* nodeName, char* attrVal, char* attrName)
{
    TR(pNode);
    return &pXmlTmp->put(AttributeName(nodeName, attrName), attrVal);
}

void* XmlHelperReadFromFile(char* fileName)
{
	void* pNode = XmlHelperCreateNode();
	TR(pNode);
	xml_parser::read_xml(fileName, *(PPtree)pXmlTmp);
	return pNode;
}

void* XmlHelperReadFromStream(std::stringstream &stream)
{
	void* pNode = XmlHelperCreateNode();
	TR(pNode);
	xml_parser::read_xml(stream, *(PPtree)pXmlTmp);
	return pNode;
}

void XmlHelperWriteToFile(void* pNode, char* fileName)
{
    TR(pNode); 
	xml_writer_settings<string> settings('\t', 1);
    write_xml(fileName, *(PPtree(pXmlTmp)), std::locale(),settings);
}

int XmlHelperGetChildCount(void* pNode)
{
	int cnt = 0;
	ptree::iterator childIt = ((PXmlHelper)pNode)->begin();
	ptree::iterator childEnd = ((PXmlHelper)pNode)->end();
	for(; childIt != childEnd; childIt++)
	{
		childIt->first = "Plugin101";
		cout << childIt->first << endl;
		cnt++;
	}
	return cnt;
}

void XmlHelperWriteToSteam(void* pNode,  std::stringstream &stream)
{
    TR(pNode);
	xml_writer_settings<string> settings('\t', 1);
    write_xml(stream, *(PPtree(pXmlTmp)), settings);
}

void* XmlHelperCreateNode()
{
    PXmlHelper pXmlTmp = new TXmlHelper();
    return pXmlTmp;
}

char* XmlHelperGetNodeName(void* pNode)
{
	TR(pNode);
    return (char*)pXmlTmp->data().c_str();
}

void* XmlHelperGetNode(void* pNodePar, char* argNodeName)
{
	TR(pNodePar);
	PXmlHelper pNodeGet = (PXmlHelper)&pXmlTmp->get_child(argNodeName);
    return pNodeGet;
}

void* XmlHelperGetChildWithIndex(void* pNode, int idx)
{
	ptree::iterator childIt = ((PXmlHelper)pNode)->begin();
	ptree::iterator childEnd = ((PXmlHelper)pNode)->end();
	int cnt = 0;
	for(; childIt != childEnd; childIt++)
	{
		if(cnt == idx)
			return &(childIt->second);
		cnt++;
	}
	return NULL;
}

char* XmlHelperGetNodeAttrEx(void* pNode, char* attrName)
{
    TR(pNode);
    return (char*)pXmlTmp->get<string>(AttributeName(attrName)).c_str();
}

char* XmlHelperGetNodeAttrValue(void* pNode, char* argNodeName, char* attrName)
{
	void* pNodeTmp = XmlHelperGetNode(pNode, argNodeName);
	char* pCharTmp = (XmlHelperGetNodeAttrEx(pNodeTmp, attrName));
	return pCharTmp;
}

char* XmlHelperGetNodeAttr(void* pNode, char* attrName)
{
    TR(pNode);
	string tmp = pXmlTmp->get<string>(AttributeName(attrName));
	char* pCharTmp = tmp.data();
    return pCharTmp;
}

string XmlHelperGetNodeAttrValueString(void* pNode, char* argNodeName, char* attrName)
{
	void* pNodeTmp = XmlHelperGetNode(pNode, argNodeName);
	return XmlHelperGetNodeAttr(pNodeTmp, attrName);
}

string XmlHelperGetNodeAttrString(void* pNode, char* attrName)
{
	return ((PXmlHelper)pNode)->get<string>(AttributeName(attrName));
}

void XmlHelperFree(void* pNode)
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

const char* String2PChar()
{
	std::string strTmp = "11111";
	return (strTmp.c_str());
}

void Print()
{
	char* p = "1234";
	p = String2PChar();
	string str = string(p);
	cout << str << endl;
}

void test()
{
	void* pDoc = XmlHelperReadFromFile("/root/test/xml/dfc.xml");
	void* pRoot = XmlHelperGetNode(pDoc, "DFDgAll");
	void* pPlugin = XmlHelperGetNode(pRoot, "Plugin");
	void* pPluginTmp = XmlHelperGetChildWithIndex(pPlugin, 0);
//	cout << XmlHelperGetChildCount(pPlugin) << endl;
	cout << XmlHelperGetNodeAttrValueString(pPluginTmp, "TypeID", "value") << endl;
	cout << XmlHelperGetChildCount(pRoot) << endl;
	XmlHelperWriteToFile(pDoc, "/root/test/xml/dfc_test.xml");
}

void XmlHelperRead(void* pArgObj, void* pArgStorage)
{

}

void XmlHelperWrite(void* pArgObj, void* pArgStorage)
{

}
