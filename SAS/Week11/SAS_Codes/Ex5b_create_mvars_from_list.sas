*Ex5_create_mvars_from_list.sas;
dm "log; clear; output; clear; odsresults; clear;";
%Let Path = C:\Users\pmuhuri\SASCourse\Week11\SAS_Codes;
%let outd = 
Data h50 h60 h70 h79 h89 h97 h105 h113 h121 h129 h138 h147 h155 h163 h171 h181;
 some_date = '18May1990'd;
run;
%let ds1 = h50;
%let ds2 = h60;
%let ds3 = h70;
%let ds4 = h79;
%let ds4 = h79;
%let ds5 = h89;
%let ds6 = h97;
%let ds7 = h105;
%let ds8 = h113;
%let ds9 = h121;
%let ds10 = h129;
%let ds11 = h138;
%let ds12 = h147;
%let ds13 = h155;
%let ds14 = h163;
%let ds15 = h171;
%let ds16 = h181;
%let Total_ds = 16; 

%macro print(Total_ds);
%do i = 1 %to &Total_ds;
title "Sales &&ds&i";
proc print data = &&ds&i noobs;
run;
%end;
%mend print;
/* You can delete the following statement if you do not want to create the nonmacro code */
filename mprint "&Path\Ex5b_Generated_Code.sas";
%print(&Total_ds)
