#include <iostream>

std::istream &do_something(std::istream &);

int main(int argc, char const *argv[])
{
    /* code */
    return 0;
}


std::istream &do_something(std::istream &is) {
    while (!is.eof()) {
        is >> ;
    }
    std::cout << ;

    is.clear();
    return is;
}