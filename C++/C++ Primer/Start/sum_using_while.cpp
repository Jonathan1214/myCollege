#include <iostream>

int main()
{
    int sum = 0, val = 1;
    
    while (val <= 10) {
        sum += val;
        ++val; // 等价于 val = value + 1；
    }
    std::cout << "Sum of 1 to 10 is "
              << sum << std::endl;
              
    
    // practice 1
    sum = 0;
    val = 50;
    while (val <= 100) {
        sum += val;
        ++val;
    }
    std::cout << "Sum of 50 to 100 is "
              << sum << std::endl;
    
    
    // practice 2
    int start = 10;
    while (start > 0) {
        std::cout << start << " ";
        --start;
    }
    std::cout << std::endl;
    
    // practice 3
    std::cout << "Enter two integers then print all numbers "
              << " between them: " << std::endl;
    int v1 = 0, v2 = 0, tmp = 0;
    std::cin >> v1 >> v2;
    // 确认 v1<v2 否则交换值
    if (v1 > v2) {
        tmp = v1;
        v1 = v2;
        v2 = tmp;
    }
    tmp = v1;
    while (tmp <=v2 ) {
        std::cout << tmp << " ";
        ++tmp;
    }
    std::cout << std::endl;
        
    return 0;
}