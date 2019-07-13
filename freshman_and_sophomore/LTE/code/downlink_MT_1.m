function [allocation_RB]=downlink_MT_1(num_rb,num_ue,CQI,num_symbol,num_subcarrier)       
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
tmp_count2exclude = zeros(1,num_ue); % 每个ue只分配一个rb 就算你K值大
max_rb_num = 2;
%% 计算每个用户在每个资源块上的理论数据速率
K_argmax = zeros(num_rb, num_ue);
for rb_count = 1:1:num_rb
    for ue_ord= 1:1:num_ue
        CQI_ = CQI(rb_count, ue_ord);
        [MCS_para,Qm,~]=modulation_CQI_mapping(CQI_);
        bit_rate = (num_symbol-3)*num_subcarrier*Qm*MCS_para/1024;
        K_argmax(rb_count,ue_ord) = bit_rate;       
    end
end
%% 开始分配
% 没有考虑分配给用户他的速率最大的RB 
% 针对RB而言 保证分给RB的速率是最大的 因为每个RB只能分一次
% 先看一下效果 17.20
for rb_count = 1:1:num_rb
    [rate, ue_index] = max(K_argmax(rb_count,:), [], 2);
    while tmp_count2exclude(ue_index) >= max_rb_num
        K_argmax(rb_count, ue_index) = 0;
        [rate, ue_index] = max(K_argmax(rb_count,:), [], 2);      
    end
    CQI_ = CQI(rb_count, ue_index); % 用户的CQI值
    allocation_RB(rb_count, 1) = 1;
    allocation_RB(rb_count, 2) = CQI_;
    allocation_RB(rb_count, 3) = ue_index;
    allocation_RB(rb_count, 4) = rate;
    tmp_count2exclude(ue_index) = tmp_count2exclude(ue_index) + 1;
end
% 每个用户只能分配到一个rb
% 如果想再进一步 其实可以考虑每个用户最多分配n个rb的情况
% 先实现每个用户
% 待定吧 先把报告和ppt写完
% [max_bit_rate, ue_index] = max(k_argmax, [], 2); %每一个资源块上速率最大的用户速率及其索引
% for i=1:length(ue_index)
%     allocation_RB(i, 1) = 1;
%     CQI_ = CQI(i, ue_index(i));
% 	allocation_RB(i, 2) = CQI_;
%     allocation_RB(i, 3) = ue_index(i);
%     allocation_RB(i, 4) = max_bit_rate(i);
% end
