*Ex5_Proc_Printto.sas;
dm "log; clear; output; clear; odsresults; clear;" ;
*ods results off;
options nocenter nodate nonumber;
options formchar="|----|+|---+=|-/\<>*";
/* How to redirect the log and output to external text files using PROC PRINTTO */
/* Variant 1: Non-macro code snippet. Compare with Variant 2 below. */

FILENAME MYLOG 'C:\users\pmuhuri\SASCourse\Week1\SAS_Codes\pmuhuri_Test3_log.TXT';
FILENAME MYPRINT 'C:\users\pmuhuri\SASCourse\Week1\SAS_Codes\pmuhuri_Test3_OUTPUT.TXT';
PROC PRINTTO LOG=MYLOG PRINT=MYPRINT NEW;
RUN;

TITLE 'Listing from SASHELP.CLASS';
PROC PRINT data=sashelp.class;
RUN;

PROC PRINTTO;
RUN;


/* How to redirect the log and output to external text files using PROC PRINTTO */
/* Variant 2:  The macro code snippet below adds macro variables, making the code more flexible and reusable.*/

ods results off;
options nocenter nodate nonumber nosymbolgen;
options formchar="|----|+|---+=|-/\<>*";
%let path = C:\users\pmuhuri\SASCourse\Week1\SAS_Codes;
%let myname = pmuhur;

FILENAME MYLOG "&path.\&myname._Test3x_log.TXT";
FILENAME MYPRINT "&path.\&myname._Test3x_OUTPUT.TXT";
PROC PRINTTO LOG=MYLOG PRINT=MYPRINT NEW;
RUN;

TITLE 'Listing from SASHELP.CLASS';
PROC PRINT data=sashelp.class;
RUN;

PROC PRINTTO;
RUN;
