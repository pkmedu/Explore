/* dm "clear log; clear output; clear odsresults"; */
options validvarname=any linesize=80;
libname XL XLSX 'C:\Data\Original_EMB_rev.xlsx';
%macro make_sheet_list;
  %local i;
  %do i = 2 %to 72;
    XL."Table &i"n
  %end;
%mend;

data work.EMB;
  length i_sn 8 i_loc $80 i_date $80 i_description $500 i_info_s $80; 
  retain i_sn i_loc i_date i_description i_info_s;
  set %make_sheet_list ;
  if i_sn = . then delete;
run;


libname XL CLEAR;

ods listing close;
ods html path="C:\Explore\PythonScriptsBDM"
         file="BD_Minority_Victims_2025.html"
         style=htmlblue;
 title 'Religiously Motivated Violence Against Minorities in Bangladesh (Killings; Rape and Other Sexual Violence; Alleged Blasphemy- and Religion-Based Attacks; Religious Site and Property Damage; Land Grabbing), January 1–December 31, 2025';
proc sort data=work.EMB; by i_sn; run;

PROC REPORT DATA=work.EMB /*(where = (i_sn ne .))*/ NOWINDOWS ;
COLUMNS i_:;
DEFINE i_sn / DISPLAY 'Serial number' style(column)=[cellwidth=0.8in] ;
*DEFINE i_district / DISPLAY 'District' style(column)=[cellwidth=1in] ;
DEFINE i_loc / DISPLAY 'Incident location' style(column)=[cellwidth=3in] ;
DEFINE i_date / DISPLAY 'Date of incident' style(column)=[cellwidth=2.5in];
DEFINE i_description / DISPLAY 'Description of incidene' style(column)=[cellwidth=4.5in];
DEFINE i_info_s / DISPLAY 'Source of information' style(column)=[cellwidth=2in];
run;;
ods html close;
title;
ods listing;


proc contents data= work.EMB varnum;
ods select position;
run;



