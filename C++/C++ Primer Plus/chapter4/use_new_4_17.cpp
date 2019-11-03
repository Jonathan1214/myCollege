#include <iostream>
int main()
{
    using namespace std;
    int nights = 1001;
    int *pt = new int;
    *pt = 1001;
    cout << "nights value = ";
    cout << nights << ": location " << &nights << endl;
    cout << "int ";
    cout << "value = " << *pt << ": location = " << pt << endl;
    delete pt; // delete 只能释放使用 new 分配的内存
    cin.get();
    return 0;
}