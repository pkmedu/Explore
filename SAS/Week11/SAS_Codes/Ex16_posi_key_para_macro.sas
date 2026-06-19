*Ex16_posi_key_para_macro.sas (Part 1);
options obs=5;
%macro printit(dsn);
  proc print data=&dsn;
  run;
%put _local_;
%mend printit;
%printit (sashelp.class)

*Ex16_posi_key_para_macro.sas (Part 2);
%MACRO printdata(dsn, num=);
  PROC PRINT DATA=&dsn (obs=&num) noobs;
RUN;
%MEND;
%printdata(SASHELP.CLASS, num=7)
%printdata(SASHELP.CARS, num=5)
%printdata(SASHELP.RETAIL, num=10)
