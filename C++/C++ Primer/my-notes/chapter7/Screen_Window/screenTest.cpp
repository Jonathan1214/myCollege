#include <iostream>
using std::cout;
using std::endl;

#include "Screen.hh"

int main(int argc, char const *argv[])
{
    Screen myscreen(5, 5, 'X');
    myscreen.move(4, 0).set('#').display(cout);
    cout << "\n";
    myscreen.display(cout);
    cout << "\n";
    return 0;
}
