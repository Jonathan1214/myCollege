#include <iostream>

int main()
{
    int sum = 0, value = 0;
    // 读取数据直到文件结尾，计算和
    while (std::cin >> value)
        sum += value;
    std::cout << "Sum is: " << sum << std::endl;
    
    return 0;
}