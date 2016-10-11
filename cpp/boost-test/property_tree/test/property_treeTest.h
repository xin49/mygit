/*************************************************************************
	> File Name: property_treeTest.h
	> Author: 
	> Mail: 
	> Created Time: 2016年09月26日 星期一 13时38分00秒
 ************************************************************************/

#ifndef _PROPERTY_TREETEST_H
#define _PROPERTY_TREETEST_H
//#include "stdafx.h"
#include <iostream>    
#include <boost/property_tree/ptree.hpp>    
#include <boost/property_tree/ini_parser.hpp>

#define INTFUNCPOINRT(funcName) int (*funcName)(int)

typedef int (*PFunc) (int);

typedef boost::property_tree::ptree* PMyBoostPt;
typedef void* PXmlDocPtr;
typedef void* PXmlNodePtr;

#endif
