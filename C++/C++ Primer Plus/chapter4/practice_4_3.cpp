#include <iostream>
#include <cstring>
int main()
{
    using namespace std;
    char firstname[20], lastname[20], fullname[40];
    cout << "Enter your firstname: ";
    cin >> firstname;
    cout << "Enter your lastname: ";
    cin >> lastname;
    strcpy(fullname, firstname);
    strcat(fullname, ", ");
    strcat(fullname, lastname);
    cout << "Here's the information in a ingle string: " << fullname << endl;
    cin.get();
    cin.get();
    return 0;
}
