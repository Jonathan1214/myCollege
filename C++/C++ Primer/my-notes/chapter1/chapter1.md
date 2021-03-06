# 第一章 开始

[返回总目录](../../README.md)

+ [1.1 编写一个简单的 C++ 程序](#1.1-编写一个简单的-C++-程序)
+ [1.2 初识输入输出](#1.2-初识输入输出)
+ [1.3 注释简介](#1.3-注释简介)
+ [1.4 控制流](#1.4-控制流)
+ [1.5 类简介](#1.5-类简介)
+ [1.6 书店程序](#1.6-书店程序)


## 1.1 编写一个简单的 C++ 程序

## 1.2 初识输入和输出

C++ 语言没有定义任何输入输出（IO）语句，而是使用一个全面的 **标准库** 来提供 IO 机制。

**iostream** 库中包含了两个基础类型 istream 和 ostream，分别表示输入和输出流，一个流就是一个字符序列。

标准库定义了 4 个 IO 对象。

> 1. 名为 **cin** 的 istream 类型对象，也被称为 **标准输入**；
> 2. 名为 **cout** 的 ostream 类型对象，也被称为 **标准输出**；
> 3. 名为 **cerr** 的 ostream 类型对象，用来输出警告和错误信息；
> 4. 名为 **clog** 的 ostream 类型对象，用来输出程序运行时的一般性信息。

### 运算符

+ 输入运算符 >>
+ 输出运算符 <<
+ 作用域运算符 ::

### 使用标准库中的名字

前缀 `std::` 指出名字 cout 和 cin 和 endl 是定义在 **std** 的 **命名空间**（namespace）中的。命名空间可以帮我们避免不经意的名字定义冲突，以及使用库中相同名字导致的冲突。标准库定义的所有名字都在命名空间 std 中。

当使用标准库中的名字，必须显示说明我们想使用来自命名空间 std 中的名字。如 `std::cout`，通过使用 **作用域运算符**（::）指出我们想使用定义在命名空间 std 中的 cout。

## 1.3 注释简介

### 分类

分为单行注释和界定符注释。

> 单行注释：//
> 界定符注释：/* */

### 注释界定符不能嵌套

## 1.4控制流

程序设计语言提供了多种不同的控制流语句，允许我们写出更为复杂的执行路径。

### 1.4.1 while 语句

**while语句** 反复执行一段代码，直到给定条件为假为止。

### 1.4.2 for 语句

for 语句包含两个部分：循环头和循环体。循环头控制循环体的执行次数，由三部分组成：一个初始化语句、一个循环条件以及一个表达式组成。

### 1.4.3 读取数量不定的输入数据

```C++
    int val;
    while (std::cin >> val)
        ;
```

### 1.4.4 if 语句

## 1.5 类简介

在 C++ 中，通过定义一个 **类**（class） 来定义自己的数据结构。一个类定义了一个类型，以及与其关联的一组操作。

了解三个问题：

+ 类名是什么？
+ 它在哪里被定义的？
+ 它支持什么操作？

### 1.5.2 初识成员函数
