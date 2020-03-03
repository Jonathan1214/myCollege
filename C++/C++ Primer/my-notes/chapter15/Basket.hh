#ifndef _BASKET_
#define _BASKET_
#include <iostream>
#include <memory>
#include <set>
#include "Quote.hh"

class Basket
{
public:
    void add_item(const std::shared_ptr<Quote> &sale)
                { items.insert(sale); }
    double total_receipt(std::ostream&) const;
private:
    static bool compare(const std::shared_ptr<Quote> &lhs,
                        const std::shared_ptr<Quote> &rhs)
        { return lhs->isbn() < rhs->isbn(); }

    // multiset 保存多个报价，按照 compare 成员排序
    std::multiset<std::shared_ptr<Quote>, decltype(compare)*>
            items{compare};
};

double Basket::total_receipt(std::ostream &os) const
{
    double sum = 0.0;
    for (auto iter = items.begin();
                iter != items.cend();
                iter = items.upper_bound(*iter)) {
        sum += print_total(os, **iter, items.count(*iter));
    }
    os << "Total Sale: " << sum << std::endl;
    return sum;
}

#endif