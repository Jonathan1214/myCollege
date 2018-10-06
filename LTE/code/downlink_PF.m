function [allocation_RB]=downlink_PF(num_rb,num_ue,CQI,windows_throuput_ue,num_symbol,num_subcarrier)       
%%下行链路比例公平算法（即OFDMA资源块分配方案）
%num_rb是系统资源块，
%num_ue是系统中用户数目，
%num_symbol是一个子帧的OFDM符号数，
%num_subcarriler是每个RB携带的子载波数
%CQI是用户对应RB的CQI矩阵 CQI,
%past_throuput_ue是每个用户时间窗内的平均吞吐量
%allocation_RB是分配矩阵 第一列值1代表该RB已分配，0未分配，
%                        第二列代表该RB使用的CQI值，
%  						 第三列代表该RB分配给了哪个用户
%                        第四列代表分到这个RB后的传送速率
%% 首先需要计算出每个用户在每个资源块上理论数据速率，然后根据算法优先级公式计算出每个用户在每个资源块上的优先级，然后基于RB开始分配直至所有的RB全部分配完成

allocation_RB=zeros(num_rb,4);
for rb_count = 1:1:num_rb
    K_argmax = zeros(1,num_ue); %存储一个rb在每个用户上的K值
    bit_rate_array = zeros(1,num_ue); %存储该PRB下每个用户的比特速率
    CQI_array = zeros(1,num_ue);  % 用来储存该PRB下每个用户的CQI值
    for ue_ord= 1:1:num_ue
        CQI_ = CQI(rb_count, ue_ord);
        CQI_array(ue_ord) = CQI_;
                                  % 计算比特速率
        [MCS_para,Qm,~]=modulation_CQI_mapping(CQI_);
        bit_rate = (num_symbol-3)*num_subcarrier*Qm*MCS_para/1024;
        bit_rate_array(ue_ord) = bit_rate; % 储存比特速率
        K_argmax(ue_ord) = bit_rate/windows_throuput_ue(ue_ord);

    end
    [~, index] = max(K_argmax);
                                % 分配PRB
    allocation_RB(rb_count, 1) = 1;
    allocation_RB(rb_count, 2) = CQI_array(index);
    allocation_RB(rb_count, 3) = index;
    allocation_RB(rb_count, 4) = bit_rate_array(index);
end
end