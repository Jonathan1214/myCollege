#include <iostream>
#include <cstring>
using std::cout;
using std::string;
using std::endl;

int main()
{
    // 3.31
    int a[10], count = -1;
    for (size_t i = 0; i < 10; i++)
        a[i] = i;
    for (auto i : a)
        cout << i << " ";
    cout << endl;

    // 3.37
    const char ca[] = {'h','e','l','l','o'};
    const char *cp = ca;
    while (*cp)
    {
        cout << *cp << endl;
        ++cp;
    }

    // 3.40
    const char ca1[] = "hello";
    const char ca2[] = "world";
    char ca3[20];
    strcpy(ca3, ca1);   //拷贝 ca1
    strcat(ca3, ca2);   //连接ca2
    cout << ca3 << endl;

    return 0;
}