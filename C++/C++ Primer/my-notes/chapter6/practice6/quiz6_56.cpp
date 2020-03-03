#include <iostream>
#include "quiz6_54.hh"
#include "quiz6_55.hh"

using std::cout;
using std::endl;
using std::vector;

int main(int argc, char const *argv[])
{
    int a = 10, b = 2;
    std::vector<decltype(func) *> fV{addInt, substractInt, multipleInt, divideInt};
    for (auto f : fV)
        cout << "do something with " << a << " and " << b << " : "
             << f(a, b) << endl;
    return 0;
}
