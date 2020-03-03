#include "elimDups.hh"

void elimDups(std::vector<std::string> &words)
{
    std::sort(words.begin(), words.end());

    auto end_unique = std::unique(words.begin(), words.end());
    words.erase(end_unique, words.end());
}

bool isShorter(const std::string& s1, const std::string& s2)
{
    return s1.size() < s2.size();
}