
FILENAME MYLOG "U:\A_DataRequest\count_cluster_log.TXT";
FILENAME MYPRINT "U:\A_DataRequest\count_cluster_output.TXT";
PROC PRINTTO LOG=MYLOG PRINT=MYPRINT NEW;
RUN;
libname new "S:\CFACT\Shared\PUF SAS Files\SAS V8";
options center nonumber nodate options formchar="|----|+|---+=|-/\<>*";
ODS HTML CLOSE;
ODS LISTING;
%macro printit (year, ds);
title "MEPS Full Year Consolidated File, &year";
proc sql ;
   select count(distinct varstr) as count_varstr, 
         count(distinct varpsu) as count_varpsu,
		 count(distinct cats(varstr,varpsu)) as count_str_psu
		 from new.&ds;
quit;
%mend printit;
%printit (2013, h163)
%printit (2014, h171)
%printit (2015, h181)
%printit (2016, h192)
%printit (2017, h201)

;
proc printto;
run;
