/*************************************************************************
	> File Name: property_treeTest.cpp
	> Author: 
	> Mail: 
	> Created Time: 2016年09月26日 星期一 13时20分35秒
 ************************************************************************/

#include <iostream>
#include "property_treeTest.h"
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/xml_parser.hpp>
#include <boost/foreach.hpp>
#include <set>
#include "xmlHelper.h"

using namespace std;

int Func1(int arg)
{
    printf("arg = %d\n", arg);
}

template<class Type> void swap1(Type &a, Type &b){
	Type valTmp = b;
    b = a;
    a = valTmp;
}

template<class Type> 
class TTemClassTest{
public:
    Type a;
    typedef Type TTemClassTest_Type;
    TTemClassTest_Type b;
};

int &Calc(int &a1, int b1);

/*boost xml inteface*/
using namespace boost::property_tree;
namespace Tpt = boost::property_tree;
//void XmlDocumentSetNodeAttributeValue(xmlNodePtr node, char* val, char* attrName="v");
//xmlNodePtr XmlDocumentCreateNode(xmlDocPtr xDoc, char* argNodeName);
//xmlNodePtr XmlDocumentCreateNode(xmlDocPtr xDoc, char* argNodeName, char* val, char* attrName="v");
//xmlNodePtr XmlDocumentCreateRootNode(xmlDocPtr xDoc, char* rootName);
//xmlNodePtr XmlDocumentAppendNode(xmlNodePtr argParNode, xmlNodePtr argNode);
//xmlNodePtr XmlDocumentAppendNode(xmlDocPtr xDoc, xmlNodePtr argParNode, char* argNodeName, char* val, char* attrName="v");
//xmlNodePtr XmlDocumentAppendNode(xmlDocPtr xDoc, xmlNodePtr argParNode, char* argNodeName);
//char* XmlDocumentGetNodeName(xmlNodePtr argNode);
//char* XmlDocumentGetNodeValue(xmlNodePtr argNode, char* attrName="v");
//bool XmlDocumentGetNode(xmlNodePtr argNode, char* argNodeName, bool caseSens=false);
//xmlNodePtr XmlDocumentGetNode(xmlNodePtr argNode, char* argNodeName, xmlNodePtr &vNode, bool caseSens=false);
//bool XmlDocumentGetNodeValue(xmlNodePtr argNode, char* argNodeName, char* &val, char* defVal, bool caseSens=false, char* attrName="v");
//xmlNodePtr XmlDocumentFindNode(xmlNodePtr argParNode, char* argNodeName);
//bool XmlDocumentFindNode(xmlNodePtr argParNode, char* argNodeName, xmlNodePtr &vNodeFound);
//bool XmlDocumentFindNodeGetValue(xmlNodePtr argParNode, char* argNodeName,
//		char* &val, char* defVal, bool caseSens=false, char* attrName="v");
//bool XmlDocumentFindNodeGetInteger(xmlNodePtr argParNode, char* argNodeName, int &val, char* defVal, bool caseSens=false, char* attrName="v");                               
//xmlNodePtr XmlDocumentRecursFindNode(xmlNodePtr argParNode, char* argNodeName, xmlNodePtr &vNodeFound, bool caseSens=false);
//xmlNodePtr XmlDocumentCreate(xmlDocPtr &xDoc, char* rootName);
//void XmlDocumentFree(xmlDocPtr &xDoc);
//xmlNodePtr XmlDocumentGetRootNode(xmlDocPtr xDoc);
//xmlNodePtr XmlDocumentSetNode(xmlDocPtr xDoc, xmlNodePtr argParNode, char* argNodeName);
//xmlNodePtr XmlDocumentSetNodeValue(xmlDocPtr xDoc, xmlNodePtr argParNode, char* argNodeName, char* val, char* attrName="v");
//bool XmlDocumentReadFromFile(xmlDocPtr &xDoc, char* fileName);
//void XmlDocumentWriteToFile(xmlDocPtr xDoc, char* fileName);        
//bool XmlDocumentReadFromString(xmlDocPtr &xDoc, char* str);
//char* XmlDocumentWriteToString(xmlDocPtr xDoc);
#ifdef aa
PXmlDocPtr XmlDocumentCreate(char* rootName);
void XmlDocumentWriteToFile(PXmlDocPtr pXmlDoc, char* fileName);        
PXmlNodePtr XmlDocumentCreateNode(char* argNodeName);
PXmlNodePtr XmlDocumentCreateNode(char* argNodeName, char* attrName, char* val="");
Tpt::ptree& XmlDocumentGetChild(PXmlNodePtr pNode, char* argNodeName, bool caseSens=false);
//const data_type &data() const;
Tpt::ptree::data_type &XmlDocumentGetChildPath(PXmlNodePtr pNode, char* argNodeName, bool caseSens=false);
//PXmlNodePtr XmlDocumentGetNode(PXmlNodePtr pNode, char* argNodeName, bool caseSens=false);
char* XmlDocumentGetNodeValue(PXmlNodePtr pXmlNode, char* attrName);
bool XmlDocumentGetNodeValue(PXmlNodePtr pXmlNode, char* argNodeName, char* &val, char* defVal, bool caseSens=false, char* attrName="v");
bool XmlDocumentAddChild(PXmlNodePtr pXmlNode, char* argNodeName, char* attrName, char* argVal="");

