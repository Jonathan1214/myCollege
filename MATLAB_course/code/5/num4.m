%求pi的近似值 使用级数求和
%向量运算
n=input('输入阶数');
i=1:n;
f=1./i.^2;
y=sum(f);
Pi=sqrt(6*y);
disp(Pi);