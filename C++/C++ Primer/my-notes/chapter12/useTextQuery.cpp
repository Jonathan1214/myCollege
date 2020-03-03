#include "TextQuery.hh"

void runQuery(std::ifstream &infile)
{
    TextQuery tq(infile);   // 保存文件并建立查询 map

    while (true)
    {
        std::cout << "enter word to look for, or q to quit: ";
        std::string s;
        if (!(std::cin >> s) || s == "q") break;
        print(std::cout, tq.query(s)) << std::endl;
    }
}

int main(int argc, char const *argv[])
{
    std::ifstream infile("test.txt");
    runQuery(infile);
    return 0;
}
