### 两个重要的标准库类型：string vector

    string：可变长的字符序列
    vector：存放某种给定类型对象的可边长序列

### using声明

每个名字都需要独立的using申明

``` C++
#include <iostream>
using std::cin;
using std::cout;
using std::endl;
int main()
{
    return 0;
}
```

但头文件钟不应该包含using申明

### string对象上的操作

1. os<<s    将s写到输出流os钟，返回os
2. is>>s
3. getline(is, s)   从is中读取一行赋值给s，返回is
4. s.empty()
5. s.size()
6. s[n]
7. s1+s2
8. s1=s2
9. s1==s2
10. s1!=s2

注意字符串字面值和string不是一个类型。

我好像忘记加如何初始化string对象的操作了。