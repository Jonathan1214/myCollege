#include <iostream>
int main()
{
    using namespace std;
    const int Arsize = 20;
    char name[Arsize];
    char dessert[Arsize];

    cout << "Enter your name:\n";
    cin.getline(name, Arsize);                  // read through newlines
    /*
    * 注意和 get 的区别 但二者都可以连续调用 cin.get(name,size).get().get(name,size)
    * get() 更容易检查出错误
    * cin 直接读取输入保留 \0 在输入流中
    */
    cout << "Enter your favorite dessert:\n";
    cin.getline(dessert, Arsize);
    cout << "I have some delicious " << dessert;
    cout << " for you, " << name << ".\n";
    cin.get();
    return 0;
}