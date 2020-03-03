#ifndef EMPLOYEE_HH
#define EMPLOYEE_HH
#include <string>
class Employee
{
    Employee(const std::string &s): name(s), id(count) { count++; };       // 构造函数
    Employee(const Employee&);                                                            // 如果需要拷贝的话 那么允许相同名字 不同编号
    Employee &operator=(const Employee&);   // 拷贝赋值运算符 只拷贝名字 同时递增 id
private:
    std::string name;
    int id;
    static int count;
};

int Employee::count = 1;

#endif