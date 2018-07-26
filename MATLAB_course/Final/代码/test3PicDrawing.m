%% 最终版本
L = 2;
x = -10:0.1:10;
y = -10:0.1:10;
[X,Y] = meshgrid(x,y);
% 到这里发现U数值有点大，不如直接算不乘k和rho的吧
U = log(L - X + (Y.^2 + (L - X).^2).^(1/2)) -...
    log(((L + X).^2 + Y.^2).^(1/2) - X - L);
%修正数据
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
%第一个图 三维
figure (1)  
mesh(X,Y,U);
v = 0:0.3:5;
hold on
contour3(X,Y,U,v,'r','LineWidth',2);
title('等势线图')
grid on
hold on 
plot([-L,L], [0,0], 'r', 'LineWidth',3)  %电荷所在位置
axis([-10 10 -10 10 0 6])
xlabel('x/L');ylabel('y/L');zlabel('等势线/k*rhoa')

%% 第二张图
figure (2); 
v = 0:0.25:3;
[C,h]=contour(X,Y,U,v);
clabel(C,h);
hold on; grid on;axis([-4 4 -3 3])
plot([-L,L], [0,0], 'r', 'LineWidth',3)       %平面等势线记电荷线

[Ex,Ey] = gradient(-U);                       %求电势梯度即电场
theta = 0:pi/15:2*pi;                         %设置起点
x0 = L*cos(theta);                              %
y0 = L*1/20*sin(theta);                         %
h = streamline(X,Y,Ex,Ey,x0,y0);              %画电场线
set(h,'LineWidth',2,'Color','b');             %改线宽和颜色
title('等势线及电场线')                        %图名
xlabel('x/L');ylabel('y/L')                   %设置横纵轴名称
text(-3.5,2.5,'电势单位：k\rho','FontSize',16) %设置电势单位提示文本