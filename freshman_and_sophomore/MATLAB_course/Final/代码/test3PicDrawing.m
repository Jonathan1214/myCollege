%% ���հ汾
L = 2;
x = -10:0.1:10;
y = -10:0.1:10;
[X,Y] = meshgrid(x,y);
% �����﷢��U��ֵ�е�󣬲���ֱ���㲻��k��rho�İ�
U = log(L - X + (Y.^2 + (L - X).^2).^(1/2)) -...
    log(((L + X).^2 + Y.^2).^(1/2) - X - L);
%��������
for i=1:numel(U)
    if isnan(U(i))
        if ~isnan(U(i+1)) && ~isnan(U(i-1))
            U(i) = (U(i+1)+U(i-1))/2;
        end
    elseif isinf(U(i))
        U(i) = (U(i+1) + U(i-1))/2;
    end
end

%% 
%��һ��ͼ ��ά
figure (1)  
mesh(X,Y,U);
v = 0:0.3:5;
hold on
contour3(X,Y,U,v,'r','LineWidth',2);
title('������ͼ')
grid on
hold on 
plot([-L,L], [0,0], 'r', 'LineWidth',3)  %�������λ��
axis([-10 10 -10 10 0 6])
xlabel('x/L');ylabel('y/L');zlabel('������/k*rhoa')

%% �ڶ���ͼ
figure (2); 
v = 0:0.25:3;
[C,h]=contour(X,Y,U,v);
clabel(C,h);
hold on; grid on;axis([-4 4 -3 3])
plot([-L,L], [0,0], 'r', 'LineWidth',3)       %ƽ������߼ǵ����

[Ex,Ey] = gradient(-U);                       %������ݶȼ��糡
theta = 0:pi/15:2*pi;                         %�������
x0 = L*cos(theta);                              %
y0 = L*1/20*sin(theta);                         %
h = streamline(X,Y,Ex,Ey,x0,y0);              %���糡��
set(h,'LineWidth',2,'Color','b');             %���߿����ɫ
title('�����߼��糡��')                        %ͼ��
xlabel('x/L');ylabel('y/L')                   %���ú���������
text(-3.5,2.5,'���Ƶ�λ��k\rho','FontSize',16) %���õ��Ƶ�λ��ʾ�ı