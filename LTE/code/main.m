%修改日期：2018-09-21
clc;
clear all; 
close all;
format long
%参数设置
num_prb=15;
num_subframe=30; %总时隙，可修改范围[1-100],查看效果
num_symbol=14;  %一个子帧的OFDM符号数 
num_subcarrier=12;%每个RB携带的子载波数
num_ue_add=10;  %每次增加的用户个数
num_simulate=9; %仿真的次数
num_ue_set=9;   %增加用户数目的次数
num_algorithm=3;%三种算法比较

%初始化
sum_throuput_all=zeros(num_algorithm,num_ue_set,num_simulate);
Jain_all=zeros(num_algorithm,num_ue_set,num_simulate);
sum_throuput_average=zeros(num_algorithm,num_ue_set);
Jain_average=zeros(num_algorithm,num_ue_set);

%% 产生固定用户信道
for iiii=1:1:num_simulate
   num_ue=10;
   %模拟每个PRB(RB)上噪声的生成
   prb_snr_TTI=zeros(num_prb,num_ue,num_subframe);
   for i=1:1:num_ue
       snr(i)=rand(1,1)*30-8;
       for TTI_ID=1:1:num_subframe
           snr_TTI(i,TTI_ID)=snr(i)-(rand(1,1)*8-8);
           for j=1:1:num_prb
              prb_snr_TTI(j,i,TTI_ID)=snr_TTI(i,TTI_ID)-(rand(1,1)*3-3);
           end
       end
   end
   for jjj=1:1:num_ue_set
        num_ue=10+jjj*num_ue_add;
        %模拟每个PRB(RB)上噪声的生成（新增）
        prb_snr_TTI_add=zeros(num_prb,num_ue_add,num_subframe);
        for i=1:1:num_ue_add
            snr_add(i)=rand(1,1)*30-8;
            for TTI_ID=1:1:num_subframe
                snr_TTI_add(i,TTI_ID)=snr_add(i)-(rand(1,1)*8-8);
                for j=1:1:num_prb
                    prb_snr_TTI_add(j,i,TTI_ID)=snr_TTI_add(i,TTI_ID)-(rand(1,1)*3-3);
                end
            end
        end
        %% 原有的用户信道与新增加的用户信道合在一起
        prb_snr_TTI=cat(2,prb_snr_TTI,prb_snr_TTI_add);

        %% 变量定义初始化
        sum_throuput_ue_perTTI=zeros(num_ue,num_subframe,num_algorithm);%每个TTI内每个用户的吞吐量
        sum_throuput_ue_until_TTI=zeros(num_ue,num_algorithm);%所有用户到当前TTI的累积吞吐量
        sum_throuput_total_all_TTI_RT=zeros(num_algorithm,1);%所有用户在所有TTI内的吞吐量
        sum_throuput_system_kbps_RT=zeros(num_algorithm,1);%系统吞吐量
        Jain=zeros(num_algorithm,1);
%----------------------------------从这里开始------------------------------%
        for iii=1:1:num_algorithm
            if iii==1
                allocation_type='RR';
            elseif iii==2
                allocation_type='MT';
            elseif  iii==3
                allocation_type='PF';
            end
            allocation_begin_ue=zeros(1,num_subframe)+1;%分配用户初始化（仅用于RR算法）
            CQI=zeros(num_prb,num_ue); %CQI矩阵置0
            windows_band=20;%窗长
            windows_throuput_ue=zeros(1,num_ue)+1; %每个用户的窗吞吐量
            past_throuput_ue=zeros(1,num_ue);
            for TTI_ID=1:1:num_subframe
                CQI=SINR_mapping_CQI(prb_snr_TTI(:,:,1:TTI_ID),TTI_ID,num_ue,num_prb);
                % SINR 信号与干扰噪声比
               %% 调度算法[填充子函数：downlink_RR、downlink_PF、downlink_MT]
                if(strcmp(allocation_type,'RR'))%选择三种算法    strcmp是比较算法
