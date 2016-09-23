/*************************************************************************
	> File Name: test.cpp
	> Author: 
	> Mail: 
	> Created Time: 2016年09月19日 星期一 10时37分15秒
 ************************************************************************/
#include <stdio.h>
#include <libxml/xmlreader.h>
#include <libxml/xmlwriter.h>
#include <libxml/parser.h>
#include <libxml/tree.h>
#include<iostream>
#include <string.h>

using namespace std;

void XmlDocumentSetNodeAttributeValue(xmlNodePtr node, char* val, char* attrName="v");

xmlNodePtr XmlDocumentCreateNode(xmlDocPtr xDoc, char* argNodeName);

xmlNodePtr XmlDocumentCreateNode(xmlDocPtr xDoc, char* argNodeName, char* val, char* attrName="v");

xmlNodePtr XmlDocumentCreateRootNode(xmlDocPtr xDoc, char* rootName);

xmlNodePtr XmlDocumentAppendNode(xmlNodePtr argParNode, xmlNodePtr argNode);

xmlNodePtr XmlDocumentAppendNode(xmlDocPtr xDoc, xmlNodePtr argParNode, char* argNodeName, char* val, char* attrName="v");

xmlNodePtr XmlDocumentAppendNode(xmlDocPtr xDoc, xmlNodePtr argParNode, char* argNodeName);

char* XmlDocumentGetNodeName(xmlNodePtr argNode);

char* XmlDocumentGetNodeValue(xmlNodePtr argNode, char* attrName="v");

bool XmlDocumentGetNode(xmlNodePtr argNode, char* argNodeName, bool caseSens=false);

xmlNodePtr XmlDocumentGetNode(xmlNodePtr argNode, char* argNodeName, xmlNodePtr &vNode, bool caseSens=false);

bool XmlDocumentGetNodeValue(xmlNodePtr argNode, char* argNodeName, char* &val, char* defVal, bool caseSens=false, char* attrName="v");

xmlNodePtr XmlDocumentFindNode(xmlNodePtr argParNode, char* argNodeName);

bool XmlDocumentFindNode(xmlNodePtr argParNode, char* argNodeName, xmlNodePtr &vNodeFound);

bool XmlDocumentFindNodeGetValue(xmlNodePtr argParNode, char* argNodeName,
		char* &val, char* defVal, bool caseSens=false, char* attrName="v");

bool XmlDocumentFindNodeGetInteger(xmlNodePtr argParNode, char* argNodeName, int &val, char* defVal, bool caseSens=false, char* attrName="v");                               

xmlNodePtr XmlDocumentRecursFindNode(xmlNodePtr argParNode, char* argNodeName, xmlNodePtr &vNodeFound, bool caseSens=false);

xmlNodePtr XmlDocumentCreate(xmlDocPtr &xDoc, char* rootName);

void XmlDocumentFree(xmlDocPtr &xDoc);

xmlNodePtr XmlDocumentGetRootNode(xmlDocPtr xDoc);

xmlNodePtr XmlDocumentSetNode(xmlDocPtr xDoc, xmlNodePtr argParNode, char* argNodeName);

xmlNodePtr XmlDocumentSetNodeValue(xmlDocPtr xDoc, xmlNodePtr argParNode, char* argNodeName, char* val, char* attrName="v");

bool XmlDocumentReadFromFile(xmlDocPtr &xDoc, char* fileName);

void XmlDocumentWriteToFile(xmlDocPtr xDoc, char* fileName);        

bool XmlDocumentReadFromString(xmlDocPtr &xDoc, char* str);

char* XmlDocumentWriteToString(xmlDocPtr xDoc);

void XmlDocumentSetNodeAttributeValue(xmlNodePtr node, char* val, char* attrName)
{
    xmlNewProp(node, BAD_CAST attrName, BAD_CAST val);
}

xmlNodePtr XmlDocumentCreateNode(xmlDocPtr xDoc, char* argNodeName)
{
    xmlNodePtr node = xmlNewNode(NULL, BAD_CAST argNodeName);
    return node;
}

xmlNodePtr XmlDocumentCreateNode(xmlDocPtr xDoc, char* argNodeName, char* val, char* attrName)
{
    xmlNodePtr node = xmlNewNode(NULL, BAD_CAST argNodeName);
    XmlDocumentSetNodeAttributeValue(node, val, attrName);
    return node;
}

xmlNodePtr XmlDocumentCreateRootNode(xmlDocPtr xDoc, char* rootName)
{
    xmlNodePtr root_node = xmlNewNode(NULL, BAD_CAST rootName);
    xmlDocSetRootElement(xDoc, root_node);
    return root_node;
}

xmlNodePtr XmlDocumentAppendNode(xmlNodePtr argParNode, xmlNodePtr argNode)
{
    if(argParNode != NULL)
    {
        return xmlAddChild(argParNode, argNode);
    }
    return argNode;
}

xmlNodePtr XmlDocumentAppendNode(xmlDocPtr xDoc, xmlNodePtr argParNode, char* argNodeName)
{
    xmlNodePtr node = XmlDocumentCreateNode(xDoc, argNodeName); 
    return XmlDocumentAppendNode(argParNode, node);
}

