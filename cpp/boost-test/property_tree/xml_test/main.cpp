/*************************************************************************
	> File Name: main.cpp
	> Author: 
	> Mail: 
	> Created Time: 2016年10月10日 星期一 21时53分17秒
 ************************************************************************/

#include <iostream>  
#include <string>  
#include "main.h"
#include "xmlHelper.h"
#include <boost/typeof/typeof.hpp>
#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/xml_parser.hpp>
using namespace std;
using namespace boost::property_tree;  

int main(void)  
{  
	test();
	return 1;
    char szXmlFile[] = "/root/test/xml/test.xml";
    void* tmp = XmlHelperReadFromFile(szXmlFile);
    string strTmp;

    ptree pt;
    xml_parser::read_xml(szXmlFile, pt);
  
    ptree doc;
    ptree &root = doc.add_child("root", ptree());
    root.put("node1", "content1");
    ptree &node2 = root.add_child("node2", ptree());
    node2.put("node2Pos1", "content2");
//    boost::property_tree::xml_writer_settings<char> settings('\t', 1);
    write_xml("/root/test/xml/test_save.xml", doc);

    void* pDoc = XmlHelperCreateNode();
    void* pRoot = XmlHelperSetNode(pDoc, "root");
    XmlHelperSetNodeValue(pRoot, "node1", "content1");
    void* pNode2 = XmlHelperSetNode(pRoot, "node2");
    XmlHelperSetNodeValue(pNode2, "node3", "content2");
    void* pNodeDef = XmlHelperCreateNode();

    void* pNodeTmp = XmlHelperGetNode(pDoc, "root");
    XmlHelperSetNodeAttributeValue(pNodeTmp, "rootAttrVal");
    pNodeTmp = XmlHelperGetNode(pNodeTmp, "node1");
	XmlHelperSetNodeAttributeValue(pNodeTmp, "node1AttrVal");
	pNodeTmp = XmlHelperGetNode(pRoot, "node2");
	XmlHelperSetNodeAttributeValue(pNodeTmp, "node2AttrVal");
    pNodeTmp = XmlHelperGetNode(pRoot, "node1");

    cout << XmlHelperGetNodeAttr(pRoot) << endl;
    cout << XmlHelperGetNodeAttr(pNode2) << endl;
    cout << XmlHelperGetNodeAttr(pNodeTmp) << endl;

    cout << XmlHelperGetNodeName(pRoot) << endl;
    cout << XmlHelperGetNodeName(pNodeTmp) << endl;
    cout << XmlHelperGetNodeName(pNode2) << endl;

    XmlHelperWriteToFile(pDoc, "/root/test/xml/pDoc_save.xml");


	test();


    cout << "end" << endl;

    BOOST_AUTO(child, pt.get_child("config.file"));  
    for (BOOST_AUTO(pos, child.begin()); pos != child.end(); ++pos)  
    {  
        strTmp.clear();  
        if ("<xmlattr>" == pos->first)  
        {  
            strTmp = pos->second.get<string>("title");     // 输出：windows  
            cout<<strTmp<<"\t";  
  
            strTmp = pos->second.get<string>("size");      // 输出：10Mb  
            cout<<strTmp<<"\t";  
  
            strTmp = pos->second.get<string>("noexits", "This is default");      
            cout<<strTmp<<endl;  // 输出：This is default  
        }  
        else if ("<xmlcomment>" == pos->first)  
        {  
            strTmp = pos->second.data();     // 第一次输出：File First Comment  
            cout<<strTmp<<endl;     // 第二次输出：File Second Comment  
        }  
        else  
        {  
            BOOST_AUTO(nextchild, pos->second.get_child(""));  
            for (BOOST_AUTO(nextpos, nextchild.begin()); nextpos != nextchild.end(); ++nextpos)  
            {  
                strTmp.clear();  
                if ("<xmlattr>" == nextpos->first)  
                {  
                    strTmp = nextpos->second.get<string>("attr");  // 输出：directory  
                    cout<<strTmp<<endl;  
                }  
                else if ("<xmlcomment>" == nextpos->first)  
                {  
                    strTmp = nextpos->second.data();     // 输出：Paths Comment  
                    cout<<strTmp<<endl;  
                }  
                else  
                {  
                    strTmp = nextpos->second.get<string>("<xmlattr>.title");  
                    cout<<strTmp<<"\t";  
  
                    strTmp = nextpos->second.data();  
                    cout<<strTmp<<endl;  
                }  
            }  
        }  
          
    }  

    return 0;  
}  

typedef vector<string> TStringVector;
TStringVector GetDFVisionMainInfo(const char* fileName)
{
    void* pDoc = XmlHelperReadFromFile((char*)fileName);
    void* pRoot = XmlHelperGetNode(pDoc, "DFDgAll");
    TStringVector strVecTmp;
    strVecTmp.push_back(XmlHelperGetNodeAttrValue(pRoot, "BaseImage"));
    strVecTmp.push_back(XmlHelperGetNodeAttrValue(pRoot, "BtnCount"));
    strVecTmp.push_back(XmlHelperGetNodeAttrValue(pRoot, "LoadFileList"));
    XmlHelperFree(pDoc);
    return strVecTmp;
}

void* GetPluginParamNode(const char* fileName)
{
    void* pDoc = XmlHelperReadFromFile((char*)fileName);
    void* pRoot = XmlHelperGetNode(pDoc, "DFDgAll");
    void* pPlgNode = XmlHelperGetNode(pRoot, "Plugin");
    XmlHelperFree(pDoc);
    return pPlgNode;
}
