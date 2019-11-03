#include <iostream>
#include <vector>
using std::vector;
using std::string;
using std::cout;
using std::endl;

int main()
{
    /*
    * vector 对象初始化
    */
    // 1. 列表初始化
    vector<string> articles = {"a", "an", "the"}; //C++11
    vector<string> v2{"a", "an", "the"}; //使用花括号初始化

    // 2. 创建指定数量的元素
    vector<int> ivec(10, -1); //10个int类型的元素，每个都被杵疏花为-1
    vector<string> svec(10, "hi!"); // 10个string类型元素

    // 3. 值初始化
    vector<int> ivec2(10);  // 10个元素，每个都初始化为0

    vector<int> v{1,2,3,4,5,6};
    for (auto i : v)
        cout << i << " ";
    cout << endl;

    for (auto &i : v)
        i *= i;
    for (auto i : v)
        cout << i << " ";
    cout << endl;

    return 0;
}