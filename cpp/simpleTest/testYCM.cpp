/*************************************************************************
	> File Name: testYCM.cpp
	> Author: 
	> Mail: 
	> Created Time: 2016年10月25日 星期二 13时36分48秒
 ************************************************************************/

#include <iostream>
#include <sstream>

using namespace std;

typedef struct _TSettingNode{
    string nodeName;
    int attrNum;
}TSettingNode;

template <typename Type> 
inline Type StringTo(string str)
{
    std::stringstream streamTmp;
    streamTmp.str(str);
    Type result;
    streamTmp >> result; 
    return result;
}

int main()
{
    string str = "11";
    int intTmp = StringTo<int>(str);
    str = "121.2323";
    double dbTmp = StringTo<double>(str);
    bool df = StringTo<bool>(str);
    cout << intTmp << endl;
    cout << dbTmp << endl;
    cout << df << endl;
}
