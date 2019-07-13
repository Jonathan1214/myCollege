%求两位数中的绝对素数
%即交换十位和个位之后该数仍然是素数
%matlab中已经有求素数的函数了 很方便 这个题目也没有什么难的了
p=[];
m=1;
for i=10:99
    if isprime(i)
        a=fix(i/10);
        b=rem(i,10);
        tmp=b*10+a;
        if isprime(tmp)
            p(m)=i;
            m=m+1;
        end
    end
end
disp(p')