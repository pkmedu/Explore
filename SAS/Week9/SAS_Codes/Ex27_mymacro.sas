
*Ex27_mymacro.sas;
*Saved in C:\SASCourse\Week9;
%macro date_macro;
 %local word_date;
 %let word_date =  %sysfunc(left(%qsysfunc(date(),worddate18.)));
 %put &word_date;
%mend date_macro;
%date_macro
