
```sas
dm "log; clear; output; clear; odsresults; clear;"
options nodate nonumber nodate;
Libname xl xlsx "C:\SESUG_2023\SAS_Solution_WS_2023-09-10.xlsx";
data MEPS_file_list;
 set xl."Sheet1"n;
run;

%macro runit (df=, string=);
data &df;
 set MEPS_file_list;
 keep data_year puf_num ;
   where prxmatch("m/&string/oi", meps_file) and
   file_format='SAS transport format';
run;
proc sort data=&df nodupkey;  by  puf_num; run;
%mend runit;
%runit(df=er,string=Emergency)
%runit(df=ip,string=inpatient)
%runit(df=op,string=outpatient)
%runit(df=ob,string=office-based)
%runit(df=rx,string=prescribed)
%runit(df=hh,string=home)
%runit(df=dn,string=dental)
```
