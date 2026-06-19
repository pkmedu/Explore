
options nocenter nodate nonumber obs=max 
       formchar="|----|+|---+=|-/\<>*";
libname library 'C:\Data';
libname sds 'C:\Data\SDS_Folder' access=readonly;  
%let kept_vars = dupersid resp53 perwt13f varstr varpsu 
                 agelast sex INSURC13 edrecode povcat13 
                 racethx resp53 RTHLTH53 totexp13 OBVEXP13 
                 OPTEXP13 ERTEXP13  IPTEXP13 RXEXP13
				 MARRY53X FAMSZE53 EMPST53 REGION53
				 inscov13 obtotv13 IPNGTD13
                 panel insc1231;
data h163_few_vars;
 set sds.h163 (keep=&kept_vars);
run;
options nocenter nonumber nodate;
ods select variables;
proc contents data=h163_few_vars;
run;
ods select default;

ods select variables;
proc contents data=SDS.h173; 
run;
ods select default;
