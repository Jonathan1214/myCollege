function UL = LineElecPotential(x, y, L)
%LineElecPotential ���ȴ����߶���Χ�ĵ��Ʒֲ�
%   �����Ѿ���ǰ����� ����ֱ�Ӹ������Ƶı��ʽ
    UL = log(L - x + (y^2 + (L - x)^2)^(1/2)) -...
        log(((L + x)^2 + y^2)^(1/2) - x - L);
end

