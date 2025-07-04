*Figure3_Mean_Expenses.sas;
options nosource nodate nonumber nonotes nocenter;
LIBNAME new "U:\_Flu\SDS";
ods listing;
ods graphics off;
ods exclude summary statistics;
title 'Figure 3A - Mean Expenses for all Services Combined per Person';
proc surveymeans data=new.person16_17 nobs  sumwgt mean stderr sum ;
  stratum varstr;
  cluster varpsu;
  weight perwtf_16_17;
  var  g_AL_totexp;
domain flu('1');
run;

options nosource nodate nonumber nonotes nocenter;
LIBNAME new "U:\_Flu\SDS";
ods listing;
ods graphics off;
ods exclude summary statistics;
title 'Figure 3B - Mean Expenses per Person with an Ambulatory Visit';
proc surveymeans data=new.person16_17 nobs  mean stderr sum ;
  stratum varstr;
  cluster varpsu;
  weight perwtf_16_17;
  var  g_AM_totexp;
domain flu('1')*max_ob_op('1');
run;

options nosource nodate nonumber nonotes nocenter;
LIBNAME new "U:\_Flu\SDS";
ods listing;
ods graphics off;
ods exclude summary statistics;
title 'Figure 3C - Mean Expenses Per Person with a Prescription Fill';
proc surveymeans data=new.person16_17 nobs  mean stderr sum ;
  stratum varstr;
  cluster varpsu;
  weight perwtf_16_17;
  var  g_RX_totexp;
domain flu('1')*max_RX('1');
run;

options nosource nodate nonumber nonotes nocenter;
LIBNAME new "U:\_Flu\SDS";
ods listing;
ods graphics off;
ods exclude summary statistics;
title 'Figure 3D - Mean Expenses Per Person with an ER visit';
proc surveymeans data=new.person16_17 nobs  mean stderr sum ;
  stratum varstr;
  cluster varpsu;
  weight perwtf_16_17;
  var  g_ER_totexp;
 domain flu('1')*max_ER('1');
run;
