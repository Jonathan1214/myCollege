
### 基本概念

1. vector表示对象的集合，其中所有对象的类型都相同，集合中的每个对象都有一个与之对应的索引，索引用于访问对象，也常被称作容器（container），vector 是一个类模板

2. vector 是模板而非类型，由 vector 生成的类型必须包含 vector 中元素的类型，如 vector<int>

3. 在比较老C++标准中，如果vector中的元素还是vector的话，必须在外层vector的对象的右尖括号和其元素类型之间添加一个空格，如：
    vector<vector<int> >

### 定义和初始化
常用方法：
    1. vector<T> v1             默认初始化
    2. vector<T> v2(v1)         v2中包含v1中所有元素的副本
    3. vector<T> v2 = v1        v2(v1)
    4. vector<T> v3(n, val)     v3中包含n个重复的元素，每个元素的值都是val
    5. vector<T> v4<n>          v4包含n个重复地执行了值初始化的对象
    6. vector<T> v5{a,b,c...}
    7. vector<T> v5 = {a,b,c...}

方式1 为值初始化，如果没有指定初始值，则按照类明确提供发初始值进行初始化
time: 2019.5.15 12:37

基本操作：
    1. v.empty()
    2. v.size()         返回值类型是由vector定义的size_type类型
    3. v.push_back(t)
    4. v[n]
    5. v1 = v2
    6. v1 = {a,b,c...}
    7. v1 == v2
    8. v1 != v2
    9. <, <=, >, >=

