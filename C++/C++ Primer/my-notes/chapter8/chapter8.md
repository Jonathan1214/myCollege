# 第八章 IO 库

+ [8.1 IO 类](#8.1-IO-类)
+ [8.2 文件输入输出](#8.2-文件输入输出)
+ [8.3 string 流](#8.3-string-流)

## 8.1 IO 类

IO 库类型和头文件
| 头文件 | 类型 |
| :---- | :---- |
| iostream | istream, wistream 从流中读取数据 ostream, wostream 向流中写入数据 iostream, wiostream 读写流 |
| fstream | ifstream, wifstream 从文件中读数据 ofstream, wofstream 向文件中写数据 fstream, wfstream 读写文件 |
| sstream | istringstream, wistringstream 从 string 读取数据 ostringstream, wostringstream 向 string 写数据 stringstream, wstringstream 读写 string |

为支持使用宽字符的语言，标准库定义了一组类型和对象来操纵 wchar_t 类型的数据。宽字符版本的类型和函数以 w 开始。如上表中，所有 w 开头的类型为宽字符版本的。

### IO 类型间的关系

继承机制。

### 8.1.1 IO 对象无拷贝或赋值

### 8.1.2 条件状态

如下列出来 IO 类说定义的一些函数和标志，帮助我们访问和操纵流的条件状态。

IO 库的条件状态：
| 语句 | 解释 |
| :---- | :---- |
| *strm*::iostate | *strm* 是一种 IO 类型（在上表列出），iostate 是机器相关的类型，提供了表达条件状态的完整功能 |
| *strm*::badbit | 指出流已崩溃 |
| *strm*::failbit | 指出 IO 操作失败 |
| *strm*::eofbit | 指出流到达了文件结束 |
| *strm*::goodbit | 指出流未处于错误状态。此值保证为 0 |
| s.eof() | 若流 s 的 eofbit 置位，则返回 true |
| s.fail() | failbit 或 badbit 置位，返回 true |
| s.bad() | badbit 置位，返回 true |
| s.good() | 处于有效状态，返回 true |
| s.clear() | 将 s 中所有条件状态复位，将流的状态设置为有效，返回 void |
| s.clear(flags) | 根据给定的 flags 标志位，将 s 对应的条件状态复位。flag 类型为 *strm*::iostate，返回 void |
| s.setstate(flags) | 同上，但为置位 |
| s.rdstate() | 返回流当前的条件状态，返回值类型为 *strm*::iostate |

#### 查询流的状态

将流当作条件使用，只能得知流是否有效。

IO 库提供了一个与机器无关的 iostate 类型，提供了表达流状态的完整功能。这个类型为位集合。

#### 管理条件状态

### 8.1.3 管理输出缓冲

每个输出流都管理一个缓冲区，用来保存程序读写的数据。

导致缓冲区刷新（即将数据真正写到输出设备或文件）的原因很多：

+ 程序正常结束。
+ 缓冲区满。
+ endl 显示刷新。
+ unitbuf 设置流的状态，清空缓冲区。默认时，对 cerr 是设置 unitbuf 的。
+ 一个输出流被关联到另一个流。如默认 cin 和 cerr 都关联到 cout，故读 cin 或写 cerr 都会导致刷新。

#### 刷新输出缓冲区

+ endl 添加换行符 刷新
+ flush 直接刷新
+ ends 添加空字符 刷新

#### unitbuf 操纵符

添加 `cout << unitbuf;` 每次立即刷新。使用 `cout << nounitbuf` 取消这操作。

**警告**：如果程序崩溃，输出缓冲区不会被刷新。

#### 关联输入和输出流

任何试图从输入流读取数据的操作都会先刷新关联的输出流。

交互式系统通常应该关联输入流和输出流。

## 8.2 文件输入输出

头文件 fstream 定义了三个类型来支持文件 IO。

+ ifstream 读文件
+ ofstream 写文件
+ fstream 读写文件

除继承自 iostream 类型的行为外，fstream 还添加了新的行为，这是 fstream 独有的。
| 语法 | 说明 |
| :---- | :---- |
| *fstream* fstrm; | 创建一个未绑定的文件流，fstrm 是头文件 fstream 定义的一个类型 |
| *fstream* fstrm(s); | 创建一个 *fstream*，打开名为 s 的文件，s 可以是 string 类型，也可是 C 风格字符串 |
| *fstream* fstrm(s, mode) | 同上，但指定模式 |
| fstrm.open(s) | 打开文件 s，默认 mode 依赖于 fstrm 的类型 |
| fstrm.close() | 关闭文件 |
| fstrm.is_open() | 返回 bool 值，指出关联的文件是否成功打开且未关闭 |

### 8.2.1 使用文件对象流

```C++
    ifstream in(ifile);
    ofstream out;
```

#### 用 fstream 代替 iostream&

完全可替代。

#### 成员函数 open 和 close

对一个已经打开的文件流调用 open 会失败，且会导致 failbit 置位，进而导致后面的操作全部失效。

#### 自动构造和析构

当一个 fstream 对象离开其作用域时，与之关联的文件会自动关闭。

### 8.2.2 文件模式

每一个流都有关联的 **文件模式**，指出如何使用文件。

文件模式：
| 名 | 说明 |
| :---- | :---- |
| in | 只读 |
| out | 写 |
| app | 写，但从文件末尾开始 |
| ate | 打开文件立即定位到文件末尾 |
| trunc | 截断文件 |
| binary | 以二进制方式进行 IO |

#### 以 out 模式打开文件会丢弃原有数据

## 8.3 string 流

sstream 头文件定义了三个类型来支持内存 IO，这种类型可以向 string 写入数据，从 string 读取数据。

**istringstream** 从 string 读取数据，**ostringstream** 向 string 写入数据。stringstream 既可写也可读。

stringstream 特有操作：
| 语法 | 说明 |
| :---- | :---- |
| sstream: strm; | 未绑定的 stringstream 对象 |
| sstream: strm(s); | strm 是 sstream 对象，保存 string s 的拷贝，构造函数 explicit |
| strm.str() | 返回 strm 保存的 string 拷贝 |
| strm.str(s) | 将 string s 拷贝到 strm 中，返回 void |

### 8.3.1 使用 istringstream

当我们的某些工作是对整行文本进行处理，而其他一些工作是处理行内的单个单词时，通常可使用 istringstream。

### 8.3.2 使用 ostringstream

当我们逐步构造输出，希望最后一期打印时，ostringstream 很有用。
