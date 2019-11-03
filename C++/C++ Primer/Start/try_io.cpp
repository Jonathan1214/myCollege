#include <iostream>
int main()
{
    std::cout << "Enter two numbers: "<< std::endl;
    int v1 = 0, v2 = 0;
    std::cin >> v1 >> v2;
    std::cout << "The sum of " << v1 << " and " << v2
            << " is " << v1+v2 << std::endl;
    std::cout << "The multipulation of " << v1 << " and " << v2
            << " is " << v1 * v2 << std::endl;
    std::cout << "Hello World" << std::endl;
    
    std::cout << "/*";
    std::cout << "*/";
    std::cout << "OK";
    return 0;
}