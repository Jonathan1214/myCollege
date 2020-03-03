#ifndef TREENODE
#define TREENODE
#include <string>

class TreeNode
{
public:
    // 构造函数
    TreeNode(): value(std::string()), count(1), left(nullptr), right(nullptr) { };
    TreeNode(const std::string &s):
        value(s), count(1), left(nullptr), right(nullptr) { }
    TreeNode(const TreeNode &le, const TreeNode &rg):
        count(1), left(new TreeNode(le)), right(new TreeNode(rg)) { }
    TreeNode(const std::string &s, const int &c, const TreeNode &le, const TreeNode &rg):
        value(s), count(c), left(new TreeNode(le)), right(new TreeNode(rg)) { }
    // 是否需要自定义的拷贝操作 取决于合成拷贝操作是否满足要求
    // 这里最好让类有值的性质 主要牵扯到内置指针
    // 拷贝构造函数 与默认的相同 这样一来不就变成了类指针了 所以 count 是引用计数
    TreeNode(const TreeNode &t):
        value(t.value), count(t.count), left(t.left), right(t.right) { };
    // 拷贝赋值运算符
    TreeNode &operator=(const TreeNode &t);
    // 析构函数
    ~TreeNode() { delete left; delete right; };

// 返回值
    std::string getValue() const { return value; }
    int getCount() const { return count; }
// 设置结点值
    // 设置 value 和 count
    TreeNode &setValue(const std::string &v) { value = v; return *this; }
    TreeNode &setCount(const int &c) { count = c; return *this; }

    // 设置孩子
    TreeNode &setLeftChild(const TreeNode &t) { *left = t; return *this; }
    TreeNode &setRightChild(const TreeNode &t) { *right = t; return *this; }
    TreeNode &setChild(const TreeNode &le, const TreeNode &rg)
        { *left = le; *right = rg; return *this; }
private:
    std::string value;
    int count;
    TreeNode *left;
    TreeNode *right;
};

#endif