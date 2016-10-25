/*************************************************************************
	> File Name: classAndObj.cpp
 ************************************************************************/

#include <iostream>
#include <cstdlib>
using namespace std;

class TDuck;
typedef TDuck* PDuck;
class TMyDuck;
typedef TMyDuck* PMyDuck;

class TDuck{

public:
    TDuck();
    ~TDuck();

    int color;

    void Speak(void)
    {
        cout << "Gua Gua Gua~~!!!" << endl;
    }

    void Swim(bool hasWater)
    {
        if(hasWater)
            Speak();
    }

    //member function declarations
    bool Fly(void);
    int GetAge();
protected:
//protected members
    bool hasBaby;
private:
    int fAge;
    PDuck fPPar;
    PDuck fPMar;
};

int TDuck::GetAge()
{
    return fAge;    
}

//member function definition
bool TDuck::Fly(void)
{
    if(fAge >= 5)
        return true;
}

TDuck::TDuck()
{
    fAge = 1;
    color = rand();
}

TDuck::~TDuck()
{
    cout << "Ender's Game"<< endl;    
}

class TMyDuck: public TDuck
{
public:
    TMyDuck();
    ~TMyDuck();
    void FindBeautyDuck(bool find)
    {
        //fAge = 19; inherit can not use fAge
        if(find)
            hasBaby = true;
        else
            hasBaby = false;
    }
};

TMyDuck::TMyDuck()
{
}

TMyDuck::~TMyDuck()
{
}

//this point this just like self in pascal

/*
 * Pointer to c++ classes
 *    pointer to class just like pointer to structure
 *    class just like structure + function
 */

/* static member
 *     all object share same class member;
 *     can initial at first
 */
int main()
{
    PMyDuck pYaYa = new TMyDuck;
    if(pYaYa->Fly())
        cout << "I can fly~~!!!" << endl;
    else
        cout << "Game over~~!!!" << endl;
    cout << pYaYa->GetAge() << endl;
    free(pYaYa);

    return 1;
}
