#include <iostream>
#include <vector>
using std::vector;
using std::string;
using std::cin;
using std::cout;
using std::endl;

int main()
{
    // 3.16
    vector<int> v1, v2(10), v3(10,42);
    vector<int> v4{10}, v5{10,42};
    vector<string> v6{10};
    vector<string> v7{10, "hi"};

    cout << "There are " << v1.size() << " items in v1 :";
    for (auto c: v1)
        cout << c << " ";
    cout << endl;

    cout << "There are " << v2.size() << " items in v2 :";
    for (auto c: v2)
        cout << c << " ";
    cout << endl;

    // 3.17
    vector<string> words;
    string word, line;
    getline(cin, line); //读取一行
    for (decltype(line.size()) n = 0; n < line.size(); ++n)
        if (line[n]) { //不为空 原来空格不算空字符
            cout << line[n] << endl;
            word += line[n]; // 大写
        }
        else {
            cout << word << endl;
            words.push_back(word);
            word = ""; //清空
        }
    cout << words.size() << endl;
    for (auto w : words)
        cout << w << " ";
    cout << endl;

    // for (auto &c : line)
    //     if (c)
    //         c = toupper(c);
    // cout << line << endl;

    return 0;
}