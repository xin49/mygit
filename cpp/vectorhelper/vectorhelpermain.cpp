/*************************************************************************
	> File Name: vectorhelpermain.cpp
 ************************************************************************/

#include <iostream>
#include <vector>
using namespace std;

int main()
{
    vector<int> vecIntVal;
    vecIntVal.push_back(0);
    vecIntVal.push_back(2);
    vecIntVal.push_back(4);
    vecIntVal.push_back(6);
    vecIntVal.push_back(8);
    vecIntVal.push_back(10);
    cout << vecIntVal.size() << endl;
    vector<int>::const_iterator it = vecIntVal.begin();
    cout << *it++ << endl;
    cout << *it++ << endl;
    cout << *it++ << endl;
    cout << *it++ << endl;
    cout << *it++ << endl;
    cout << *it++ << endl;
    return 0;
}

