%�޸����ڣ�2018-09-21
clc;
clear all; 
close all;
format long
%��������
num_prb=15;
num_subframe=30; %��ʱ϶�����޸ķ�Χ[1-100],�鿴Ч��
num_symbol=14;  %һ����֡��OFDM������ 
num_subcarrier=12;%ÿ��RBЯ�������ز���
num_ue_add=10;  %ÿ�����ӵ��û�����
num_simulate=9; %����Ĵ���
num_ue_set=9;   %�����û���Ŀ�Ĵ���
num_algorithm=3;%�����㷨�Ƚ�

%��ʼ��
sum_throuput_all=zeros(num_algorithm,num_ue_set,num_simulate);
Jain_all=zeros(num_algorithm,num_ue_set,num_simulate);
sum_throuput_average=zeros(num_algorithm,num_ue_set);
Jain_average=zeros(num_algorithm,num_ue_set);

%% �����̶��û��ŵ�
for iiii=1:1:num_simulate
   num_ue=10;
   %ģ��ÿ��PRB(RB)������������
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
        %ģ��ÿ��PRB(RB)�����������ɣ�������
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
        %% ԭ�е��û��ŵ��������ӵ��û��ŵ�����һ��
        prb_snr_TTI=cat(2,prb_snr_TTI,prb_snr_TTI_add);

        %% ���������ʼ��
        sum_throuput_ue_perTTI=zeros(num_ue,num_subframe,num_algorithm);%ÿ��TTI��ÿ���û���������
        sum_throuput_ue_until_TTI=zeros(num_ue,num_algorithm);%�����û�����ǰTTI���ۻ�������
        sum_throuput_total_all_TTI_RT=zeros(num_algorithm,1);%�����û�������TTI�ڵ�������
        sum_throuput_system_kbps_RT=zeros(num_algorithm,1);%ϵͳ������
        Jain=zeros(num_algorithm,1);
%----------------------------------�����￪ʼ------------------------------%
        for iii=1:1:num_algorithm
            if iii==1
                allocation_type='RR';
            elseif iii==2
                allocation_type='MT';
            elseif  iii==3
                allocation_type='PF';
            end
            allocation_begin_ue=zeros(1,num_subframe)+1;%�����û���ʼ����������RR�㷨��
            CQI=zeros(num_prb,num_ue); %CQI������0
            windows_band=20;%����
            windows_throuput_ue=zeros(1,num_ue)+1; %ÿ���û��Ĵ�������
            past_throuput_ue=zeros(1,num_ue);
            for TTI_ID=1:1:num_subframe
                CQI=SINR_mapping_CQI(prb_snr_TTI(:,:,1:TTI_ID),TTI_ID,num_ue,num_prb);
                % SINR �ź������������
               %% �����㷨[����Ӻ�����downlink_RR��downlink_PF��downlink_MT]
                if(strcmp(allocation_type,'RR'))%ѡ�������㷨    strcmp�ǱȽ��㷨
%                     [allocation_RB,allocation_begin_ue(1,TTI_ID+1)]=downlink_RR(num_prb,num_ue,CQI(:,:),allocation_begin_ue(1,TTI_ID),num_symbol,num_subcarrier); 
                    [allocation_RB,allocation_begin_ue(1,TTI_ID+1)]=downlink_RR_1(num_prb,num_ue,CQI(:,:),allocation_begin_ue(1,TTI_ID),num_symbol,num_subcarrier);
                                                                                                   % �Ľ�֮���RR�㷨 ���ϵͳ������
                elseif (strcmp(allocation_type,'PF'))
                    [allocation_RB]=downlink_PF(num_prb,num_ue,CQI(:,:),windows_throuput_ue,num_symbol,num_subcarrier);
%                     [allocation_RB]=downlink_PF_1(num_prb,num_ue,CQI(:,:),windows_throuput_ue,num_symbol,num_subcarrier);
                elseif (strcmp(allocation_type,'MT'))
%                    [allocation_RB]=downlink_MT(num_prb,num_ue,CQI(:,:),num_symbol,num_subcarrier);
                    [allocation_RB]=downlink_MT_1(num_prb,num_ue,CQI(:,:),num_symbol,num_subcarrier);% �Ľ�֮���MT�㷨
                                                                                                     %    ���Jainsָ��
