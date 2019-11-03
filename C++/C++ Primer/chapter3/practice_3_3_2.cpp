#include <iostream>
#include <vector>
#include <cctype>
using std::vector;
using std::cin;
using std::cout;
using std::endl;
using std::string;

int main()
{
    /*
    * 有几件事情要做
    * 获得输入
    * 判断输入
    * 写到vector中
    */
    vector<string> str;
    vector<int> aintvec;
    string word;
    /*
    while (cin >> word)
        if (!word.empty())
            for (auto c : word)
                if (isdigit(c))
                    str.push_back(c);
    */

    int tmp;
    while (cin >> tmp)
        aintvec.push_back(tmp);
    return 0;
}