bool XmlDocumentReadFromFile(ptree &pt, string fileName);
ptree::value_type XmlDocumentGetRootNode(ptree pt);

/*boost xml inteface*/

string BoostPTreeNodeAttr(const char* argNode, const char* argAttr)
{
	string nodeName(argNode);
	string attribute(argAttr);
	nodeName = nodeName + ".<xmlattr>." + argAttr;
	return nodeName;
}

PXmlDocPtr XmlDocumentCreate(char* rootName)
{
	PMyBoostPt pBPt = new ptree;
	pBPt->put(rootName, "");
	return (PXmlDocPtr)pBPt;
}

void XmlDocumentWriteToFile(PXmlDocPtr pXmlDoc, char* fileName)        
{
    Tpt::write_xml(fileName, *(PMyBoostPt)pXmlDoc);
}

PXmlNodePtr XmlDocumentCreateNode(char* argNodeName)
{
	PMyBoostPt pBPt = new ptree;
	ptree parent;
	ptree child;
	child.put("a", "3");
    child.put(BoostPTreeNodeAttr("a", "att1"), "val1");
	child.put("b", "4");
	PMyBoostPt(pBPt)->add_child("root", child);
	parent.add_child("root", child);
	//add node with child
	parent.add_child("root.a", child);
	//add node witn content
	parent.add("root.b", "aka");
	parent.add("root.c", "");
	parent.add("root.d.e.b.d.f", "");
    parent.put("root.e", "");

	//change or set content
	parent.put("root", "content1");
    parent.put("root", "content2");
	//change or set attr
	parent.put(BoostPTreeNodeAttr("root", "attr1"), "putValue1");
	parent.put(BoostPTreeNodeAttr("root", "attr2"), "putValue2");
	//get content
	cout << parent.get<string>(parent.begin()->first) << endl;
	//get attr
	string str_tmp = parent.begin()->first;
	cout << parent.get<string>(BoostPTreeNodeAttr(str_tmp.c_str(), "attr1")) << endl;
    //get name
	cout << parent.begin()->first << endl;
    //get child node
	Tpt::ptree tmp = (Tpt::ptree)(parent.begin()->second);
	//get child name
	cout << tmp.begin()->first << endl;
	cout << tmp.get<string>(tmp.begin()->first) << endl;
	//node iterator
	Tpt::ptree::iterator nodeIt = tmp.begin();
	for(; nodeIt != tmp.end(); nodeIt ++)
	{
		cout << nodeIt->first << endl;
	}

	Tpt::write_xml("test1.xml", *(PMyBoostPt)pBPt);
	Tpt::write_xml("test2.xml", parent);
	return (PXmlNodePtr)pBPt;
}

PXmlNodePtr XmlDocumentCreateNode(char* argNodeName, char* attrName, char* val)
{
	PMyBoostPt pBPt = (PMyBoostPt)XmlDocumentCreateNode(argNodeName);
	pBPt->put(BoostPTreeNodeAttr(argNodeName, attrName), val);
	return (PXmlNodePtr)pBPt;
}

Tpt::ptree& XmlDocumentGetChild(PXmlNodePtr pXmlNode, char* argNodeName, bool caseSens)
{
	std::set<string> m_modules;
	PMyBoostPt pBPT = (PMyBoostPt)pXmlNode;
    BOOST_FOREACH(ptree::value_type &v,
    		pBPT->get_child("root"))
        m_modules.insert(v.second.data());
	Tpt::ptree child = PMyBoostPt(pXmlNode)->get_child("root");
	for(Tpt::ptree::iterator childIt = child.begin(); childIt != child.end(); childIt ++)
	{
		if(childIt->first == "node1")
		{
			cout << childIt->first << "    argNodeName    " << argNodeName << "\n"
					<< childIt->second.begin()->first << "\n"
					<< child.data() << "\n"
					<< PMyBoostPt(pXmlNode)->data() << "\n"
					<< m_modules.begin()->data()
					<< "end" << endl;
			return childIt->second;
		}
	}
	return child;
}

