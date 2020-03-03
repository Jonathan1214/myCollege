#ifndef SCREEN_HH
#define SCREEN_HH
#include <iostream>
#include <string>

class Screen
{
public:
    friend class Window_mgr;
    // friend void Window_mgr::clear(ScreenIndex);
    typedef std::string::size_type pos;
    Screen() = default;

    // Screen(pos ht, pos wd, char c): height(ht), width(wd),
    //         contents(ht * wd, c) { }
    Screen(pos ht, pos wd, char c): height(ht), width(wd),
                                contents(ht * wd, c) { }
    char get() const
        { return contents[cursor]; }         // 隐式内联
    inline char get(pos r, pos c) const;  // 显式内联
    Screen &move(pos r, pos c);

    Screen &set(char);
    Screen &set(pos, pos, char);

    Screen &display(std::ostream &os)
                    { do_display(os); return *this; }
    const Screen &display(std::ostream &os) const
                    { do_display(os); return *this; }
                    // 声明函数为 const 且返回 *this 则返回类型必须也有 const

    pos size() const
        { return height * width; }

    void some_member() const;

private:
    void do_display(std::ostream &os) const { os << contents ; }

    pos cursor = 0;
    pos height = 0, width = 0;
    std::string contents;

    mutable size_t access_ctr;              // 声明为 mutabel 在 const 成员函数中也能修改其值
};

inline
Screen &Screen::set(char c) {
    contents[cursor] = c;
    return *this;
}

inline
Screen &Screen::set(pos r, pos col, char ch) {
    contents[r*width + col] = ch;
    return *this;
}

inline
Screen &Screen::move(pos r, pos c) {
    pos row = r * width;    // 计算行的位置
    cursor = row + c;       // 在行内将光标移到指定列
    return *this;           // 左值形式返回对象
}

char Screen::get(pos r, pos c) const {
    pos row = r * width;        // 计算行的位置
    return contents[row + c];   // 返回给定列的字符
}

void Screen::some_member() const {
    ++access_ctr;
}

#endif