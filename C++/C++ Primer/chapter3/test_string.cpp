#include <iostream>
using std::cin;
using std::cout;
using std::endl;
using std::getline;
using std::string;
int main(void)
{
    /*
    string  s4P(10, 'c');
    string  s3 = "value";
    string s;
    cin >> s;
    cout << s << endl;
    cout << s4P << endl;
    */

    /*
    * 读取未知数量的string对象
    */
    /*
    string word;
    while (cin >> word) //反复读取 直到文件末尾
        cout << word << endl;
    */

    /*
    * 使用getline读取一整行
    */
    string line;
    while (getline(cin, line))
        if (!line.empty())
            cout << line << endl; //触发getline函数返回的那个换行符实际上被丢弃掉了
    return 0;
}