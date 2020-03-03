#ifndef MESSAGE_HH
#define MESSAGE_HH
#include <string>
#include <set>

class Folder;

class Message
{
    friend class Folder;
    friend void swap(Message&, Message&);
public:
    explicit Message(const std::string &str = ""):
        contents(str) { }
    // 拷贝控制成员
    Message(const Message&);            // 拷贝构造函数
    Message& operator=(const Message&); // 拷贝赋值运算符
    ~Message();                         // 析构函数
    void save(Folder&);
    void remove(Folder&);

private:
    std::string contents;               // 实际消息文本
    std::set<Folder*> folders;          // 包含本 Message 的 Folders
    // 工具函数
    void add_to_Folders(const Message&);
    void remove_from_Folders();
};

void swap(Message&, Message&);

class Folder
{
public:
    // set 默认初始化为空
    Folder(const std::string name = "a_folder"):
        foldername(name) { }

    // 拷贝控制成员
    Folder(const Folder&);  // 构造
    Folder& operator=(const Folder&);   // 赋值运算符
    ~Folder();              // 析构

    Folder& addMsg(Message*);     // 添加信息
    Folder& removeMsg(Message*);  // 删除信息
private:
    std::string foldername;
    std::set<Message*> msgs;            // 包含的 message
    void rmv_in_messgae();
    void add_in_message(const Folder&);
};

#endif