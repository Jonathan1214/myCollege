function CQI=SINR_mapping_CQI(prb_snr_TTI,TTI_ID,num_ue,num_prb)
for i=1:num_ue
    for j=1:num_prb
       if prb_snr_TTI(j,i,TTI_ID) <-6.71
          CQI(j,i)=0;
      elseif  prb_snr_TTI(j,i,TTI_ID)<-5.11
             CQI(j,i)=1;
      elseif prb_snr_TTI(j,i,TTI_ID)<-3.15
             CQI(j,i)=2;
      elseif  prb_snr_TTI(j,i,TTI_ID)<-0.879
             CQI(j,i)=3;
      elseif  prb_snr_TTI(j,i,TTI_ID)<0.701
              CQI(j,i)=4;
      elseif  prb_snr_TTI(j,i,TTI_ID)<2.529
             CQI(j,i)=5;
      elseif  prb_snr_TTI(j,i,TTI_ID)<4.606
             CQI(j,i)=6;
      elseif  prb_snr_TTI(j,i,TTI_ID)<6.431
             CQI(j,i)=7;
      elseif  prb_snr_TTI(j,i,TTI_ID)<8.326
              CQI(j,i)=8;
     elseif  prb_snr_TTI(j,i,TTI_ID)<10.3
            CQI(j,i)=9;
     elseif  prb_snr_TTI(j,i,TTI_ID)<12.22
             CQI(j,i)=10;
     elseif  prb_snr_TTI(j,i,TTI_ID)<14.01
            CQI(j,i)=11;
     elseif prb_snr_TTI(j,i,TTI_ID)<15.81
            CQI(j,i)=12;
     elseif  prb_snr_TTI(j,i,TTI_ID)<17.68
            CQI(j,i)=13;
     elseif  prb_snr_TTI(j,i,TTI_ID)<19.61
            CQI(j,i)=14;
     else
           CQI(j,i)=15;
       end
    end
end