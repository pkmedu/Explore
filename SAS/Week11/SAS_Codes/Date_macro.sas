*Date_macro.sas;
*Saved in C:\SASCourse\Week9;
%macro date_macro;
 %sysfunc(left(%qsysfunc(date(),worddate18.)));
%mend date_macro;
