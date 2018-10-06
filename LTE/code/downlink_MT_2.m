function [allocation_RB]=downlink_MT_1(num_rb,num_ue,CQI,num_symbol,num_subcarrier)       
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
tmp_count2exclude = zeros(1,num_ue); % ÿ��ueֻ����һ��rb ������Kֵ��
max_rb_num = 1;
flag_ue = zeros(1,num_ue)+1;
flag_rb = zeros(1,num_rb)+1;
%% ����ÿ���û���ÿ����Դ���ϵ�������������
K_argmax = zeros(num_rb, num_ue);
for rb_count = 1:1:num_rb
    for ue_ord= 1:1:num_ue
        CQI_ = CQI(rb_count, ue_ord);
        [MCS_para,Qm,~]=modulation_CQI_mapping(CQI_);
        bit_rate = (num_symbol-3)*num_subcarrier*Qm*MCS_para/1024;
        K_argmax(rb_count,ue_ord) = bit_rate;       
    end
end
%% ��ʼ����
% û�п��Ƿ�����û�������������RB 
% �ȿ�һ��Ч�� 17.20
% for rb_count = 1:1:num_rb
%     [rate, ue_index] = max(K_argmax(rb_count,:), [], 2);
%     while tmp_count2exclude(ue_index) >= max_rb_num
%         K_argmax(rb_count, ue_index) = 0;
%         [rate, ue_index] = max(K_argmax(rb_count,:), [], 2);      
%     end
%     CQI_ = CQI(rb_count, ue_index); % �û���CQIֵ
%     allocation_RB(rb_count, 1) = 1;
%     allocation_RB(rb_count, 2) = CQI_;
%     allocation_RB(rb_count, 3) = ue_index;
%     allocation_RB(rb_count, 4) = rate;
%     tmp_count2exclude(ue_index) = tmp_count2exclude(ue_index) + 1;
% end

%% ��ʼ���� 2.0�汾
% ÿ��ue������������������ļ���RB
%  begin��17:21
%  end:   19:55 ���ڸ㶨��
%  check: 20:39 ʧ����
%         ������ ��һ�л���������ʦ��
for rb_count = 1:1:num_rb
    while flag_ue
        [V,I] = max(K_argmax); % Iÿһ�����ֵ��������
        tmp = I==rb_count; % ���� ������ʾ�����԰�
        ue_index = find(V==max(K_argmax(rb_count,tmp))); % ������ô�� ���п��ܻ��ظ���
        CQI_ = CQI(rb_count, ue_index(1)); % �û���CQIֵ
        allocation_RB(rb_count, 1) = 1;
        allocation_RB(rb_count, 2) = CQI_;
        allocation_RB(rb_count, 3) = ue_index(1);
        allocation_RB(rb_count, 4) = V(ue_index(1));
        flag_ue(ue_index(1)) = 0;
    end
end

% 1 ��ȡ�����ֵ������
% 2 ��ȡ�����ֵ������
% 


% ÿ���û�ֻ�ܷ��䵽һ��rb
% ������ٽ�һ�� ��ʵ���Կ���ÿ���û�������n��rb�����
% ��ʵ��ÿ���û�
% ������ �Ȱѱ����pptд��
% [max_bit_rate, ue_index] = max(k_argmax, [], 2); %ÿһ����Դ�������������û����ʼ�������
% for i=1:length(ue_index)
%     allocation_RB(i, 1) = 1;
%     CQI_ = CQI(i, ue_index(i));
% 	allocation_RB(i, 2) = CQI_;
%     allocation_RB(i, 3) = ue_index(i);
%     allocation_RB(i, 4) = max_bit_rate(i);
% end
end
