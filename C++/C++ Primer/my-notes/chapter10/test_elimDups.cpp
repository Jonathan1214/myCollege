#include <iostream>
#include "elimDups.hh"


void biggies(std::vector<std::string> &words, std::vector<std::string>::size_type sz);

int main(int argc, char const *argv[])
{
    std::vector<std::string> vS{"hello", "word", "hello", "I", "rule", "rule", "the", "world"};
    for (auto vs : vS)
        std::cout << vs << " ";
    std::cout << std::endl;
    std::cout << "\nSorted and uniqued\n"
              << std::endl;
    // elimDups(vS);
    // std::stable_sort(vS.begin(), vS.end(), isShorter);
    // for (auto vs : vS)
    //     std::cout << vs << " ";
    // std::cout << std::endl;
    biggies(vS, 4);
    return 0;
}

void biggies(std::vector<std::string> &words, std::vector<std::string>::size_type sz)
{
    elimDups(words);
    std::stable_sort(words.begin(), words.end(), isShorter);

    auto wc = std::find_if(words.begin(), words.end(),
                            [sz] (const std::string &a) { return a.size() >= sz; });
    auto count = words.end() - wc;
    std::for_each(wc, words.end(),
                    [] (const std::string &s) { std::cout << s << " ";});
    std::cout << std::endl;
}
