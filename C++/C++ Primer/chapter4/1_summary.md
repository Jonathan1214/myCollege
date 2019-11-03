1. 注意左值和右值的区别：
    当一个对象被用作右值时，用的是对象的值（内容），当被用作左值时，用的是对象的身份（在内存中的位置）。

2. 重载运算符 <<  >>

3. 优先级和结合律

4. 求值顺序

5. 在除法运算中，如果两个对象的符号相同则商为正，否则为负。
对于求模运算，如m%n，符号与m相同。

6. 举例
```C++
    auto pbeg = v.begin();
    while (pbeg != .den() && *pbeg > 0)
        cout << *pbeg++ << endl; //输出当前值并将pbeg向前移动一个元素
```

7. sizeof运算符
    sizeof (type)
    sizeof expr
    返回值是一个size_t类型的常量表达式

8. 强制类型转换
    cast-name<type>(expression)
    cast-name有这几种：static_cast dynamic_cast const_cast reinterpret_cast