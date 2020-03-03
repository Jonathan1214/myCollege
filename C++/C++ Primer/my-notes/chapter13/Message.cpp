#include "Message.hh"

void Message::save(Folder &f)
{
    folders.insert(&f);     // 添加到 folders 中
    f.addMsg(this);
}

void Message::remove(Folder &f)
{
    folders.erase(&f);
    f.removeMsg(this);
}

void Message::add_to_Folders(const Message &m)
{
    for (auto f : m.folders)    // 对每一个包含 m 的 Folder
        f->addMsg(this);        // 向其中添加一个指向本 Message 的指针
}

// 拷贝构造函数
Message::Message(const Message &m):
    contents(m.contents), folders(m.folders)
{
    add_to_Folders(m);
}

void Message::remove_from_Folders()
{
    for (auto f : folders)
        f->removeMsg(this);
}

// 析构函数
Message::~Message()
{
    remove_from_Folders();
}

Message& Message::operator=(const Message &rhs)
{
    remove_from_Folders();  // 更新已有 Folder
    contents = rhs.contents;
    folders = rhs.folders;
    add_to_Folders(rhs);
    return *this;
}

void swap(Message &lhs, Message &rhs)
{
    using std::swap;
    for (auto f: lhs.folders)
        f->removeMsg(&rhs);
    for (auto f: rhs.folders)
        f->removeMsg(&lhs);
    swap(lhs.folders, rhs.folders);
    swap(lhs.contents, rhs.contents);

    for (auto f: lhs.folders)
        f->addMsg(&lhs);
    for (auto f: rhs.folders)
        f->addMsg(&rhs);
}

// 拷贝构造
Folder::Folder(const Folder &f):
    foldername(f.foldername), msgs(f.msgs)
{
    // 向 msgs 中的每一个 msg 的 folders 添加本 folder
    for (auto m : msgs)
        m->save(*this);
}

// 从所有的 Message 中删除当前 Folder
void Folder::rmv_in_messgae()
{
    for (auto m : msgs)
        m->remove(*this);
}

void Folder::add_in_message(const Folder &f)
{
    for (auto m : f.msgs)
        m->save(*this);
}

// 赋值运算符
// 操作与 Message 类似
Folder&
Folder::operator=(const Folder &f)
{
    rmv_in_messgae();
    foldername = f.foldername;
    msgs = f.msgs;
    add_in_message(*this);
    return *this;
}


Folder::~Folder()
{
    rmv_in_messgae();
}

Folder&
Folder::addMsg(Message *m)
{
    msgs.insert(m);
    return *this;
}

Folder&
Folder::removeMsg(Message *m)
{
    msgs.erase(m);
    return *this;
}