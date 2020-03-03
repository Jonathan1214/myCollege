#include "TreeNode.hh"
#include <iostream>
using std::cout;
using std::endl;

int main(int argc, char const *argv[])
{
    TreeNode b, c, a(b, c);
    cout << a.getValue() << " | "
        << b.getValue() << " | "
        << c.getValue() << endl;
    b.setValue("b");
    cout << " gan " << endl;
    c.setValue("c");
    a.setValue("a").setChild(b, c);
    // 加入值后
    cout << " gan2 " << endl;
    cout << a.getValue() << " | "
        << b.getValue() << " | "
        << c.getValue() << endl;
    return 0;
}
