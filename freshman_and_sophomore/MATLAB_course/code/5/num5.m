y=1;
n=1;
while y<3
    n=n+1;
    y=y+1/(2*n-1);
end
y=y-1/(2*n-1);
n=n-1;
disp('n���ֵΪ');
disp(n);
disp('��Ӧ��yֵ');
disp(y);
    