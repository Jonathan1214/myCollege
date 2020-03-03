#ifndef PERSON_QUIZ7_4_HH
#define PERSON_QUIZ7_4_HH
#include <string>
#include <istream>

struct Person_quiz7_4
{
    friend std::istream &read(std::istream &, Person_quiz7_4 &);
    friend std::ostream &print(std::ostream &, const Person_quiz7_4 &);

public:
    Person_quiz7_4() = default;
    Person_quiz7_4(const std::string &n, const std::string &a) :
                   name(n), address(a) {}
    Person_quiz7_4(std::istream &is) { read(is, *this); }

    std::string get_name() const { return name; }
    std::string get_address() const { return address; }
    // 这里为何要声明为 const
    // 不能用 常量对象调用非常量成员函数
    // 但这两个函数应该可以被所有的对象调用，而且这些对象往往都是常量对象
    // 且我们不应该在函数内对 成员 进行修改
private:
    std::string name;
    std::string address;
};

std::istream &read(std::istream &is, Person_quiz7_4 &person) {
    is >> person.name >> person.address;
    return is;
}

std::ostream &print(std::ostream &os, const Person_quiz7_4 &person) {
    os << person.name << " : " << person.address;
    return os;
}

#endif