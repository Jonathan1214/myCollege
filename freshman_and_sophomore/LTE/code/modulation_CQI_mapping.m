function [MCS_para,Qm,spectral_eff]=modulation_CQI_mapping(CQI)
if (CQI==0)
MCS_para=0;
Qm=0;
spectral_eff=0;
elseif (CQI==1)
    %MCS='QPSK';
    MCS_para=78;
    Qm=2;
    spectral_eff=0.1523;
elseif (CQI==2)
    %MCS='QPSK';
    MCS_para=120;
    Qm=2;
    spectral_eff=0.2344;
elseif (CQI==3)
    %MCS='QPSK';
    MCS_para=193;
    Qm=2;
    spectral_eff=0.3770;
elseif (CQI==4)
    %MCS='QPSK';
    MCS_para=308;
    Qm=2;
    spectral_eff=0.6016;
elseif (CQI==5)
    %MCS='QPSK';
    MCS_para=378;
    Qm=2;
    spectral_eff=0.8770;
elseif (CQI==6)
    %MCS='QPSK';
    MCS_para=602;
    Qm=2;
    spectral_eff=1.1758;
elseif (CQI==7)
    %MCS='16QAM';
    MCS_para=378;
    Qm=4;
    spectral_eff=1.4766;
elseif (CQI==8)
    %MCS='16QAM';
    MCS_para=490;
    Qm=4;%252bit/rb
    spectral_eff=1.9141;
elseif (CQI==9)
    %MCS='16QAM';
    MCS_para=616;
    Qm=4;
    spectral_eff=2.4063;
elseif (CQI==10)
    %MCS='64QAM';
    MCS_para=466;
    Qm=6;
    spectral_eff=2.7305;
elseif (CQI==11)
    %MCS='64QAM';
    MCS_para=567;
    Qm=6;
    spectral_eff=3.3223;
elseif (CQI==12)
   % MCS='64QAM';
    MCS_para=666;
    Qm=6;
    spectral_eff=3.9023;
elseif (CQI==13)
    %MCS='64QAM';
    MCS_para=772;
    Qm=6;
    spectral_eff=4.5234;
elseif (CQI==14)
    %MCS='64QAM';
    MCS_para=873;
    Qm=6;
    spectral_eff=5.1152;
elseif (CQI==15)
    %MCS='64QAM';
    MCS_para=948;
    Qm=6;
    spectral_eff=5.5547;
end