%                     [allocation_RB,allocation_begin_ue(1,TTI_ID+1)]=downlink_RR(num_prb,num_ue,CQI(:,:),allocation_begin_ue(1,TTI_ID),num_symbol,num_subcarrier); 
                    [allocation_RB,allocation_begin_ue(1,TTI_ID+1)]=downlink_RR_1(num_prb,num_ue,CQI(:,:),allocation_begin_ue(1,TTI_ID),num_symbol,num_subcarrier);
                                                                                                   % 改进之后的RR算法 提高系统吞吐量
                elseif (strcmp(allocation_type,'PF'))
                    [allocation_RB]=downlink_PF(num_prb,num_ue,CQI(:,:),windows_throuput_ue,num_symbol,num_subcarrier);
%                     [allocation_RB]=downlink_PF_1(num_prb,num_ue,CQI(:,:),windows_throuput_ue,num_symbol,num_subcarrier);
                elseif (strcmp(allocation_type,'MT'))
%                    [allocation_RB]=downlink_MT(num_prb,num_ue,CQI(:,:),num_symbol,num_subcarrier);
                    [allocation_RB]=downlink_MT_1(num_prb,num_ue,CQI(:,:),num_symbol,num_subcarrier);% 改进之后的MT算法
                                                                                                     %    提高Jains指数
%                     [allocation_RB]=downlink_MT_2(num_prb,num_ue,CQI(:,:),num_symbol,num_subcarrier);%
%                     改进2.0失败了
                else error('NOT support this schedule way!');
                end

                %% 计算每个TTI内每个用户的吞吐量 吞吐量怎么和速率一样了 难道是因为rb单位化成1了 rb*rate就是所谓的吞吐量
                for jj=1:1:num_ue
                    ue_prb=find(allocation_RB(:,3)==jj);
                    num_ue_prb=length(ue_prb);
                    for i=1:1:num_ue_prb
                        sum_throuput_ue_perTTI(jj,TTI_ID,iii)=sum_throuput_ue_perTTI(jj,TTI_ID,iii)+allocation_RB(ue_prb(i),4);
                    end
                end

                %% 计算每个用户到当前TTI的累积吞吐量
                for jj=1:1:num_ue
                    sum_throuput_ue_until_TTI(jj,iii)=sum_throuput_ue_until_TTI(jj,iii)+sum_throuput_ue_perTTI(jj,TTI_ID,iii);
                end

               %% 计算用户的窗吞吐量【这一块精简版没有用到，可不看】
                for jj=1:1:num_ue    
                    if (TTI_ID<windows_band+1)
                        past_throuput_ue(jj)=sum_throuput_ue_until_TTI(jj,iii); %当前TTI不足窗长，当前TTI之前的吞吐量作为该用户的窗吞吐量
                    elseif (TTI_ID>windows_band)
                        past_throuput_ue(jj)=past_throuput_ue(jj)+sum_throuput_ue_perTTI(jj,TTI_ID,iii)-sum_throuput_ue_perTTI(jj,TTI_ID-windows_band,iii);%计算TTI大于窗长以后的每个用户的窗吞吐量
                    end
                    %windows_throuput_ue(jj)=past_throuput_ue(jj);
                    %windows_throuput_ue(jj)=(1-1/windows_band)*past_throuput_ue(jj)+(1/windows_band)*sum_throuput_ue_until_TTI(jj,iii);
                    windows_throuput_ue(jj)=(1-1/windows_band)*windows_throuput_ue(jj)+(1/windows_band)*sum_throuput_ue_until_TTI(jj,iii);
                    %windows_throuput_ue(jj)=(1-1/windows_band)*windows_throuput_ue(jj)+(1/windows_band)*sum_throuput_ue_perTTI(jj,TTI_ID,iii);
                end   
            end

            %% 计算实时业务用户在当前分配方式下的系统吞吐量
            sum_throuput_system_kbps_RT(iii,1)=sum(sum_throuput_ue_until_TTI(:,iii))/num_subframe; 
            %%  计算所有实时业务用户Jain指数
            Jain(iii,1)=(sum(sum_throuput_ue_until_TTI(:,iii)))^2/num_ue/sum(sum_throuput_ue_until_TTI(:,iii).^2);
        end
        
