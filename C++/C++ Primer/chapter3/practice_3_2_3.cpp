#include <iostream>
using namespace std;

int main()
{
    string line("abcdefg1214");

    /*
    for (auto &c : line) // 可以使用下标进行迭代 也可以使用范围for语句
        c = toupper(c); // 修改成X
    cout << line << endl;
    */

    for (decltype(line.size()) index = 0;
        index != line.size(); ++index)
    {
        line[index] = char("X");
    }
    cout << line << endl;
    return 0;
}