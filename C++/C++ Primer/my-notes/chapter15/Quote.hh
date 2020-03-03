#ifndef _QUOTE_HH_
#define _QUOTE_HH_
#include <string>

class Quote
{
public:
    Quote() = default;
    // 构造函数
    Quote(const std::string &book, double sales_price):
        bookNo(book), price(sales_price) { }
    // 拷贝构造函数
    Quote(const Quote& q): bookNo(q.bookNo), price(q.price) { };
    // 拷贝赋值
    Quote& operator=(const Quote&);
    std::string isbn() const { return bookNo; }
    virtual double net_price(std::size_t n) const
        { return n * price; }
    virtual ~Quote() = default; // 对析构函数进行动态绑定
private:
    std::string bookNo;
protected:
    double price = 0.0; // 不打折的价格
};

// 抽象基类
class Disc_quote : public Quote
{
public:
    Disc_quote() = default;
    Disc_quote(const std::string &book, double price,
                std::size_t qty, double disc):
                Quote(book, price), quantity(qty), discount(disc) { }
    // 拷贝构造函数
    Disc_quote(const Disc_quote& dq):
                Quote(dq), quantity(dq.quantity), discount(dq.discount) { };
    // 拷贝赋值
    Disc_quote& operator=(const Disc_quote&);
    ~Disc_quote() = default;
    // 声明为纯虚函数
    double net_price(std::size_t) const = 0;
protected:
    std::size_t quantity = 0;   // 折扣适用的购买量
    double discount = 0.0;      // 折扣
};

class Bulk_quote : public Disc_quote
{
public:
    Bulk_quote() = default;
    Bulk_quote(const std::string &book, double p, std::size_t qty, double disc):
        Disc_quote(book, p, qty, disc) { };
    Bulk_quote(const Bulk_quote& bq):
        Disc_quote(bq), min_qty(bq.min_qty), discount(bq.discount) { }
    Bulk_quote& operator=(const Bulk_quote&);
    // override 基类版本
    double net_price(std::size_t) const override;
private:
    std::size_t min_qty = 0;    // 适用于折扣的最低购买量
    double discount = 0.0;      // 折扣额
};

double
Bulk_quote::net_price(std::size_t n) const
{
    if (n > min_qty)
        return n * (1 - discount) * price;
    else
        return n * price;
}

#endif