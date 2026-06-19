/* dm "clear log; clear output; clear odsresults"; */
options validvarname=any linesize=80;
libname new 'C:\Explore\BDMinorityData2025';

ods listing close;
ods html path="C:\Explore\BDMinorityData2025"
         file="BD_Minority_Victims_2025_rev.html"
         style=htmlblue;
title 'Religiously Motivated Violence Against Minorities in Bangladesh (Killings; Rape and Other Sexual Violence; Alleged Blasphemy- and Religion-Based Attacks; Religious Site and Property Damage; Land Grabbing), January 1–December 31, 2025';
proc sort data=new.EMB; by i_sn; run;

PROC REPORT DATA=new.EMB NOWINDOWS ;
COLUMNS i_sn district i_loc i_date i_description i_info_s;
DEFINE i_sn / DISPLAY 'Serial number' style(column)=[cellwidth=0.8in] ;
DEFINE district / DISPLAY 'District of incident' style(column)=[cellwidth=1in] ;
DEFINE i_loc / DISPLAY 'Detailed Incident location' style(column)=[cellwidth=3in] ;
DEFINE i_date / DISPLAY 'Date of incident' style(column)=[cellwidth=2.5in];
DEFINE i_description / DISPLAY 'Description of incidene' style(column)=[cellwidth=4.5in];
DEFINE i_info_s / DISPLAY 'Source of information' style(column)=[cellwidth=2in];
run;;
ods html close;
title;
ods listing;






