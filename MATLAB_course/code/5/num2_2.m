%����ɼ��ȼ�
%ʹ��swich���
score = input('������ɼ�');
switch score
    case num2cell(0:59)
        rate='E';
    case num2cell(60:69)
        rate='D';
    case num2cell(70:79)
        rate='C';
    case num2cell(80:89)
        rate='B';
    case num2cell(90:100)
        rate='A';
    otherwise
        rate = 'N';
end
if rate=='N'
    disp('��������Ч�ɼ�');
else
    disp(rate);
end
