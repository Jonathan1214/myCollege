%求pi的近似值 使用级数求和
%循环计算
n=input('输入阶数');
y=0;
for i=1:n
    y=y+1/i^2;
end
Pi=sqrt(6*y);
disp(Pi);