#include "Quote.hh"

/* class
*       Quote
*/
Quote& Quote::operator=(const Quote& q)
{
    bookNo = q.bookNo;
    price = q.price;
    return *this;
}


/* class
*       Disc_quote
*/
Disc_quote& Disc_quote::operator=(const Disc_quote& dq)
{
    Quote::operator=(dq);   // 调用基类的赋值运算符
    quantity = dq.quantity;
    discount = dq.discount;
    return *this;
}


/* class
*       Bulk_quote
*/
Bulk_quote& Bulk_quote::operator=(const Bulk_quote& bq)
{
    Disc_quote::operator=(bq);
    min_qty = bq.min_qty;
    discount = bq.discount;
    return *this;
}