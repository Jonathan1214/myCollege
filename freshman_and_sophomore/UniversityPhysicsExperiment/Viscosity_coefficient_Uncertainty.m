%----------------------------------------------------------------------%
%                       物理实验快乐！
%                       计算粘度系数
%author:Jonathan
%time: 2018-09-28
%contact me: jonathan1214@foxmail.com 
%            jiangxli0101@gmail.com
%使用说明：15-16行 输入你测量的小球的直径 每一行是一个小球五次测量的直径 第20行求了一个平均
%          21行    每个小球的下落时间
%          26行    每个小球对应油温 第一个是实验时实时测量的
%修改使用说明上的数据即可
%----------------------------------------------------------------------%
clc;
%% 定义符号变量
syms rho rho0 g d t L D
eta = ((rho - rho0) * g * t * d^2) / (18 * L * (1 + (12 * d) / (5 * D)));
format long 
%% 计算温度为24.1centigrade下的粘滞系数
d_array = [1.534, 1.493, 1.523, 1.543, 1.501;
           1.511, 1.578, 1.589, 1.517, 1.546;
           1.524, 1.549, 1.512, 1.547, 1.527;
           1.521, 1.501, 1.535, 1.563, 1.516;
           1.505, 1.512, 1.529, 1.515, 1.503] * 10^-3; % 5次测量的小球直径 单位mm
d_average = mean(d_array);
time_ar = [22.4, 16.1, 11.9, 8.7, 7.4];    % 下落时间
temp_ar = [24.1, 26.2, 29.9, 33.9, 38.0];  % 温度
L_ar = [0.2000, 0.2040, 0.2040, 0.2040, 0.2040]; %下落距离
D_ar = [8.20, 7.88, 7.88, 7.88, 7.88] * 10^-2;
result = zeros(1,5);
for i=1:length(d_average)
    result(i) = subs(eta, [rho, rho0, g, d, t, L, D], [7.700 * 10^3, 0.9741 * 10^3, 9.8066, d_average(i), time_ar(i), L_ar(i), D_ar(i)]);
end 
plot(temp_ar, result)
title('粘滞系数与温度的关系');
xlabel('温度/℃');
ylabel('粘滞系数/Pa·s')
grid on

%% 不确定度计算 只算温度第一个温度下的不确定度
% 仪器误差转换成不确定度
C = sqrt(3);                   % 仪器误差看作是均匀分布
ucer_D = 1.0 * 10^-3 / C; % 筒的直径
ucer_L = 0.5 * 10^-3 / C; % 筒长
ucer_scope = 0.007 * 10^-3 / C; % 显微镜
ucer_t = 0.2 / C;            % 计时器
ucer_rho = 0.005 * 10^3; % 钢球密度
ucer_rho0 = 0.0005 * 10^3;% 油密度

ucer_d = zeros(1,5);    % 预分配内存
ucer_E = zeros(1,5);
ucer_U = zeros(1,5);
%不确定度
for i = 1:size(d_array, 1)  % 迭代行
    s_ = 0; 
    for j = 1:size(d_array, 2) % 迭代列
        s_ = s_ + (d_array(i,j) - d_array(i))^2;
    end
    mytest=sqrt(s_/(size(d_array, 2) * (size(d_array, 2) - 1)));
    ucer_d(i) = sqrt(s_/(size(d_array, 2) * (size(d_array, 2) - 1)) + ucer_scope^2);
    f = log(eta);
%     f2 = diff(f, D);
    tmp1 = subs(diff(f, D), [rho, rho0, g, d, t, L, D],... % 筒直径偏导
        [7.700 * 10^3, 0.9741 * 10^3, 9.8066, d_average(i), time_ar(i), L_ar(i), D_ar(i)]);
    tmp2 = subs(diff(f, L), [rho, rho0, g, d, t, L, D],... % 筒长度偏导
        [7.700 * 10^3, 0.9741 * 10^3, 9.8066, d_average(i), time_ar(i), L_ar(i), D_ar(i)]);
    tmp3 = subs(diff(f, t), [rho, rho0, g, d, t, L, D],... % 时间偏导
        [7.700 * 10^3, 0.9741 * 10^3, 9.8066, d_average(i), time_ar(i), L_ar(i), D_ar(i)]);
    tmp4 = subs(diff(f, rho), [rho, rho0, g, d, t, L, D],... % 钢球密度偏导
        [7.700 * 10^3, 0.9741 * 10^3, 9.8066, d_average(i), time_ar(i), L_ar(i), D_ar(i)]);
    tmp5 = subs(diff(f, rho0), [rho, rho0, g, d, t, L, D],...% 油密度偏导
        [7.700 * 10^3, 0.9741 * 10^3, 9.8066, d_average(i), time_ar(i), L_ar(i), D_ar(i)]);
    tmp6 = subs(diff(f, d), [rho, rho0, g, d, t, L, D],...  % 钢球直径偏导
        [7.700 * 10^3, 0.9741 * 10^3, 9.8066, d_average(i), time_ar(i), L_ar(i), D_ar(i)]);
    
    
    % 这是我们的最后结果 相对不确定度
    ucer_E(i) = sqrt((tmp1 * ucer_D)^2 + (tmp2 * ucer_L)^2 + (tmp3 * ucer_t)^2 + (tmp4 * ucer_rho)^2 +...
                (tmp5 * ucer_rho0)^2 + (tmp6 * ucer_d(i))^2);
    % 绝对不确定度
    ucer_U(i) = ucer_E(i) * result(i);
end
disp('小球直径')
d_average

disp('对应直径下的不确定度')
ucer_d

disp('粘滞系数')
double(result)

disp('粘滞系数不确定度')
ucer_U

disp('粘滞系数相对不确定度')
ucer_E
