
%let path = C:\Users\Pradip.Muhuri\OneDrive - HHS Office of the Secretary\HomeDrive1;
%let xpath = C:\Users\Pradip.Muhuri\OneDrive - HHS Office of the Secretary\HomeDrive2;


FILENAME MYLOG "&xpath.\_SMIF\Output\_2021MeanMedianExp_MEPS_13_log.TXT";
FILENAME MYPRINT "&xpath.\_SMIF\Output\2021MeanMedianExp_MEPS_13_output.TXT";
PROC PRINTTO LOG=MYLOG PRINT=MYPRINT NEW;
RUN;

libname library "&Path\_SMIF\SDS";
libname new "&Path\_SMIF\SDS";
libname sds "&Path\A_PSAQ\SAS_Data_Catalogs";


PROC FORMAT;
  VALUE agecat_fmt
        0-34 = '0-34'
       35-high = '35+';
run;

ods exclude none; 
ods graphics off;
title ;
PROC SURVEYMEANS DATA=new.PSAQ_Frame  nobs mean q1 median q3;
    VAR totexp13 obtotv13 ;
    STRATUM VARSTR;
    CLUSTER VARPSU;
    WEIGHT perwt13f;
	domain age_35plus('1')*Frame('1');
		  ods output domain=mean_frame domainquantiles=med_frame;
RUN;

/*
title ' PSAQ frame';
proc print data=WORK.mean_frame; 
 var DomainLabel   N  Mean  StdErr;
 run;
proc print data=WORK.med_frame;  
var  DomainLabel Percentile Estimate StdErr  LowerCL  UpperCL;
run;
*/

PROC SURVEYMEANS DATA=sds.MEPS_WShop_PSAQ  nobs mean stderr q1 median q3;
    VAR totexp14 ;
    STRATUM VARSTR;
    CLUSTER VARPSU;
    WEIGHT psaqwt;
	domain age_35plus('1');
		  ods output domain=mean_frame domainquantiles=med_frame;
RUN;



proc printto;
run;
