%�ֶκ���
for n=1:7
    x=input('����x��ֵ');
    if x<0 & x~=-3
        y=x^2+x-6;
    elseif x>=0&x<5 & x~=2 & x~=3
        y=x^2-5*x+6;
    else
        y=x^2-x-1;
    end
    disp(y)
end
end
end
