#include <fstream>
#include <iostream>
#include <string>
#include <vector>
using std::ifstream;
using std::ofstream;
using std::string;
using std::vector;

int main(int argc, char const *argv[])
{
    string ifile{"test.txt"};
    string tmp;
    vector<string> sV;
    ifstream in(ifile);
    // while (getline(in, tmp))
    //     sV.push_back(tmp);
    while (in >> tmp)
        sV.push_back(tmp);

    in.close();
    for (auto s : sV)
        std::cout << s << std::endl;
    return 0;
}
