#include "Employee.hh"

// 拷贝构造函数
Employee::Employee(const Employee& e)
{
    name = e.name;
    id = count;
    count++;
}

// 拷贝赋值运算符
Employee&
Employee::operator=(const Employee& e)
{
    name = e.name;
    id = count;
    count++;
    return *this;
}