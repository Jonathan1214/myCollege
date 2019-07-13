%% --------------------------------------------------------------------%
%                            大物实验之转动惯量 
% author: Jonathan
% time:2018-09-29
% 
% 
%  ------------------------------------------------------------------------------%
%% 一些常量和记录的数据
% all_result 第一列：转动惯量理论值
%           第二列：转动惯量实验值(待求)
%           第三列：百分差       (待求)
% time_cycle 周期 
%            依次是盘 实心柱+盘 空心金属柱+盘 球 杆
format long
time_cycle = [0.757, 1.257, 1.542, 1.166, 2.171];
m_cy = 0.7129;         %实心塑料柱质量
D_cy = 0.10000;        %          直径
m_hmCy = 0.7049;       %空心金属柱质量
D_hmCy_w = 0.10000;    %          外径
D_hmCy_n = 0.09400;    %          内径
m_ball = 0.7175;       %木球质量        
D_ball = 0.13200;      %    直径
m_rod = 0.1339;        %杆质量
l_rod = 0.61000;       %  长度
m_sup = 0.0530;        %支座质量
R_sup = 0.00900;       %   直径
m_slider = 0.2390;     %滑块质量
d_slider = 0.03500;    %    半径
l_slider = 0.03300;    %    长度
distance_and_time = [0.0500, 2.419; 
                     0.1000, 3.203;
                     0.1500, 4.139;
                     0.2000, 5.194;
                     0.2500, 6.260];
all_results = zeros(5, 3);
%% 转动惯量理论值
syms para1 para2 para3
Theoretical_I_Cylinder = 1/8*para1*para2^2;
Theoretical_I_hmCylinder = 1/8*para1*(para2^2+para3^2);
Theoretical_I_ball = 1/10*para1*para2^2;
Theoretical_I_rod = 1/12*para1*para2^2;
% 只要计算四个理论值
all_results(2,1) = subs(Theoretical_I_Cylinder, [para1,para2], [m_cy,D_cy]);
all_results(3,1) = subs(Theoretical_I_hmCylinder, [para1,para2,para3], [m_hmCy, D_hmCy_w, D_hmCy_n]);
all_results(4,1) = subs(Theoretical_I_ball, [para1, para2], [m_ball, D_ball]);
all_results(5,1) = subs(Theoretical_I_rod, [para1, para2], [m_rod, l_rod]);
I_support = 1/8*m_sup*R_sup^2;
%% 扭转系数
K = 4*pi^2*all_results(2,1)/(time_cycle(2)^2 - time_cycle(1)^2);
%% 实验值
all_results(1,2) = (all_results(2,1)*time_cycle(1)^2)/(time_cycle(2)^2 - time_cycle(1)^2);
% Ex_I_Cylinder Ex_I_hmCylinder
for i=2:3
    all_results(i,2) = (K*time_cycle(i)^2)/(4*pi^2) - all_results(1,2);  
end
% ball rod
for i=4:5
    all_results(i,2) = (K*time_cycle(i)^2)/(4*pi^2);
end
all_results(5,2) = all_results(5,2) - I_support;
%% 计算百分差
for i = 2:5
    all_results(i,3) = abs(all_results(i,2)-all_results(i,1))/all_results(i,1);
end
% all_results

%% 验证平行轴定理
I = zeros(1,5);
distance_pow = zeros(1,5);
for i=1:5
    I(i) = ((K*distance_and_time(i,2)^2)/(4*pi^2))*10^3;
    distance_pow(i) = (distance_and_time(i,1)*100)^2;
end

% plot(distance_pow, I, '-o')
% ylim([0 40])
% grid on
% title('转动惯量与距离的关系')
% xlabel('distance/cm^2')
% ylabel('Moment_of_inertia/kg·m^2')

p = polyfit(distance_pow, I, 1);
x1 = 0:100:700;
y1 = polyval(p, x1);
plot(distance_pow, I, 'o')
hold on
plot(x1, y1)
grid on
title('转动惯量与距离的关系I-x^2图像')
xlabel('distance/cm^2')
ylabel('Moment of inertia/kg·m^2·10^-3')
I
all_results

K
p




