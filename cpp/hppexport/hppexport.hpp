#include <iostream>

using namespace std;

namespace hppexport{
extern "C"
{
    static void HelloWorld(void);

    static void HelloWorld(void)
    {
        cout << "Hello world!" << endl;
    }

}
}
