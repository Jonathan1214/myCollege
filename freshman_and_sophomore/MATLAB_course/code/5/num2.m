%输入成绩判断等级
%if语句实现
score = input('请输入成绩');
if score<0 | score >100
    disp('请输入有效成绩');
elseif score<60
    disp('E');
elseif score<=69
    disp('D');
elseif score<=79
    disp('C');
elseif score<=89
    disp('B');
else
    disp('A');
end
end
end
end
end
end

