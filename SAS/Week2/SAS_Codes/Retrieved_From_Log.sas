    Data PS.All_Conds;
      Merge PS.SP_19_C7_MENTAL_DIS (keep=dupersid x_al_totexp
                                         &common_vars
                                       rename=(x_al_totexp=MENTAL
                                          AL_totexp=AL_totexp_mental
                                          OB_totexp=OB_totexp_mental
                                          OP_totexp=OP_totexp_mental
                                          RX_totexp=RX_totexp_mental
                                          ER_totexp=ER_totexp_mental
                                          IP_totexp=IP_totexp_mental
                                          HH_totexp=HH_totexp_mental))
   
      PS.SP_19_C3_ARTHRIIS (keep= dupersid x_al_totexp &common_vars
                                rename=(x_al_totexp=ARTHRIIS
                                AL_totexp=AL_totexp_ARTHRIIS
                                          OB_totexp=OB_totexp_ARTHRIIS
                                          OP_totexp=OP_totexp_ARTHRIIS
                                          RX_totexp=RX_totexp_ARTHRIIS
                                          ER_totexp=ER_totexp_ARTHRIIS
                                          IP_totexp=IP_totexp_ARTHRIIS
                                          HH_totexp=HH_totexp_mental))
   
      PS.SP_19_C1_HYPERTENSION (keep= dupersid x_al_totexp &common_vars
                             rename=(x_al_totexp=HYPERTENSION
                             AL_totexp=AL_totexp_HYPERTENSION
                                          OB_totexp=OB_totexp_HYPERTENSION
                                          OP_totexp=OP_totexp_HYPERTENSION
                                          RX_totexp=RX_totexp_HYPERTENSION
                                          ER_totexp=ER_totexp_HYPERTENSION
                                          IP_totexp=IP_totexp_HYPERTENSION
                                          HH_totexp=HH_totexp_HYPERTENSION))
   
   
      PS.SP_19_C8_ASTHMA (keep= dupersid x_al_totexp &common_vars
                             rename=(x_al_totexp=ASTHMA
                             AL_totexp=AL_totexp_ASTHMA
                                          OB_totexp=OB_totexp_ASTHMA
                                          OP_totexp=OP_totexp_ASTHMA
                                          RX_totexp=RX_totexp_ASTHMA
                                          ER_totexp=ER_totexp_ASTHMA
                                          IP_totexp=IP_totexp_ASTHMA
                                          HH_totexp=HH_totexp_ASTHMA))
      PS.SP_19_C2_HYPERLIDEMIA (keep= dupersid x_al_totexp &common_vars
                             rename=(x_al_totexp=HYPERLIDEMIA
                            AL_totexp=AL_totexp_HYPERLIDEMIA
                                          OB_totexp=OB_totexp_HYPERLIDEMIA
                                          OP_totexp=OP_totexp_HYPERLIDEMIA
                                          RX_totexp=RX_totexp_HYPERLIDEMIA
                                          ER_totexp=ER_totexp_HYPERLIDEMIA
                                          IP_totexp=IP_totexp_HYPERLIDEMIA
                                          HH_totexp=HH_totexp_HYPERLIDEMIA))
   
   
      PS.SP_19_C4_HEART_DIS (keep= dupersid x_al_totexp &common_vars
                           rename=(x_al_totexp=HEART_DIS
                           AL_totexp=AL_totexp_HEART_DIS
                                          OB_totexp=OB_totexp_HEART_DIS
                                          OP_totexp=OP_totexp_HEART_DIS
                                          RX_totexp=RX_totexp_HEART_DIS
                                          ER_totexp=ER_totexp_HEART_DIS
                                          IP_totexp=IP_totexp_HEART_DIS
                                          HH_totexp=HH_totexp_HEART_DIS))
   
   
      PS.SP_19_C6_CANCER (keep= dupersid x_al_totexp &common_vars
                        rename=(x_al_totexp=CANCER
                        AL_totexp=AL_totexp_cancer
                                          OB_totexp=OB_totexp_cancer
                                          OP_totexp=OP_totexp_cancer
                                          RX_totexp=RX_totexp_cancer
                                          ER_totexp=ER_totexp_cancer
                                          IP_totexp=IP_totexp_cancer
                                          HH_totexp=HH_totexp_cancer))
   
   PS.SP_19_C5_DIABETES (keep= dupersid x_al_totexp &common_vars
                        rename=(x_al_totexp=DIABETES
                                          AL_totexp=AL_totexp_diabetes
                                          OB_totexp=OB_totexp_diabetes
                                          OP_totexp=OP_totexp_diabetes
                                          RX_totexp=RX_totexp_diabetes
                                          ER_totexp=ER_totexp_diabetes
                                          IP_totexp=IP_totexp_diabetes
                                          HH_totexp=HH_totexp_diabetes))
      PS.SP_19_C9_Other (keep= dupersid x_al_totexp &common_vars
                                 rename=(x_al_totexp=Other
                                          AL_totexp=AL_totexp_other
                                          OB_totexp=OB_totexp_other
                                          OP_totexp=OP_totexp_other
                                          RX_totexp=RX_totexp_other
                                          ER_totexp=ER_totexp_other
                                          IP_totexp=IP_totexp_other
                                          HH_totexp=HH_totexp_other))
      PS.FYC_19 (in=a);
      by dupersid;
    if a;
   run;
   
   Data PS.All_Conds_x;
    set PS.All_Conds;
    length list $100;
    array cond (*) MENTAL ARTHRIIS HYPERTENSION ASTHMA HYPERLIDEMIA
                   HEART_DIS CANCER DIABETES  Other;
    do i = 1 to 8;
     if cond(i) = 1 then
         list = catx(",", list, vname(cond(i)));
    end;
    count_cond = countw(list, ' ,');
   
   array a_cond [*] AL_totexp_mental AL_totexp_ARTHRIIS
                          AL_totexp_HYPERTENSION AL_totexp_ASTHMA
                          AL_totexp_HYPERLIDEMIA AL_totexp_HEART_DIS
                          AL_totexp_cancer AL_totexp_diabetes AL_totexp_other
   
                          ob_totexp_mental ob_totexp_ARTHRIIS
                          ob_totexp_HYPERTENSION ob_totexp_ASTHMA
                          ob_totexp_HYPERLIDEMIA ob_totexp_HEART_DIS
                          ob_totexp_cancer ob_totexp_diabetes ob_totexp_other
   
                          op_totexp_mental op_totexp_ARTHRIIS
                          op_totexp_HYPERTENSION op_totexp_ASTHMA
                          op_totexp_HYPERLIDEMIA op_totexp_HEART_DIS
                          op_totexp_cancer op_totexp_diabetes op_totexp_other
   
                          ip_totexp_mental ip_totexp_ARTHRIIS
                         ip_totexp_HYPERTENSION ip_totexp_ASTHMA
                         ip_totexp_HYPERLIDEMIA ip_totexp_HEART_DIS
                         ip_totexp_cancer ip_totexp_diabetes ip_totexp_other
  
                         er_totexp_mental er_totexp_ARTHRIIS
                         er_totexp_HYPERTENSION er_totexp_ASTHMA
                         er_totexp_HYPERLIDEMIA er_totexp_HEART_DIS
                         er_totexp_cancer er_totexp_diabetes er_totexp_other
  
                         rx_totexp_mental rx_totexp_ARTHRIIS
                         rx_totexp_HYPrxTENSION rx_totexp_ASTHMA
                         rx_totexp_HYPrxLIDEMIA rx_totexp_HEART_DIS
                         rx_totexp_cancrx rx_totexp_diabetes rx_totexp_other;
  
  array x_cond [*] c_AL_totexp_mental c_AL_totexp_ARTHRIIS
                         c_AL_totexp_HYPERTENSION c_AL_totexp_ASTHMA
                         c_AL_totexp_HYPERLIDEMIA c_AL_totexp_HEART_DIS
                         c_AL_totexp_cancer c_AL_totexp_diabetes c_AL_totexp_other
  
                         c_ob_totexp_mental c_ob_totexp_ARTHRIIS
                         c_ob_totexp_HYPERTENSION c_ob_totexp_ASTHMA
                         c_ob_totexp_HYPERLIDEMIA c_ob_totexp_HEART_DIS
                         c_ob_totexp_cancer c_ob_totexp_diabetes c_ob_totexp_other
  
  
                         c_op_totexp_mental c_op_totexp_ARTHRIIS
                         c_op_totexp_HYPERTENSION c_op_totexp_ASTHMA
                         c_op_totexp_HYPERLIDEMIA c_op_totexp_HEART_DIS
                         c_op_totexp_cancer c_op_totexp_diabetes c_op_totexp_other
  
  
                         c_ip_totexp_mental c_ip_totexp_ARTHRIIS
                         c_ip_totexp_HYPERTENSION c_ip_totexp_ASTHMA
                         c_ip_totexp_HYPERLIDEMIA c_ip_totexp_HEART_DIS
                         c_ip_totexp_cancer c_ip_totexp_diabetes c_ip_totexp_other
  
                         c_er_totexp_mental c_er_totexp_ARTHRIIS
                         c_er_totexp_HYPERTENSION c_er_totexp_ASTHMA
                         c_er_totexp_HYPERLIDEMIA c_er_totexp_HEART_DIS
                         c_er_totexp_cancer c_er_totexp_diabetes c_er_totexp_other
  
  
                         c_rx_totexp_mental c_rx_totexp_ARTHRIIS
                         c_rx_totexp_HYPERTENSION c_rx_totexp_ASTHMA
                         c_rx_totexp_HYPERLIDEMIA c_rx_totexp_HEART_DIS
                         c_rx_totexp_cancer c_rx_totexp_diabetes c_rx_totexp_other
                         ;
  
  
   do i = 1 to dim(a_cond);
    if a_cond[i] = 0 then x_cond[i] = .;
    else x_cond[i] = a_cond[i];
   end;
  
  
  AL_1_8_conds_totexp= sum(AL_totexp_mental, AL_totexp_ARTHRIIS
                         ,AL_totexp_HYPERTENSION, AL_totexp_ASTHMA
                         ,AL_totexp_HYPERLIDEMIA, AL_totexp_HEART_DIS
                         ,AL_totexp_cancer, AL_totexp_diabetes);
  
  OB_1_8_conds_totexp= sum(ob_totexp_mental, ob_totexp_ARTHRIIS
                         ,ob_totexp_HYPERTENSION, ob_totexp_ASTHMA
                         ,ob_totexp_HYPERLIDEMIA, ob_totexp_HEART_DIS
                         ,ob_totexp_cancer, ob_totexp_diabetes);
  
  c_AL_1_8_totexp= sum(c_AL_totexp_mental, c_AL_totexp_ARTHRIIS
                         ,c_AL_totexp_HYPERTENSION, c_AL_totexp_ASTHMA
                         ,c_AL_totexp_HYPERLIDEMIA, c_AL_totexp_HEART_DIS
                         ,c_AL_totexp_cancer, c_AL_totexp_diabetes);
  
  c_OB_1_8_totexp= sum(c_ob_totexp_mental, c_ob_totexp_ARTHRIIS
                         ,c_ob_totexp_HYPERTENSION, c_ob_totexp_ASTHMA
                         ,c_ob_totexp_HYPERLIDEMIA, c_ob_totexp_HEART_DIS
                         ,c_ob_totexp_cancer, c_ob_totexp_diabetes);
  
  c_op_1_8_totexp= sum(c_op_totexp_mental, c_op_totexp_ARTHRIIS
                         ,c_op_totexp_HYPERTENSION, c_op_totexp_ASTHMA
                         ,c_op_totexp_HYPERLIDEMIA, c_op_totexp_HEART_DIS
                         ,c_op_totexp_cancer, c_op_totexp_diabetes);
  
  c_ip_1_8_totexp= sum(c_ip_totexp_mental, c_ip_totexp_ARTHRIIS
                         ,c_ip_totexp_HYPERTENSION, c_ip_totexp_ASTHMA
                         ,c_ip_totexp_HYPERLIDEMIA, c_ip_totexp_HEART_DIS
                         ,c_ip_totexp_cancer, c_ip_totexp_diabetes);
  
  c_er_1_8_totexp= sum(c_er_totexp_mental, c_er_totexp_ARTHRIIS
                         ,c_er_totexp_HYPERTENSION, c_er_totexp_ASTHMA
                         ,c_er_totexp_HYPERLIDEMIA, c_er_totexp_HEART_DIS
                         ,c_er_totexp_cancer, c_er_totexp_diabetes);
  
  c_rx_1_8_totexp= sum(c_rx_totexp_mental, c_rx_totexp_ARTHRIIS
                         ,c_rx_totexp_HYPERTENSION, c_rx_totexp_ASTHMA
                         ,c_rx_totexp_HYPERLIDEMIA, c_rx_totexp_HEART_DIS
                         ,c_rx_totexp_cancer, c_rx_totexp_diabetes);
  
  count_cond_x = count_cond;
  if count_cond = 0 and other = 1 then count_cond_x = 9;
  else if count_cond = 0 and other = 0 then count_cond_x = .;
  
  count_cond_8 = count_cond;
  if count_cond = 0 then count_cond_8=.;
  
  run;
  ods select all;
  title 'agelast >=65 and perwtf  >0';
  proc freq data=PS.All_Conds_x order=freq;
  tables count_cond:  list
       /list missing;
  
  where agelast >=65 and perwtf  >0 ;
  run;
  title 'agelast >=65 and perwtf  >0 & other=0';
  proc freq data=PS.All_Conds_x order=freq;
  tables  List*count_cond*other/list missing nocum nopercent;
  where agelast >=65 and perwtf  >0 & other=0;
  run;
  title 'agelast >=65 and perwtf  >0 & other=1';
  proc freq data=PS.All_Conds_x order=freq;
  tables List*count_cond*other/list missing nocum nopercent;
  where agelast >=65 and perwtf  >0 & other=1 ;
  run;
  
  title 'agelast >=65 and perwtf  >0 & other=1';
  proc freq data=PS.All_Conds_x order=freq;
  tables List*count_cond*other/list missing nocum nopercent;
  where agelast >=65 and perwtf  >0 & other=1 ;
  run;
  title;
  
  proc printto;
  run;
