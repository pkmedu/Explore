*Ex5_Proc_Printto.sas;
options nocenter nodate nonumber;
DM 'clear log;  clear output; clear odsresults;';
FILENAME MYLOG 'C:\SASCourse\Week1\PP_log.TXT';
FILENAME MYPRINT 'C:\SASCourse\Week1\PP_OUTPUT.TXT';
PROC PRINTTO LOG=MYLOG PRINT=MYPRINT NEW;
RUN;


TITLE 'Listing from SASHELP.CLASS';
PROC PRINT data=sashelp.class;
RUN;




PROC PRINTTO;
RUN;
