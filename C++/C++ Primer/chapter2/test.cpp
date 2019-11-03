#include <iostream>

int main()
{
    int i, &ri = i;
    i = 5;
    ri = 10;
    std::cout << i << " " << ri << std::endl;

    //test
    i = 42;
    int *p;         //p是一个int指针
    int *&r = p;    //r是一个对指针p的引用

    r = &i;         //r引用了一个指针，因此r赋值&i就是令p指向i
    *r = 0;         //解引用r得到i
    // 技巧 从右往左读取
    std::cout << "i: " << i << std::endl;

    int null = 0;
    int *m = &null;
    return 0;
}