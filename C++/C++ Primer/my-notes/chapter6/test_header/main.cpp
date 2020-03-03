#include <iostream>
#include "test.hh"
using std::cout;
using std::endl;

int main(int argc, char const *argv[])
{
    int a = 3, b = 4;
    cout << a << " + " << b << " = " << addTwo(a, b);
    return 0;
}
