function [allocation_RB]=downlink_MT(num_rb,num_ue,CQI,num_symbol,num_subcarrier)       
%%下行链路最大吞吐量算法（即OFDMA资源块分配方案）
%num_rb是系统资源块，
%num_ue是系统中用户数目，
%num_symbol是一个子帧的OFDM符号数，
%num_subcarriler是每个RB携带的子载波数
%CQI是用户对应RB的CQI矩阵
%allocation_RB是分配矩阵 第一列值1代表该RB已分配，0未分配，
%                        第二列代表该RB使用的CQI值，
%                        第三列代表该RB分配给了哪个用户
%                        第四列代表分到这个RB后的传送速率
%首先需要计算出每个用户在每个资源块上理论数据速率，
%然后根据算法优先级公式计算出每个用户在每个资源块上的优先级，
%然后基于RB开始分配直至所有的RB全部分配完成


allocation_RB=zeros(num_rb,4);
% 就不按照每个人只分一个的原则了 追求吞吐量最大 只要该用户的比特速率最大RB就分给他
for rb_count = 1:1:num_rb           % 遍历每一个RB
    K_argmax = zeros(1,num_ue);     % 优先级矩阵
    CQI_array = zeros(1,num_ue);    % 用来保存CQI
    for ue_ord= 1:1:num_ue       % 遍历每一个ue 求出每一个用户再当前RB上的比特速率
        CQI_ = CQI(rb_count, ue_ord);
        CQI_array(ue_ord) = CQI_;  % 保存CQI
                                   % 计算比特速率
        [MCS_para,Qm,~]=modulation_CQI_mapping(CQI_);
        bit_rate = (num_symbol-3)*num_subcarrier*Qm*MCS_para/1024;
        K_argmax(ue_ord) = bit_rate; % 保存ue的优先级，值越大优先级越高      
    end
    [rate, ue_index] = max(K_argmax, [], 2); % 获取优先级最高的用户速率和编号
                                    % 分配RB
    allocation_RB(rb_count, 1) = 1;
	allocation_RB(rb_count, 2) = CQI_array(ue_index);
    allocation_RB(rb_count, 3) = ue_index;
    allocation_RB(rb_count, 4) = rate;  
end
