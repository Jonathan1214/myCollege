function [allocation_RB]=downlink_PF(num_rb,num_ue,CQI,windows_throuput_ue,num_symbol,num_subcarrier)       
%%������·������ƽ�㷨����OFDMA��Դ����䷽����
%num_rb��ϵͳ��Դ�飬
%num_ue��ϵͳ���û���Ŀ��
%num_symbol��һ����֡��OFDM��������
%num_subcarriler��ÿ��RBЯ�������ز���
%CQI���û���ӦRB��CQI���� CQI,
%past_throuput_ue��ÿ���û�ʱ�䴰�ڵ�ƽ��������
%allocation_RB�Ƿ������ ��һ��ֵ1�����RB�ѷ��䣬0δ���䣬
%                        �ڶ��д����RBʹ�õ�CQIֵ��
%  						 �����д����RB��������ĸ��û�
%                        �����д���ֵ����RB��Ĵ�������
%% ������Ҫ�����ÿ���û���ÿ����Դ���������������ʣ�Ȼ������㷨���ȼ���ʽ�����ÿ���û���ÿ����Դ���ϵ����ȼ���Ȼ�����RB��ʼ����ֱ�����е�RBȫ���������

allocation_RB=zeros(num_rb,4);
for rb_count = 1:1:num_rb
    K_argmax = zeros(1,num_ue); %�洢һ��rb��ÿ���û��ϵ�Kֵ
    bit_rate_array = zeros(1,num_ue); %�洢��PRB��ÿ���û��ı�������
    CQI_array = zeros(1,num_ue);  % ���������PRB��ÿ���û���CQIֵ
    for ue_ord= 1:1:num_ue
        CQI_ = CQI(rb_count, ue_ord);
        CQI_array(ue_ord) = CQI_;
                                  % �����������
        [MCS_para,Qm,~]=modulation_CQI_mapping(CQI_);
        bit_rate = (num_symbol-3)*num_subcarrier*Qm*MCS_para/1024;
        bit_rate_array(ue_ord) = bit_rate; % �����������
        K_argmax(ue_ord) = bit_rate/windows_throuput_ue(ue_ord);

    end
    [~, index] = max(K_argmax);
                                % ����PRB
    allocation_RB(rb_count, 1) = 1;
    allocation_RB(rb_count, 2) = CQI_array(index);
    allocation_RB(rb_count, 3) = index;
    allocation_RB(rb_count, 4) = bit_rate_array(index);
end
end