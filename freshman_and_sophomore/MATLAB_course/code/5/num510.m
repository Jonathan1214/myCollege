%����λ���еľ�������
%������ʮλ�͸�λ֮�������Ȼ������
%matlab���Ѿ����������ĺ����� �ܷ��� �����ĿҲû��ʲô�ѵ���
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