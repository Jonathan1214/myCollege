#include <iostream>
#include <vector>
using std::vector;
using std::string;
using std::cin;
using std::cout;
using std::endl;

int main()
{
    // 3.21
    vector<string> v1{"a", "an", "the"};
    int count = 0;
    for (auto it = v1.cbegin();
        it != v1.cend(); ++it)
    {
        count++;
        cout << *it << " ";
    }
    cout << endl;
    cout << count << endl;
    return 0;
}