DM 'output' clear;
DM 'log' clear;
proc datasets kill nolist nodetails; quit;
*Example_Surveymeans_ODS.sas;
OPTIONS nocenter obs=max ps=58 ls=132 nodate nonumber ;
libname out "U:\A_DataRequest";
libname library "U:\A_DataRequest";
proc datasets kill nolist nodetails; quit;
ods graphics off;
ods trace on /listing;
proc surveymeans data=out.MEPS_FYC_2014 nobs nmiss mean clm ;
  			stratum varstr;
  			cluster varpsu;
  			weight perwt14f ;
  			var TOTEXP14;
  			domain age_grp (perwt14f>0, TOTEXP14) 
                   sex (perwt14f>0, TOTEXP14)
                   r_RTHLTH (perwt14f>0, TOTEXP14)
                   r_CSHCN(perwt14f>0, TOTEXP14) ;
ods output Statistics=out.ALL_FYC14 domain=out.Stat_FY14;
run;
ods trace off;
data work.FYC14;
  set out.ALL_Y14 out.Stat_Y14;
run;
proc print data=work.FYC14; run;

ods graphics off;
ods trace on /listing;
proc surveymeans data=out.MEPS_FYC_2014 mean clm median;
  stratum varstr;
  cluster varpsu;
  weight perwt14f;
  var TOTEXP14 obvexp14;
  domain sex*r_CSHCN;
  ods output Statistics=stats 
             quantiles=median 
             domain=domain 
             domainquantiles=dquant;
  run;