xmlNodePtr XmlDocumentAppendNode(xmlDocPtr xDoc, xmlNodePtr argParNode, char* argNodeName, char* val, char* attrName)
{
    xmlNodePtr node = XmlDocumentCreateNode(xDoc, argNodeName, val, attrName); 
    return XmlDocumentAppendNode(argParNode, node);
}

char* XmlDocumentGetNodeName(xmlNodePtr argNode)
{
    return (char*) argNode->name;
}

char* XmlDocumentGetNodeValue(xmlNodePtr argNode, char* attrName)
{
    char* pVal = NULL;
    if(argNode != NULL)
    {
        pVal = (char*) xmlGetProp(argNode, BAD_CAST attrName);
    }
    return pVal;
}

bool XmlDocumentGetNode(xmlNodePtr argNode, char* argNodeName, bool caseSens)
{
    if(caseSens)
    {
        return(!xmlStrcmp(argNode->name, BAD_CAST argNodeName));
    }
    else
    {
        return(!xmlStrncasecmp(argNode->name, BAD_CAST argNodeName, strlen(argNodeName)));
    }
}

xmlNodePtr XmlDocumentGetNode(xmlNodePtr argNode, char* argNodeName, xmlNodePtr &vNode, bool caseSens)
{
    vNode = NULL;
    if(caseSens)
    {
        if (!xmlStrcmp(argNode->name, BAD_CAST argNodeName));
            vNode = argNode;
    }
    else
    {
        if (!xmlStrncasecmp(argNode->name, BAD_CAST argNodeName, strlen(argNodeName)));
            vNode = argNode;
    }
    return vNode;
}

bool XmlDocumentGetNodeValue(xmlNodePtr argNode, char* argNodeName, char* &val, char* defVal, bool caseSens, char* attrName)
{
    val = defVal;
    if(XmlDocumentGetNode(argNode, argNodeName, caseSens))
    {
       val = XmlDocumentGetNodeValue(argNode);
    }
    return val;
}

xmlNodePtr XmlDocumentFindNode(xmlNodePtr argParNode, char* argNodeName)
{
    xmlNodePtr curNode = argParNode->xmlChildrenNode;
    while(curNode != NULL)
    {
        if(!xmlStrcmp(curNode->name, BAD_CAST argNodeName))
        {
            break;
        }
        curNode = curNode->next;
    }
    return curNode;
}

bool XmlDocumentFindNode(xmlNodePtr argParNode, char* argNodeName, xmlNodePtr &vNodeFound)
{
    vNodeFound = XmlDocumentFindNode(argParNode, argNodeName); 
    return (vNodeFound != NULL);
}

bool XmlDocumentFindNodeGetValue(xmlNodePtr argParNode, char* argNodeName, char* &val,
		char* defVal, bool caseSens, char* attrName)
{
    return XmlDocumentGetNodeValue(XmlDocumentFindNode(argParNode, argNodeName), argNodeName, 
                                  val, defVal, caseSens, attrName);
}

bool XmlDocumentFindNodeGetInteger(xmlNodePtr argParNode, char* argNodeName, int &val, char* defVal, bool caseSens, char* attrName)                               
{
    char* valTmp;
    bool result = XmlDocumentFindNodeGetValue(argParNode, argNodeName, valTmp, defVal, caseSens, attrName);
    val = atoi(valTmp);
    return result;
}

xmlNodePtr XmlDocumentRecursFindNode(xmlNodePtr argParNode, char* argNodeName, xmlNodePtr &vNodeFound, bool caseSens)
{
    vNodeFound = NULL;
    xmlNodePtr curNode = argParNode->xmlChildrenNode;
    while(curNode != NULL)
    {
        if(XmlDocumentFindNode(curNode, argNodeName, vNodeFound))
        {
            exit;
        }
        else if(XmlDocumentRecursFindNode(curNode, argNodeName, vNodeFound, caseSens))
        {
            exit; 
        }
        curNode = curNode->next;
    }
    return vNodeFound;
}

xmlNodePtr XmlDocumentCreate(xmlDocPtr &xDoc, char* rootName)
{
    xDoc = xmlNewDoc(BAD_CAST"1.0");
    return XmlDocumentCreateRootNode(xDoc, rootName);
}

void XmlDocumentFree(xmlDocPtr &xDoc)
{
    xmlFreeDoc(xDoc);
    xDoc = NULL;
}

xmlNodePtr XmlDocumentGetRootNode(xmlDocPtr xDoc)
{
    return xDoc->xmlChildrenNode;
}

xmlNodePtr XmlDocumentSetNode(xmlDocPtr xDoc, xmlNodePtr argParNode, char* argNodeName)
{
    xmlNodePtr result = NULL;
    if(!XmlDocumentFindNode(argParNode, argNodeName))
        result = XmlDocumentAppendNode(xDoc, argParNode, argNodeName);
    return result;
}

