syms n
f=n+10*log(n.^2+5);
f1=subs(f,40);
f2=subs(f,30);
f3=subs(f,20);
y=f1/(f2+f3)