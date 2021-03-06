# 第十二章 动态内存

[返回总目录](../../README.md)

+ [12.1 动态内存和智能指针](#12.1-动态内存和智能指针)
+ [12.2 动态数组](#12.2-动态数组)
+ [12.3 使用标准库：文本查询程序](#12.3-使用标准库：文本查询程序)

除静态内存和栈内存，每个程序还拥有一个内存池，这部分内存被称为 **自由空间** 或 **堆**。程序用堆来存储 **动态分配** 的对象。

## 12.1 动态内存和智能指针

在 C++ 中，动态内存管理是通过 **new** 和 **delete** 来实现。前者在动态内存中为对象分配空间并返回指向该对象的指针，可以选择进行初始化。后者接受一个动态对象的指针，销毁该对象，并释放内存。

新标准库提供了两种 **智能指针** 类管理动态对象，自动释放指向的对象。

### 12.1.1 shared_ptr 类

智能指针也是模板，创建智能指针时需指定指向的类型，写在尖括号中，智能指针定义在头文件 memory 中。

shared_ptr 和 unique_ptr 都支持的操作：
| 操作 | 说明 |
| :---- | :---- |
| shared_ptr<T\> sp | 空智能指针，指向类型为 T 的对象 |
| unique_ptr<T\> up | |
| p | 将 p 作条件判断 |
| *p | 解引用 p，获得它指向的对象 |
| p->mem | 等价于 (*p).mem |
| p.get() | 返回 p 中保存的指针 |
| swap(p, q) | 交换 |
| p.swap(q) ||

shared_ptr 独有的操作：
| 操作 | 说明 |
| :---- | :---- |
| make_shared<T\>(args) | 用 args 初始化 |
| shared_ptr<T\> p(q) | 拷贝，会递增 q 中的计数器 |
| p = q ||
| p.unique() | 若 p.use_count() 为 1，返回 true，否则为 false |
| p.use_count() | 返回与 p 共享对象的智能指针数量 |

#### make_shared 函数

定义在头文件 memory 中。

```C++
    shared_ptr<int> p3 = make_shared<int>(42);
    auto p6 = make_shared<vector<string>>();
```

#### shared_ptr 的拷贝与控制

将 shared_ptr 作为参数传给一个函数或者作为函数的返回值，它所关联的计数器就会递增。

一旦一个 shared_ptr 的计数器变为 0，它就会自动释放自己所管理的对象。

#### shared_ptr 自动销毁所管理的对象

通过 **析构函数** 完成销毁工作。

#### shared_ptr 还会自动释放相关联的内存

如果将 shared_ptr 存放于一个容器中，而后不再需要全部元素，而只适用其中的一部分，记得 erase 删除不再需要的那些元素。

#### 使用了动态生存期的资源的类

使用动态内存的原因：

+ 程序不知道自己需要使用多少对象。
+ 程序不知道对象的准确类型。
+ 程序需要在多个对象间共享数据。

#### 定义 StrBlob 类

### 12.1.2 直接管理内存

new 分配内存，delete 释放 new分配的内存。

#### 使用 new 动态分配和初始化对象

在自由空间中分配的内存是无名的，因此 new 无法为其分配的对象命名，而是返回一个指向该对象的指针。

```C++
    int *p = new int;       // 默认初始化 *p 未定义
    int *p3 = new int();    // 值初始化 *p3 = 0
    string *ps = new string;
    int *p2 = new int(42);
    string *ps2 = new string(10, "9");
```

可以进行默认初始化，值初始化和直接初始化。对于内置类型来说，值初始化和默认初始化区别很大。

主动对动态分配的对象进行初始化。

#### 动态分配的 const 对象

```C++
    const int *pci = new const int(1024);
    const string *pcs = new const string;
```

#### 内存耗尽

可能出现内存耗尽情况，此时抛出 bad_alloc 异常，在 new 后面使用 `nothrow` 阻止异常抛出，而是返回空指针。

bad_alloc 和 nothrow 都定义在头文件 new 中。

#### 释放动态内存

使用 delete 表达式。`delete p`。

#### 指针值和 delete

只能 delete 指向动态分配的内存的指针，且指向同一位置的只能 delete 一次，delete 非 new 分配的指针和多次 delete 是未定义的。

#### 动态内存的生存期知道被释放时为止

#### delete 之后的指针值

显然，其值已经无效了，但指针仍然存在，指向的位置不变，称为 **空悬指针**。可以重置指针值为 nullptr。

#### 这只提供了有限的保护

其他指向这个内存位置的指针仍然指向该位置，不会变成 nullptr，仍然有风险。

### 12.1.3 shared_ptr 和 new 配合使用

可以用 new 返回的对象来初始化 shared_ptr。

```C++
    shared_ptr<int> p2(new int(1024));
```

接受指针参数的智能指针构造函数是 explicit 的，因此不能将一个内置指针隐式转换为一个智能指针，必须使用直接初始化形式。

定义和改变 shared_ptr 的其他方法：
| 操作 | 说明 |
| :---- | :---- |
| shared_ptr<T\> p(q) | p 管理内置指针 q 为指向对象 p 必须已经分配好内存 |
| shared_ptr<T\> p(u) | |
| shared_ptr<T\> p(q, d) | d 代替 delete |
| p.reset() ||
| p.reset(q) ||

#### 不要混合使用普通指针和智能指针

#### 不要使用 get 初始化另一个智能指针或为智能指针赋值

### 12.1.4 智能指针和异常

一个简单的确保资源被释放的方法是使用智能指针。

使用智能指针，即使程序块过早的结束，智能指针类也能确保在内存不再需要时将其释放。

#### 智能指针和哑类

并非所有的类都定义了析构函数对资源进行释放，通常是那些兼容 C 的类，需要用户显式释放所使用的资源。

#### 使用我们自己的释放操作

用 shared_ptr 管理类的析构，需要自定义一个函数来代替 delete，这个 删除器 函数必须能够完成对 **shared_ptr** 中保存到指针进行释放的操作。

当我们创建一个 shared_ptr 时，可以创建一个可选的指向删除器函数的指针的参数。

### 12.1.5 unique_ptr

一个 unique_ptr 『拥有』它所指向的对象。定义一个 unique_ptr 时，需要将其绑定到一个 new 返回的指针上，类似 shared_ptr，初始化 unique_ptr 必须使用直接初始化形式。

不支持普通的拷贝和赋值。

### 12.1.6 weak_ptr

不控制所指向对象生存期的智能指针，指向一个由 shared_ptr 管理的对象。将一个 weak_ptr 绑定到一个 shared_ptr 上不会增加其引用计数。

#### 核查指针类

#### 指针操作

## 12.2 动态数组

## 12.3 使用标准库：文本查询程序
