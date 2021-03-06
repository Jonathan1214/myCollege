# 第四章 表达式

[返回总目录](../../README.md)

+ [4.1 基础](#4.1-基础)
+ [4.2 算术运算符](#4.2-算术运算符)
+ [4.3 逻辑和关系运算符](#4.3-逻辑和关系运算符)
+ [4.4 赋值运算符](#4.4-赋值运算符)
+ [4.5 递增和递减运算符](#4.5-递增和递减运算符)
+ [4.6 成员访问运算符](#4.6-成员访问运算符)
+ [4.7 条件运算符](#4.7-条件运算符)
+ [4.8 位运算符](#4.8-位运算符)
+ [4.9 sizeof 运算符](#4.9-sizeof-运算符)
+ [4.10 逗号运算符](#4.10-逗号运算符)
+ [4.11 类型转换](#4.11-类型转换)
+ [4.12 运算符优先级](#4.12-运算符优先级)

## 4.1 基础

### 4.1.1 基本概念

#### 组合运算符和运算对象

#### 运算对象转换

#### 重载运算符

#### 左值和右值

+ 当一个对象被用作右值时，用的是对象的值（内容）。
+ 当一个对象被用作左值时，用的是对象的身份（在内存中的位置）。

如果表达式的结果是左值，decltype 作用于该表达式时得到一个引用类型。

### 4.1.2 优先级和结合律

**复合表达式** 是指含有两个或多个运算符的表达式。

#### 括号无视优先级与结合律

#### 优先级与结合律有何影响

### 4.1.3 求值顺序

多数情况下，不会明确指定求值的顺序。

#### 求值顺序、优先级、结合律

运算对象的求值顺序与优先级和结合律无关。

## 4.2 算术运算符

## 4.3 逻辑和关系运算符

除逻辑非为右结合，其余均为左结合。

### 逻辑与和逻辑非

**短路求值** 策略。

### 逻辑非

### 关系运算符

不能连写在一起。

### 相等性测试与布尔字面值

进行比较运算时除非比较的对象是布尔类型，否则不要使用布尔字面值 true 或 false 作为运算对象。

## 4.4 赋值运算符

### 赋值运算符满足右结合律

### 赋值运算优先级较低

### 切勿混淆相等运算符和赋值运算符

### 复合赋值运算符

## 4.5 递增和递减运算符

这种操作对迭代器来说是必须的。

注意：++ 或 -- 在元的前后的区别。

### 在一条语句中混用解引用和递增运算符

### 运算对象可按任意顺序求值

## 4.6 成员访问运算符

点运算符和箭头运算符。

## 4.7 条件运算符

条件运算符（?:）允许我们把简单 if-else 逻辑嵌入到单个表达式中。

### 嵌套条件运算符

### 在输出表达式使用条件运算符

## 4.8 位运算符

## 4.9 sizeof 运算符

返回一条表达式或类型所占的字节数，满足右结合律，所得结果为 size_t 类型的常量表达式。

sizeof 不会求运算对象的值。

sizeof 运算符的结果部分地依赖于其作用的类型。

## 4.10 逗号运算符

## 4.11 类型转换

如果两种类型可以 **相互转换**，那么它们就是关联的。

注意 **隐式转换** 的存在。

### 何时发生隐式类型转换

### 4.11.1 算术转换

#### 整型提升

#### 无符号类型的运算对象

#### 理解算术转换

### 4.11.2 其他隐式类型转换

+ 数组转换成指针
+ 指针的转换
+ 转换成布尔型
+ 转换成常量
+ 类类型定义的转换

### 4.11.3 显示转换

**强制类型转换**（cast）。

#### 命名的强制类型转换

格式：cast_name<type\>(expression)。cast_name 取值如下表，type 为要转换成的目标类型，expression 是要转换的值。

+ static_cast：任何具有明确定义的类型转换，只要不包含底层 const，都可使用。
+ dynamic_cast
+ const_cast：只能改变运算对象的底层 const。
+ reinterpret_cast：为运算对象的位模式提供较低层次上的重新解释。

## 4.12 运算符优先级