%从这里到的169行程序不看
        if num_ue==20
           save 20UE_sum_throuput_system_kbps_RT.txt sum_throuput_system_kbps_RT -ascii;
           save 20UE_Jain.txt Jain -ascii;
        elseif num_ue==30
           save 30UE_sum_throuput_system_kbps_RT.txt sum_throuput_system_kbps_RT -ascii;
           save 30UE_Jain.txt Jain -ascii;   
        elseif num_ue==40
           save 40UE_sum_throuput_system_kbps_RT.txt sum_throuput_system_kbps_RT -ascii;
           save 40UE_Jain.txt Jain -ascii;    
        elseif num_ue==50
           save 50UE_sum_throuput_system_kbps_RT.txt sum_throuput_system_kbps_RT -ascii;
           save 50UE_Jain.txt Jain -ascii;   
        elseif num_ue==60
           save 60UE_sum_throuput_system_kbps_RT.txt sum_throuput_system_kbps_RT -ascii;
           save 60UE_Jain.txt Jain -ascii;   
        elseif num_ue==70
           save 70UE_sum_throuput_system_kbps_RT.txt sum_throuput_system_kbps_RT -ascii;
           save 70UE_Jain.txt Jain -ascii;   
        elseif num_ue==80
           save 80UE_sum_throuput_system_kbps_RT.txt sum_throuput_system_kbps_RT -ascii;
           save 80UE_Jain.txt Jain -ascii; 
        elseif num_ue==90
           save 90UE_sum_throuput_system_kbps_RT.txt sum_throuput_system_kbps_RT -ascii;
           save 90UE_Jain.txt Jain -ascii; 
        elseif num_ue==100
           save 100UE_sum_throuput_system_kbps_RT.txt sum_throuput_system_kbps_RT -ascii;
           save 100UE_Jain.txt Jain -ascii; 
        end
    end
    sum_throuput_all(:,1,iiii)=load('20UE_sum_throuput_system_kbps_RT.txt');
    Jain_all(:,1,iiii)=load('20UE_Jain.txt');

    sum_throuput_all(:,2,iiii)=load('30UE_sum_throuput_system_kbps_RT.txt');
    Jain_all(:,2,iiii)=load('30UE_Jain.txt');

    sum_throuput_all(:,3,iiii)=load('40UE_sum_throuput_system_kbps_RT.txt');
    Jain_all(:,3,iiii)=load('40UE_Jain.txt');

    sum_throuput_all(:,4,iiii)=load('50UE_sum_throuput_system_kbps_RT.txt');
    Jain_all(:,4,iiii)=load('50UE_Jain.txt');

    sum_throuput_all(:,5,iiii)=load('60UE_sum_throuput_system_kbps_RT.txt');
    Jain_all(:,5,iiii)=load('60UE_Jain.txt');

    sum_throuput_all(:,6,iiii)=load('70UE_sum_throuput_system_kbps_RT.txt');
    Jain_all(:,6,iiii)=load('70UE_Jain.txt');

    sum_throuput_all(:,7,iiii)=load('80UE_sum_throuput_system_kbps_RT.txt');
    Jain_all(:,7,iiii)=load('80UE_Jain.txt');

    sum_throuput_all(:,8,iiii)=load('90UE_sum_throuput_system_kbps_RT.txt');
    Jain_all(:,8,iiii)=load('90UE_Jain.txt');

    sum_throuput_all(:,9,iiii)=load('100UE_sum_throuput_system_kbps_RT.txt');
    Jain_all(:,9,iiii)=load('100UE_Jain.txt');
end

for iii=1:1:num_algorithm
    for jjj=1:1:num_ue_set
        sum_throuput_average(iii,jjj)=mean(sum_throuput_all(iii,jjj,:))/1000;
        Jain_average(iii,jjj)=mean(Jain_all(iii,jjj,:));
    end
end

%% 画图
figure;
t=20:10:100;
plot(t,sum_throuput_average(1,:),'-s',t,sum_throuput_average(2,:),'-p',t,sum_throuput_average(3,:),'-o','linewidth',2);
%plot(t,sum_throuput_average(1,:),'-s',t,sum_throuput_average(2,:), '-p');
legend('RR','MT','PF');
%legend('RR','MT');
xlabel('系统接入非实时业务用户数（个）');
ylabel('系统吞吐量（Mbps）');
grid on;
hold on;

figure;
t=20:10:100;
plot(t,Jain_average(1,:),'-s',t,Jain_average(2,:),'-p',t,Jain_average(3,:),'-o','linewidth',2);
legend('RR','MT','PF');
% plot(t,Jain_average(1,:),'-s',t,Jain_average(2,:),'-p');
% legend('RR','MT');
xlabel('系统接入非实时业务用户数（个）');
ylabel('Jains指数');
grid on;
hold on;

