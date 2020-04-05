# VerilogHDL 数字设计与综合

## 2. 层次建模的概念

了解设计流程以及 Verilog 对该流程的适应。

+ 数字电路设计的两种方法：自顶向下和自底向上。
+ 模块是 Verilog 中的基本功能单元。模块通过调用实例引用来使用，每个实例都被视为唯一标识，以区别同一模块的其他实例。
+ 仿真的两个组成部分：设计块和激励块，激励块用于测试设计块，且常常是顶层模块。施加激励有两种不同的模式。

### [习题](./chapter2/exercise2.md)

## [3. 基本概念](./chapter3/basic_concepts.md/#基本概念)

### 词法约定：

+ 参考 C 语言，对空白的要求类似，注释方法相同。
+ [数字声明](./chapter3/basic_concepts.md/#数字声明)：指明位数的数字和不指明位数的数字。

### [数据类型](./chapter3/basic_concepts.md/#数据类型)

### 系统任务和编译指令

显示信息：`$display(p1, p2)`，类似 printf。

监视信息：`$monitor(p1, p2)`。只需调用一次。

暂停和结束：`stop` 和 `finish`。

编译指令：『`define』，类似 C 中的 #define，用于定义常量。
『`include』类似 C 中的 #include，用于引用文件。

### [习题](./chapter3/exercise3.md)