Tpt::ptree::data_type &XmlDocumentGetChildPath(PXmlNodePtr pNode, char* argNodeName, bool caseSens)
{
//	Tpt::ptree child = XmlDocumentGetChild(pNode, argNodeName, caseSens);
//	char* childPath = child.begin()->first;

}
//PXmlNodePtr XmlDocumentGetNode(PXmlNodePtr pXmlNode, char* argNodeName, bool caseSens)
//{
//	Tpt::ptree child = PMyBoostPt(pXmlNode)->get_child("");
//}

char* XmlDocumentGetNodeValue(PXmlNodePtr pXmlNode, char* attrName)
{
//    return PMyBoostPt(pXmlNode)->get_value<char*>(attrName);
}

bool XmlDocumentAddChild(PXmlNodePtr pXmlNode, char* argNodeName, char* attrName, char* argVal)
{
	PMyBoostPt pBPT = (PMyBoostPt)XmlDocumentCreateNode(argNodeName, attrName, argVal);
	ptree child;
	child.put("a", "3");
	child.put("b", "4");
	PMyBoostPt(pXmlNode)->add_child("root", child);
}

//bool XmlDocumentReadFromFile(ptree &pt, string fileName)
//{
//    read_xml(fileName, pt);
//    return true;
//}
//

//ptree::value_type XmlDocumentGetRootNode(ptree pt)
//{
//
//}
#endif
int &Calc(int &a1, int b1)
{
    return a1;
}

//int main()
//{
////	PXmlDocPtr pXmlDoc = XmlDocumentCreateNode("root");
////	XmlDocumentAddChild(pXmlDoc, "node1", "attr1", "1024");
////	Tpt::ptree xmlNode = XmlDocumentGetChild(pXmlDoc, "root");
////	cout << "xmlNode	" << xmlNode.begin()->first << endl;
////    XmlDocumentWriteToFile(pXmlDoc, "test.xml");
//	void* pDoc = XmlDocumentCreate("root");
//	void* pNode = XmlDocumentCreateNode("node1", "content1");
//	XmlDocumentSetNodeAttributeValue(pNode, "attr1", "attVal1");
//	XmlDocumentSetNodeAttributeValue(pNode, "attr2", "attVal2");
//	XmlDocumentAddChild(pNode, "child1", "childContent");
//	XmlDocumentAddChild(pNode, "child2", "childContent");
//	XmlDocumentSetNodeAttributeValue(pNode, "attr2", "attrVal2Changed");
//	XmlDocumentAddChild(pDoc, "root", pNode);
////	XmlDocumentAddChild(pDoc, XmlDocumentCreateNode("node2", "content2"));
//	XmlDocumentWriteToFile(pDoc, "pDocTest.xml");
//    return 0;
//}
#include <boost/typeof/typeof.hpp>
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/xml_parser.hpp>
using namespace std;
using namespace boost::property_tree;

