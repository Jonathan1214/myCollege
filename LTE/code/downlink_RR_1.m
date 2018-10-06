function [allocation_RB,allocation_begin_ue_next]=...
    downlink_RR_1(num_rb,num_ue,CQI,allocation_begin_ue,...
    num_symbol,num_subcarrier)       
    %LTE下行链路轮询算法（即OFDMA资源块分配方案）
    %输入：
    %   num_rb是系统资源块
	%   num_ue是系统中用户数目
	%   CQI是用户对应RB的CQI矩阵 CQI（25*）
	%   allocation_begin_ue是在当前TTI需要第一个接受调度的用户编号
	%   num_symbol是一个子帧的OFDM符号数 
	%   num_subcarriler是每个RB携带的子载波数
	
	%输出：
	%   allocation_RB是分配矩阵： 第一列值1代表该RB已分配，0未分配；
                             %第二列代表该RB使用的CQI值
                             %第三列代表该RB分配给了哪个用户
                             %第四列代表分到这个RB后的传送速率
	% allocation_begin_ue_next是下一个TTI需要第一个接受调度的用户编号
	% 从第一个RB开始分配，第一个RB分配给在当前TTI需要第一个接受调度的用户
	% 然后第二个RB分配给下一个需要接受调度的用户
	% 直至所有RB分配完成，此时再返回下一个TTI需要接受调度的用户编号
    
    
    
    allocation_RB=zeros(num_rb,4);    % 记录RB分配位置及速率
    %% 确定起始位置
    % need_TTI = ceil(num_ue/num_rb); % 给所有用户都分配好需要的时隙数
    % tmp_ = mod(allocation_begin_ue-1, need_TTI); % 某种关系吧
    begin_ue = mod(allocation_begin_ue*num_rb, num_ue);   % 开始分配RB的用户编号
    %% 分配
    tmp = 0;     % 记录分配剩下RB的编号
	for rb_count = 1:1:num_rb         % 遍历每一个RB
        ue_ord = rb_count + begin_ue; % 实际分配时用户编号
		if ue_ord > num_ue            % 如果所用的用户都分配到了RB
			tmp = rb_count;
            break                     %    则剩下的RB也不再分配
        end                           %    当然稍微修改下也可以分配剩下的RB
        allocation_RB(rb_count, 1) = 1;
	    CQI_ = CQI(rb_count, ue_ord); % 用户的CQI值
		allocation_RB(rb_count, 2) = CQI_;
		allocation_RB(rb_count, 3) = ue_ord; % 记录RB分配的位置
		[MCS_para,Qm,~]=modulation_CQI_mapping(CQI_);
		rate = (num_symbol-3)*num_subcarrier*Qm*MCS_para/1024; % 速率
		allocation_RB(rb_count, 4) = rate;
    end
    if tmp                                % 如果有多余的RB
        for rb_count = tmp:1:num_rb       % 从第一个用户开始分配
            ue_ord = rb_count+1-tmp;      % 用户编号
            allocation_RB(rb_count, 1) = 1;
            CQI_ = CQI(rb_count, ue_ord); % 用户的CQI值
            allocation_RB(rb_count, 2) = CQI_;
            allocation_RB(rb_count, 3) = ue_ord; % 记录RB分配的位置
            [MCS_para,Qm,~]=modulation_CQI_mapping(CQI_);
            rate = (num_symbol-3)*num_subcarrier*Qm*MCS_para/1024; % 速率
            allocation_RB(rb_count, 4) = rate;
        end       
    end
    % 帮助记录下一个时隙的开始分配的用户位置
	allocation_begin_ue_next = allocation_begin_ue + 1;
end   
   
               
