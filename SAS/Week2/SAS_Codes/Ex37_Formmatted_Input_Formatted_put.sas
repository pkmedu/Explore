*Ex37_Formmatted_Input_Formatted_put.sas (Part 1);
options nocenter nodate nonumber nosource;
data Have1;
input @1 date1 date11.  +(-11) date2  date11. 
      +(-11) date3  date11. +(-11) date4  date11.;
Format date1 date11. date2 date9. date3 yymmdd10. date4 comma7.;
datalines;
29JAN2019
;
title 'Have1 Data Set';
proc print data=Have1;
var date:;
run;

*Ex37_Formmatted_Input_Formatted_put.sas (Part 2);
options nocenter nodate nonumber nosource;
data _null_;
date='29JAN2019'd;
put (4*date) (date11. +1 date9. +1 yymmdd10. +1 comma7. ) ;
run;