int main(void)
{
    char szXmlFile[] = "/root/test/xml/test.xml";

    string strTmp;

//    pt2.put("qw", "qw");
//    pt2.put("qw1", "qw1");
//    pt.add_child("root", pt2);
//    ptree& nage = pt.get_child("root");
//    nage.put("aa", "4");
//    nage.put("bb", "5");
//    ptree& sub = nage.get_child("bb");
//    sub.put("ddd", "32");

//    void* pRootFile = XmlDocumentLoadFromFile(szXmlFile);
//	void* pRootCreate = XmlDocumentCreate("root");
//	void* pNodeTmp = XmlDocumentCreateNode("nodeTest", "nodeTestContent");
////	XmlDocumentAddChild(pNode, pNodeTest);
////	XmlDocumentAddChild(pNode, pNodeTest);
////	XmlDocumentAddChild(pNode, pNodeTest);
//	XmlDocumentSetNodeValue(pNodeTmp, "PATH", "/df/df");
//	XmlDocumentSetNodeValue(pNodeTmp, "PATH", "2");
//	XmlDocumentSetNodeAttributeValue(pNodeTmp, "ISCHECK", "True", "attr1", "attr1Val");
//	XmlDocumentSetNodeAttributeValue(pNodeTmp, "SOURCE", "../", "attr2", "attr2Val");
//
//
////	cout << XmlDocumentGetNodeAttrValue(pNodeTmp, "setAttr") << endl;
//
//	XmlDocumentAddChildList(pRootFile, pNodeTmp, "PROJECT");
//	XmlDocumentAddChildList(pRootCreate, pNodeTmp, "ROOT");
//	XmlDocumentWriteToFile(pNodeTmp, "/root/test/xml/pNodeTmp.xml");
//	XmlDocumentWriteToFile(pRootFile, "/root/test/xml/pRootFile.xml");
//	XmlDocumentWriteToFile(pRootCreate, "/root/test/xml/pRootCreate.xml");
    void* pDoc = XmlDocumentCreate("root");
    void* pRoot = XmlDocumentSetNode(pDoc, "root");
    void* pNode = XmlDocumentSetNodeValue(pRoot, "ddd", "1234");
    void* pNodePot1 = XmlDocumentSetNode(pNode, "pot1");
    void* pNodePot2 = XmlDocumentSetNode(pNode, "pot2");
    XmlDocumentWriteToFile("/root/test/xml/pDoc.xml", pDoc);

//	cout << XmlDocumentGetNodeContent(pRootFile) << endl;
//	cout << XmlDocumentGetNodeName(pRootCreate) << endl;
//
//#define X(x) PPTreeXmlHelper(x)
//	cout << X(pNodeTmp)->get<string>("nodeTest") << endl;
//	cout << X(pNodeTmp)->get<string>("ISCHECK.<xmlattr>.attr1") << endl;
//	cout << X(pNodeTmp)->get<string>("ISCHECK") << endl;
//
////	cout << XmlDocumentGetNodeAttrValue(pRootFile, "qq") << endl;
////	cout << XmlDocumentGetNodeAttrValue(pRootCreate, "qq") << endl;
//
//	ptree root;
//	ptree& node2 = root.add_child("root", ptree());
//	ptree& node3 = node2.put("ddd", "123123");
//	ptree& node4 = node3.add_child("node3pot1", ptree());
//	ptree& node5 = node3.add_child("node3pot2", ptree());
//	boost::property_tree::xml_writer_settings<string> settings('\t', 1);
//	pt::write_xml("/root/test/xml/root.xml", root, std::locale(),settings);
//	pt::read_xml(szXmlFile, root);
//	node2.put("aa", "11");
//	node2.put("bb", "22");
//	node3.put("cc", "33");
//	node2.add_child("node3", node3);
//	root.add("config.file.aa", "11");
//	root.add("config.file.bb", "22");
//	root.add("config.file.cc", "33");
//	ptree& child = root.add_child("config.qweqwe", ptree());
//	root.add_child("config.go", (node2));
//	pt::write_xml("/root/test/xml/ptreeRoot.xml", root);
//
//
//	XmlDocumentAddChild(pRoot, pNode);
//    XmlDocumentAddChild(&pt, pNodeTest);
//    XmlDocumentAddChild(pNode, &pt);
//    XmlDocumentWriteToFile(pRoot, "/root/test/xml/pRoot.xml");
//    XmlDocumentWriteToFile(pNode, "/root/test/xml/pNode.xml");
    cout << "end" << endl;

//    BOOST_AUTO(child, pt.get_child("config.file"));
//    for (BOOST_AUTO(pos, child.begin()); pos != child.end(); ++pos)
//    {
//        strTmp.clear();
//        if ("<xmlattr>" == pos->first)
//        {
//            strTmp = pos->second.get<string>("title");     // 输出：windows
//            cout<<strTmp<<"\t";
//
//            strTmp = pos->second.get<string>("size");      // 输出：10Mb
//            cout<<strTmp<<"\t";
//
//            strTmp = pos->second.get<string>("noexits", "This is default");
//            cout<<strTmp<<endl;  // 输出：This is default
//        }
//        else if ("<xmlcomment>" == pos->first)
//        {
//            strTmp = pos->second.data();     // 第一次输出：File First Comment
//            cout<<strTmp<<endl;     // 第二次输出：File Second Comment
//        }
//        else
//        {
//            BOOST_AUTO(nextchild, pos->second.get_child(""));
//            for (BOOST_AUTO(nextpos, nextchild.begin()); nextpos != nextchild.end(); ++nextpos)
//            {
//                strTmp.clear();
//                if ("<xmlattr>" == nextpos->first)
//                {
//                    strTmp = nextpos->second.get<string>("attr");  // 输出：directory
//                    cout<<strTmp<<endl;
//                }
//                else if ("<xmlcomment>" == nextpos->first)
//                {
//                    strTmp = nextpos->second.data();     // 输出：Paths Comment
//                    cout<<strTmp<<endl;
//                }
//                else
//                {
//                    strTmp = nextpos->second.get<string>("<xmlattr>.title");
//                    cout<<strTmp<<"\t";
//                    strTmp = nextpos->second.data();
//                    cout<<strTmp<<endl;
//                }
//            }
//        }
//
//    }
    return 0;
}
