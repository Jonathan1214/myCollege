function [allocation_RB]=downlink_MT(num_rb,num_ue,CQI,num_symbol,num_subcarrier)       
%%������·����������㷨����OFDMA��Դ����䷽����
%num_rb��ϵͳ��Դ�飬
%num_ue��ϵͳ���û���Ŀ��
%num_symbol��һ����֡��OFDM��������
%num_subcarriler��ÿ��RBЯ�������ز���
%CQI���û���ӦRB��CQI����
%allocation_RB�Ƿ������ ��һ��ֵ1�����RB�ѷ��䣬0δ���䣬
%                        �ڶ��д����RBʹ�õ�CQIֵ��
%                        �����д����RB��������ĸ��û�
%                        �����д���ֵ����RB��Ĵ�������
%������Ҫ�����ÿ���û���ÿ����Դ���������������ʣ�
%Ȼ������㷨���ȼ���ʽ�����ÿ���û���ÿ����Դ���ϵ����ȼ���
%Ȼ�����RB��ʼ����ֱ�����е�RBȫ���������


allocation_RB=zeros(num_rb,4);
% �Ͳ�����ÿ����ֻ��һ����ԭ���� ׷����������� ֻҪ���û��ı����������RB�ͷָ���
for rb_count = 1:1:num_rb           % ����ÿһ��RB
    K_argmax = zeros(1,num_ue);     % ���ȼ�����
    CQI_array = zeros(1,num_ue);    % ��������CQI
    for ue_ord= 1:1:num_ue       % ����ÿһ��ue ���ÿһ���û��ٵ�ǰRB�ϵı�������
        CQI_ = CQI(rb_count, ue_ord);
        CQI_array(ue_ord) = CQI_;  % ����CQI
                                   % �����������
        [MCS_para,Qm,~]=modulation_CQI_mapping(CQI_);
        bit_rate = (num_symbol-3)*num_subcarrier*Qm*MCS_para/1024;
        K_argmax(ue_ord) = bit_rate; % ����ue�����ȼ���ֵԽ�����ȼ�Խ��      
    end
    [rate, ue_index] = max(K_argmax, [], 2); % ��ȡ���ȼ���ߵ��û����ʺͱ��
                                    % ����RB
    allocation_RB(rb_count, 1) = 1;
	allocation_RB(rb_count, 2) = CQI_array(ue_index);
    allocation_RB(rb_count, 3) = ue_index;
    allocation_RB(rb_count, 4) = rate;  
end
