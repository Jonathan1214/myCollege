function UL = LineElecPotential(x, y, L)
%LineElecPotential 均匀带电线段周围的电势分布
%   计算已经在前面给出 这里直接给出电势的表达式
    UL = log(L - x + (y^2 + (L - x)^2)^(1/2)) -...
        log(((L + x)^2 + y^2)^(1/2) - x - L);
end

