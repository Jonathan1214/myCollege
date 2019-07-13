%----------------------------------------------------------------------%
%                       ����ʵ����֣�
%                       ����ճ��ϵ��
%author:Jonathan
%time: 2018-09-28
%contact me: jonathan1214@foxmail.com 
%            jiangxli0101@gmail.com
%ʹ��˵����15-16�� �����������С���ֱ�� ÿһ����һ��С����β�����ֱ�� ��20������һ��ƽ��
%          21��    ÿ��С�������ʱ��
%          26��    ÿ��С���Ӧ���� ��һ����ʵ��ʱʵʱ������
%�޸�ʹ��˵���ϵ����ݼ���
%----------------------------------------------------------------------%
clc;
%% ������ű���
syms rho rho0 g d t L D
eta = ((rho - rho0) * g * t * d^2) / (18 * L * (1 + (12 * d) / (5 * D)));
format long 
%% �����¶�Ϊ24.1centigrade�µ�ճ��ϵ��
d_array = [1.534, 1.493, 1.523, 1.543, 1.501;
           1.511, 1.578, 1.589, 1.517, 1.546;
           1.524, 1.549, 1.512, 1.547, 1.527;
           1.521, 1.501, 1.535, 1.563, 1.516;
           1.505, 1.512, 1.529, 1.515, 1.503] * 10^-3; % 5�β�����С��ֱ�� ��λmm
d_average = mean(d_array);
time_ar = [22.4, 16.1, 11.9, 8.7, 7.4];    % ����ʱ��
temp_ar = [24.1, 26.2, 29.9, 33.9, 38.0];  % �¶�
L_ar = [0.2000, 0.2040, 0.2040, 0.2040, 0.2040]; %�������
D_ar = [8.20, 7.88, 7.88, 7.88, 7.88] * 10^-2;
result = zeros(1,5);
for i=1:length(d_average)
    result(i) = subs(eta, [rho, rho0, g, d, t, L, D], [7.700 * 10^3, 0.9741 * 10^3, 9.8066, d_average(i), time_ar(i), L_ar(i), D_ar(i)]);
end 
plot(temp_ar, result)
title('ճ��ϵ�����¶ȵĹ�ϵ');
xlabel('�¶�/��');
ylabel('ճ��ϵ��/Pa��s')
grid on

%% ��ȷ���ȼ��� ֻ���¶ȵ�һ���¶��µĲ�ȷ����
% �������ת���ɲ�ȷ����
C = sqrt(3);                   % ���������Ǿ��ȷֲ�
ucer_D = 1.0 * 10^-3 / C; % Ͳ��ֱ��
ucer_L = 0.5 * 10^-3 / C; % Ͳ��
ucer_scope = 0.007 * 10^-3 / C; % ��΢��
ucer_t = 0.2 / C;            % ��ʱ��
ucer_rho = 0.005 * 10^3; % �����ܶ�
ucer_rho0 = 0.0005 * 10^3;% ���ܶ�

ucer_d = zeros(1,5);    % Ԥ�����ڴ�
ucer_E = zeros(1,5);
ucer_U = zeros(1,5);
%��ȷ����
for i = 1:size(d_array, 1)  % ������
    s_ = 0; 
    for j = 1:size(d_array, 2) % ������
        s_ = s_ + (d_array(i,j) - d_array(i))^2;
    end
    mytest=sqrt(s_/(size(d_array, 2) * (size(d_array, 2) - 1)));
    ucer_d(i) = sqrt(s_/(size(d_array, 2) * (size(d_array, 2) - 1)) + ucer_scope^2);
    f = log(eta);
%     f2 = diff(f, D);
    tmp1 = subs(diff(f, D), [rho, rho0, g, d, t, L, D],... % Ͳֱ��ƫ��
        [7.700 * 10^3, 0.9741 * 10^3, 9.8066, d_average(i), time_ar(i), L_ar(i), D_ar(i)]);
    tmp2 = subs(diff(f, L), [rho, rho0, g, d, t, L, D],... % Ͳ����ƫ��
        [7.700 * 10^3, 0.9741 * 10^3, 9.8066, d_average(i), time_ar(i), L_ar(i), D_ar(i)]);
    tmp3 = subs(diff(f, t), [rho, rho0, g, d, t, L, D],... % ʱ��ƫ��
        [7.700 * 10^3, 0.9741 * 10^3, 9.8066, d_average(i), time_ar(i), L_ar(i), D_ar(i)]);
    tmp4 = subs(diff(f, rho), [rho, rho0, g, d, t, L, D],... % �����ܶ�ƫ��
        [7.700 * 10^3, 0.9741 * 10^3, 9.8066, d_average(i), time_ar(i), L_ar(i), D_ar(i)]);
    tmp5 = subs(diff(f, rho0), [rho, rho0, g, d, t, L, D],...% ���ܶ�ƫ��
        [7.700 * 10^3, 0.9741 * 10^3, 9.8066, d_average(i), time_ar(i), L_ar(i), D_ar(i)]);
    tmp6 = subs(diff(f, d), [rho, rho0, g, d, t, L, D],...  % ����ֱ��ƫ��
        [7.700 * 10^3, 0.9741 * 10^3, 9.8066, d_average(i), time_ar(i), L_ar(i), D_ar(i)]);
    
    
    % �������ǵ������ ��Բ�ȷ����
    ucer_E(i) = sqrt((tmp1 * ucer_D)^2 + (tmp2 * ucer_L)^2 + (tmp3 * ucer_t)^2 + (tmp4 * ucer_rho)^2 +...
                (tmp5 * ucer_rho0)^2 + (tmp6 * ucer_d(i))^2);
    % ���Բ�ȷ����
    ucer_U(i) = ucer_E(i) * result(i);
end
disp('С��ֱ��')
d_average

disp('��Ӧֱ���µĲ�ȷ����')
ucer_d

disp('ճ��ϵ��')
double(result)

disp('ճ��ϵ����ȷ����')
ucer_U

disp('ճ��ϵ����Բ�ȷ����')
ucer_E
