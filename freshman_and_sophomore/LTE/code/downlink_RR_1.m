function [allocation_RB,allocation_begin_ue_next]=...
    downlink_RR_1(num_rb,num_ue,CQI,allocation_begin_ue,...
    num_symbol,num_subcarrier)       
    %LTE������·��ѯ�㷨����OFDMA��Դ����䷽����
    %���룺
    %   num_rb��ϵͳ��Դ��
	%   num_ue��ϵͳ���û���Ŀ
	%   CQI���û���ӦRB��CQI���� CQI��25*��
	%   allocation_begin_ue���ڵ�ǰTTI��Ҫ��һ�����ܵ��ȵ��û����
	%   num_symbol��һ����֡��OFDM������ 
	%   num_subcarriler��ÿ��RBЯ�������ز���
	
	%�����
	%   allocation_RB�Ƿ������ ��һ��ֵ1�����RB�ѷ��䣬0δ���䣻
                             %�ڶ��д����RBʹ�õ�CQIֵ
                             %�����д����RB��������ĸ��û�
                             %�����д���ֵ����RB��Ĵ�������
	% allocation_begin_ue_next����һ��TTI��Ҫ��һ�����ܵ��ȵ��û����
	% �ӵ�һ��RB��ʼ���䣬��һ��RB������ڵ�ǰTTI��Ҫ��һ�����ܵ��ȵ��û�
	% Ȼ��ڶ���RB�������һ����Ҫ���ܵ��ȵ��û�
	% ֱ������RB������ɣ���ʱ�ٷ�����һ��TTI��Ҫ���ܵ��ȵ��û����
    
    
    
    allocation_RB=zeros(num_rb,4);    % ��¼RB����λ�ü�����
    %% ȷ����ʼλ��
    % need_TTI = ceil(num_ue/num_rb); % �������û����������Ҫ��ʱ϶��
    % tmp_ = mod(allocation_begin_ue-1, need_TTI); % ĳ�ֹ�ϵ��
    begin_ue = mod(allocation_begin_ue*num_rb, num_ue);   % ��ʼ����RB���û����
    %% ����
    tmp = 0;     % ��¼����ʣ��RB�ı��
	for rb_count = 1:1:num_rb         % ����ÿһ��RB
        ue_ord = rb_count + begin_ue; % ʵ�ʷ���ʱ�û����
		if ue_ord > num_ue            % ������õ��û������䵽��RB
			tmp = rb_count;
            break                     %    ��ʣ�µ�RBҲ���ٷ���
        end                           %    ��Ȼ��΢�޸���Ҳ���Է���ʣ�µ�RB
        allocation_RB(rb_count, 1) = 1;
	    CQI_ = CQI(rb_count, ue_ord); % �û���CQIֵ
		allocation_RB(rb_count, 2) = CQI_;
		allocation_RB(rb_count, 3) = ue_ord; % ��¼RB�����λ��
		[MCS_para,Qm,~]=modulation_CQI_mapping(CQI_);
		rate = (num_symbol-3)*num_subcarrier*Qm*MCS_para/1024; % ����
		allocation_RB(rb_count, 4) = rate;
    end
    if tmp                                % ����ж����RB
        for rb_count = tmp:1:num_rb       % �ӵ�һ���û���ʼ����
            ue_ord = rb_count+1-tmp;      % �û����
            allocation_RB(rb_count, 1) = 1;
            CQI_ = CQI(rb_count, ue_ord); % �û���CQIֵ
            allocation_RB(rb_count, 2) = CQI_;
            allocation_RB(rb_count, 3) = ue_ord; % ��¼RB�����λ��
            [MCS_para,Qm,~]=modulation_CQI_mapping(CQI_);
            rate = (num_symbol-3)*num_subcarrier*Qm*MCS_para/1024; % ����
            allocation_RB(rb_count, 4) = rate;
        end       
    end
    % ������¼��һ��ʱ϶�Ŀ�ʼ������û�λ��
	allocation_begin_ue_next = allocation_begin_ue + 1;
end   
   
               
