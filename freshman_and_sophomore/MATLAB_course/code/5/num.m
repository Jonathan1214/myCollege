a=input('请输入a的值');
b=input('请输入b的值');
x0=1.0;
n=1;
x1=a/(b+x0);
R=abs(x1-x0);
while R>=0.00001
    x0=x1;
    x1=a/(b+x0);
    n=n+1;
    if n>500 break;
    end
end
disp(x1)
r=(-b+sqrt(b^2+4*a))/2;
disp(r);
