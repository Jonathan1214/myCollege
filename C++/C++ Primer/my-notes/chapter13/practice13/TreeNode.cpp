#include "TreeNode.hh"
// 拷贝赋值运算符
TreeNode&
TreeNode::operator=(const TreeNode &t)
{
    auto le = t.left, rg= t.right;
    delete left;
    delete right;
    left = le;
    right = rg;
    value = t.value;
    count = t.count;
    return *this;
}