%                     [allocation_RB]=downlink_MT_2(num_prb,num_ue,CQI(:,:),num_symbol,num_subcarrier);%
%                     �Ľ�2.0ʧ����
                else error('NOT support this schedule way!');
                end

                %% ����ÿ��TTI��ÿ���û��������� ��������ô������һ���� �ѵ�����Ϊrb��λ����1�� rb*rate������ν��������
                for jj=1:1:num_ue
                    ue_prb=find(allocation_RB(:,3)==jj);
                    num_ue_prb=length(ue_prb);
                    for i=1:1:num_ue_prb
                        sum_throuput_ue_perTTI(jj,TTI_ID,iii)=sum_throuput_ue_perTTI(jj,TTI_ID,iii)+allocation_RB(ue_prb(i),4);
                    end
                end

                %% ����ÿ���û�����ǰTTI���ۻ�������
                for jj=1:1:num_ue
                    sum_throuput_ue_until_TTI(jj,iii)=sum_throuput_ue_until_TTI(jj,iii)+sum_throuput_ue_perTTI(jj,TTI_ID,iii);
                end

               %% �����û��Ĵ�����������һ�龫���û���õ����ɲ�����
                for jj=1:1:num_ue    
                    if (TTI_ID<windows_band+1)
                        past_throuput_ue(jj)=sum_throuput_ue_until_TTI(jj,iii); %��ǰTTI���㴰������ǰTTI֮ǰ����������Ϊ���û��Ĵ�������
                    elseif (TTI_ID>windows_band)
                        past_throuput_ue(jj)=past_throuput_ue(jj)+sum_throuput_ue_perTTI(jj,TTI_ID,iii)-sum_throuput_ue_perTTI(jj,TTI_ID-windows_band,iii);%����TTI���ڴ����Ժ��ÿ���û��Ĵ�������
                    end
                    %windows_throuput_ue(jj)=past_throuput_ue(jj);
                    %windows_throuput_ue(jj)=(1-1/windows_band)*past_throuput_ue(jj)+(1/windows_band)*sum_throuput_ue_until_TTI(jj,iii);
                    windows_throuput_ue(jj)=(1-1/windows_band)*windows_throuput_ue(jj)+(1/windows_band)*sum_throuput_ue_until_TTI(jj,iii);
                    %windows_throuput_ue(jj)=(1-1/windows_band)*windows_throuput_ue(jj)+(1/windows_band)*sum_throuput_ue_perTTI(jj,TTI_ID,iii);
                end   
            end

            %% ����ʵʱҵ���û��ڵ�ǰ���䷽ʽ�µ�ϵͳ������
            sum_throuput_system_kbps_RT(iii,1)=sum(sum_throuput_ue_until_TTI(:,iii))/num_subframe; 
            %%  ��������ʵʱҵ���û�Jainָ��
            Jain(iii,1)=(sum(sum_throuput_ue_until_TTI(:,iii)))^2/num_ue/sum(sum_throuput_ue_until_TTI(:,iii).^2);
        end
        
%�����ﵽ��169�г��򲻿�
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

%% ��ͼ
figure;
t=20:10:100;
plot(t,sum_throuput_average(1,:),'-s',t,sum_throuput_average(2,:),'-p',t,sum_throuput_average(3,:),'-o','linewidth',2);
%plot(t,sum_throuput_average(1,:),'-s',t,sum_throuput_average(2,:), '-p');
legend('RR','MT','PF');
%legend('RR','MT');
xlabel('ϵͳ�����ʵʱҵ���û���������');
ylabel('ϵͳ��������Mbps��');
grid on;
hold on;

figure;
t=20:10:100;
plot(t,Jain_average(1,:),'-s',t,Jain_average(2,:),'-p',t,Jain_average(3,:),'-o','linewidth',2);
legend('RR','MT','PF');
% plot(t,Jain_average(1,:),'-s',t,Jain_average(2,:),'-p');
% legend('RR','MT');
xlabel('ϵͳ�����ʵʱҵ���û���������');
ylabel('Jainsָ��');
grid on;
hold on;