xmlNodePtr XmlDocumentSetNodeValue(xmlDocPtr xDoc, xmlNodePtr argParNode, char* argNodeName, char* val, char* attrName)
{
    xmlNodePtr result = XmlDocumentSetNode(xDoc, argParNode, argNodeName);    
    if(result != NULL)
        XmlDocumentSetNodeAttributeValue(result, val, attrName);
    return result;
}

bool XmlDocumentReadFromFile(xmlDocPtr &xDoc, char* fileName)
{
	xDoc = xmlReadFile(fileName,"GB2312", XML_PARSE_RECOVER); //解析文件
    return (xDoc != NULL);
}

void XmlDocumentWriteToFile(xmlDocPtr xDoc, char* fileName)        
{
    xmlSaveFile(fileName, xDoc);
}

char* XmlDocumentWriteToString(xmlDocPtr xDoc){
	xmlChar* s;
	int size;
	xmlDocDumpMemory(xDoc, &s, &size);
	return (char*) s;
}

int main(void)
{
//create xml edit, print, save
    //定义文档和节点指针

    xmlDocPtr doc = xmlNewDoc(BAD_CAST"1.0");

    xmlNodePtr root_node = xmlNewNode(NULL,BAD_CAST"root");

    //设置根节点

    xmlDocSetRootElement(doc,root_node);

    //在根节点中直接创建节点

    xmlNewTextChild(root_node, NULL, BAD_CAST "newNode1", BAD_CAST "newNode1 content");

    xmlNewTextChild(root_node, NULL, BAD_CAST "newNode2", BAD_CAST "newNode2 content");

    xmlNewTextChild(root_node, NULL, BAD_CAST "newNode3", BAD_CAST "newNode3 content");

    //创建一个节点，设置其内容和属性，然后加入根结点

    xmlNodePtr node = xmlNewNode(NULL,BAD_CAST"node2");

    xmlNodePtr content = xmlNewText(BAD_CAST"NODE CONTENT");

    xmlAddChild(root_node,node);

    xmlAddChild(node,content);

    xmlNewProp(node,BAD_CAST"attribute",BAD_CAST "yes");

    //创建一个儿子和孙子节点

    node = xmlNewNode(NULL, BAD_CAST "son");

    xmlAddChild(root_node,node);

    xmlNodePtr grandson = xmlNewNode(NULL, BAD_CAST "grandson");

    xmlAddChild(node,grandson);

    xmlAddChild(grandson, xmlNewText(BAD_CAST "This is a grandson node"));

    //存储xml文档

    int nRel = xmlSaveFile("CreatedXml.xml",doc);

    if (nRel != -1)

    {

       cout<<"一个xml文档被创建,写入"<<nRel<<"个字节"<<endl;

    }

    //释放文档内节点动态申请的内存

    xmlFreeDoc(doc);

//open xml change, print, save
    //xmlDocPtr doc;           //定义解析文档指针

    xmlNodePtr curNode;      //定义结点指针(你需要它为了在各个结点间移动)

    xmlChar *szKey;          //临时字符串变量

    char *szDocName = "CreatedXml.xml";

    doc = xmlReadFile(szDocName,"GB2312",XML_PARSE_RECOVER); //解析文件

    //检查解析文档是否成功，如果不成功，libxml将指一个注册的错误并停止。

    //一个常见错误是不适当的编码。XML标准文档除了用UTF-8或UTF-16外还可用其它编码保存。

    //如果文档是这样，libxml将自动地为你转换到UTF-8。更多关于XML编码信息包含在XML标准中.

    if (doc == NULL)

    {  
       return -1;
    }

    curNode = xmlDocGetRootElement(doc); //确定文档根元素

    /*检查确认当前文档中包含内容*/

    if (NULL == curNode)

    {
       xmlFreeDoc(doc);

       return -1;

    }

    /*在这个例子中，我们需要确认文档是正确的类型。“root”是在这个示例中使用文档的根类型。*/

    if (xmlStrcmp(curNode->name, BAD_CAST "root"))

    {

       xmlFreeDoc(doc);

       return -1;

    }

    curNode = curNode->xmlChildrenNode;

    xmlNodePtr propNodePtr = curNode;

    while(curNode != NULL)

    {

       //取出节点中的内容

       if ((!xmlStrcmp(curNode->name, (const xmlChar *)"newNode1")))

       {

           szKey = xmlNodeGetContent(curNode);

           printf("newNode1: %s\n", szKey);

           xmlFree(szKey);

       }

       //查找带有属性attribute的节点

       if (xmlHasProp(curNode,BAD_CAST "attribute"))

       {

           propNodePtr = curNode;

       }

       curNode = curNode->next;

    }

    //查找属性

    xmlAttrPtr attrPtr = propNodePtr->properties;

    while (attrPtr != NULL)

    {

       if (!xmlStrcmp(attrPtr->name, BAD_CAST "attribute"))

       {

           xmlChar* szAttr = xmlGetProp(propNodePtr,BAD_CAST "attribute");

           cout<<"get attribute = "<<szAttr<<endl;

           xmlFree(szAttr);

       }

       attrPtr = attrPtr->next;

    }

    xmlFreeDoc(doc);

    return 0;
}
