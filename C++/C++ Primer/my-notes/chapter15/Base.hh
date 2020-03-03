#ifndef _BASE_
#define _BASE_

class Base
{
public:
    virtual int fcn();
};

class D1 : public Base
{
public:
    int fcn(int);
    virtual void f2();
};

class D2 : public D1
{
public:
    int fcn(int);
    int fcn();
    void f2();
};


#endif