#include <iostream>
#include "Sales_data.hh"
using std::cout;
using std::endl;

int main(int argc, char const *argv[])
{
    Sales_data d1;
    cout << endl;
    Sales_data d2("X", 1, 2);
    cout << endl;
    Sales_data d3("X");
    return 0;
}
