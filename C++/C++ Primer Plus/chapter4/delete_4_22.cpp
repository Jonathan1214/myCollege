#include <iostream>
#include <cstring>
using namespace std;
char *getname(void);
int main()
{
    char * name;
    name = getname();
    cout << name << " at " << (int *) name << "\n";
    delete [] name;

    name = getname();
    cout << name << " at " << (int *) name << "\n";
    delete [] name;

    cin.get();
    cin.get();
    return 0;
}

char *getname()
{
    char temp[80];
    cout << "Enter last name: ";
    cin >> temp; // 不可以直接读到 pn 中吗
    char * pn = new char[strlen(temp) + 1];
    strcpy(pn, temp);

    return pn;
}