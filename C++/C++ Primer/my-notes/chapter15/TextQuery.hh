#ifndef TEXTQUERY_HH
#define TEXTQUERY_HH
#include <fstream>
#include <iostream>
#include <string>
#include <vector>
#include <memory>
#include <map>
#include <set>
#include <sstream>

class QueryResult;

class TextQuery
{

public:
    using line_no = std::vector<std::string>::size_type;
    TextQuery(std::ifstream&);
    QueryResult query(const std::string&) const;

private:
    std::shared_ptr<std::vector<std::string>> file; // 输入文件
    std::map<std::string,
            std::shared_ptr<std::set<line_no>>> wm;// 每个单词到它所在行的映射
};

TextQuery::TextQuery(std::ifstream &is): file(new std::vector<std::string>) // 冒号后的参数是啥意思，动态内存空间 初始化成员
{
    std::string text;
    while (getline(is, text))
    {
        file->push_back(text); // 保存此行文本
        int n = file->size() - 1; // 当前行号
        std::istringstream line(text);  // 将行文本分解为单词
        std::string word;
        while (line >> word)
        {
            auto &lines  = wm[word];
            if (!lines)
                lines.reset(new std::set<line_no>); // 分配一个新的 set
            lines->insert(n);       // 将此行号插入 set 中
        }
    }
}

class QueryResult
{
    friend std::ostream &print(std::ostream&, const QueryResult&);

public:
    using line_no = std::vector<std::string>::size_type;
    QueryResult(std::string s,
                std::shared_ptr<std::set<line_no>> p,
                std::shared_ptr<std::vector<std::string>> f):
            sought(s), lines(p), file(f) { }

private:
    std::string sought; // 查询单词
    std::shared_ptr<std::set<line_no>> lines;    // 出现的行号
    std::shared_ptr<std::vector<std::string>> file; // 输入文件
};

QueryResult
TextQuery::query(const std::string &sought) const
{
    static std::shared_ptr<std::set<line_no>> nodata(new std::set<line_no>);

    auto loc = wm.find(sought);
    if (loc == wm.end())
        return  QueryResult(sought, nodata, file);
    else
        return QueryResult(sought, loc->second, file);
}

std::ostream &print(std::ostream &os, const QueryResult &qr)
{
    os << qr.sought << " occurs " << qr.lines->size() << " "
       << std::endl;

    for (auto num : *qr.lines)
        os << "\t(line " << num + 1 << ") "
           << *(qr.file->begin() + num) << std::endl;
    return os;
}


#endif