#ifndef HASPTR_HH
#define HASPTR_HH
#include <string>

class HasPtr
{
public:
    friend void swap(HasPtr&, HasPtr&);
    HasPtr(const std::string &s = std::string()):
            ps(new std::string(s)), i(0) { };

    HasPtr(const HasPtr &hptr): ps(new std::string(*hptr.ps)), i(hptr.i) { }    // 拷贝构造函数
    HasPtr& operator=(const HasPtr&);   // 拷贝赋值运算符（函数）
    ~HasPtr() { delete ps; }                       // 析构函数

private:
    std::string *ps;
    int i;
};


// 拷贝赋值函数
HasPtr&
HasPtr::operator=(const HasPtr& hptr)
{
    auto newp = new std::string(*hptr.ps);  // 临时指针 防止自赋值出错
    delete ps;      // 删除原指针   析构
    ps = newp;      // 赋值         拷贝构造
    i = hptr.i;
    return *this;   // 返回本对象
}

void swap(HasPtr &lhs, HasPtr &rhs)
{
    using std::swap;
    swap(lhs.ps, rhs.ps);   // 优先使用类自定义版本 当没有时再使用 using 声明的库版本
    swap(lhs.i, rhs.i);
}

#endif