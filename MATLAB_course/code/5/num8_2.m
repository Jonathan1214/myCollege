n1=40;
n2=30;
n3=20;
f1=0;
f2=0;
f3=0;
for i=1:n1
    f1=f1+i*(i+1);
end
for i=1:n2
    f2=f2+i*(i+1);
end
for i=1:n3
    f3=f3+i*(i+1);
end
y=f1/(f2+f3)