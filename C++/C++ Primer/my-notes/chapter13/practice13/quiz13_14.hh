#ifndef QUIZ13_14_HH
#define QUIZ13_14_HH
#include <iostream>

class Numbered
{
    friend void f(const Numbered &);
public:
    Numbered(): mysn(count) { count++; };     // 重载默认构造函数
    Numbered(const Numbered&);                // 拷贝构造函数
private:
    int mysn;   // 唯一的序号，每个对象一个
    static int count;   // 静态编号
};

int Numbered::count = 1;    // 定义 static 成员

// 拷贝构造函数定义
Numbered::Numbered(const Numbered &num)
{
    mysn = count;
    count++;
}


void f(const Numbered &s)
{
    std::cout << s.mysn << std::endl;
}

#endif