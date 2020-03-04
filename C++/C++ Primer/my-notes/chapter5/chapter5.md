# 第五章 语句

[返回总目录](../../README.md)

+ [5.1 简单语句](#5.1-简单语句)
+ [5.2 语句作用域](#5.2-语句作用域)
+ [5.3 条件语句](#5.3-条件语句)
+ [5.4 迭代语句](#5.4-迭代语句)
+ [5.5 跳转语句](#5.5-跳转语句)
+ [5.6 try 语句块和异常处理](#5.6-try-语句块和异常处理)

## 5.1 简单语句

## 5.2 语句作用域

## 5.3 条件语句

## 5.4 迭代语句

## 5.5 跳转语句

## 5.6 try 语句块和异常处理

异常处理：

+ throw 表达式
+ try 语句块
+ 一套异常类

### 5.6.1 throw 表达式

使用 throw 表达式引发一个异常。throw + 表达式，表达式的类型为抛出的异常类型。

### 5.6.2 try 语句块

通用语法形式：

```C++
try {
    program-statements
} catch (exception-declaration) {
    handle-statements
} catch (exception-declaration) {
    handle-statements
} // ...
```

#### 编写处理代码

#### 函数在寻找处理代码的过程中退出

### 5.6.3 标准异常

C++ 标准库中定义的一组类，与异常处理相关，分别在四个头文件中：

+ exception 定义了最通用的异常类 exception，只报告异常的发生，不提供额外信息。
+ stdexcept 定义了几种常用的异常类。
+ new 定义了 bad_alloc 异常类型。
+ type_info 定义了 bad_cast 异常类型。

<stdexcept\>定义的异常类
| 异常名 | 说明 |
| :---- | :---- |
| exception | 最常见的问题 |
| runtime_error | 只有在运行时才能检测出的问题 |
| range_error | 运行时有错，生成的结果超出了有意义的值域范围 |
| overflow_error | 运行时错误：计算上溢 |
| underflow_error | 运行时错误：计算下溢 |
| logic_error | 程序逻辑错误 |
| domain_error | 逻辑错误：参数对应的结果值不存在 |
| invalid_argument |逻辑错误：无效参数 |
| length_error | 逻辑错误：试图创建一个超出该类型最大长度的对象 |
| out_of_range | 逻辑错误：使用一个超出有效范围的值 |

标准库异常类只定义了几种运算：创建或拷贝异常类型的对象，为异常类型的对象赋值。

只能以默认初始化的方式初始化 exception、bad_alloc 和 bad_cast 对象，不允许提供初始值。

其他类型的异常对象必须使用 string 类型对象或 C 风格字符串初始化。

异常类型只定义了名为 what 的成员函数，无参数，返回一个指向 C 风格的字符串。
