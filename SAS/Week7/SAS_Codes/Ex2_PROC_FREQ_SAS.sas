*Ex2_PROC_FREQ_SAS;
OPTIONS nonumber nodate ps=58 ls=90;
title1 'One-Way Table';
title2 'No option on the TABLES statement';
proc freq data=sashelp.heart;
tables sex weight_status bp_status;
run;

title1 'One-Way Table';
title2 'MISSING option';
proc freq data=sashelp.heart;
tables weight_status / missing;
run;

title1 'One-Way Table';
title2 'MISSPRINT option in the TABLES statement';
proc freq data=sashelp.heart;
tables weight_status / missing;
run;

title1 'Two-Way Table';
title2 ' ';
proc freq data=sashelp.heart;
tables weight_status*bp_status;
run;

title1 'Two-Way Table';
title2 'WHERE statement';
proc freq data=sashelp.heart;
tables weight_status*bp_status;
where sex='Male';
run;

title1 'Two-Way Table';
title2 'Suppress Percent';
proc freq data=sashelp.heart;
tables weight_status*bp_status/
       norow nocol nopercent;
run;

title1 'Two-Way Table';
title2 'Suppress Percent & Column Percent';
proc freq data=sashelp.heart;
tables weight_status*bp_status/
       norow nocol nopercent;
run;

title1 'Two-Way Table';
title2 'LIST Option';
proc freq data=sashelp.heart;
tables weight_status*bp_status/LIST
       norow nocol nopercent;
run;

title1 'NOPRINT Option with the TABLE Statement';
title2 'Count and Percent';
proc sort data=sashelp.heart
       (where=(weight_status ne ' '))
       out=heart_x;
by weight_status; run;
proc freq data=heart_x;
 by weight_status; 
 tables bp_status/noprint out=heart_out;
run;
proc print data=heart_out; run;


*proc freq with various options;

* Create formats, and the example-data;
proc format;
    value weight_fmt
       1 = 'Less than 90 lbs'
       2 = '90-<120 lbs'
       3 = '120-150 lbs';
run;
Data Class;
 SET sashelp.class;
	if weight <90 THEN weight_grp =1 ;
	else if 90<=weight<120 THEN weight_grp = 2;
	else if weight >= 120 THEN weight_grp = 3;
run;
title1 'One-Way Table No ORDER= Options';
title2 ' ';
proc freq data=class; 
 tables weight_grp;
 Format weight_grp weight_fmt.;
run;

title1 'One-Way Table ORDER= Formatted';
title2 'Formatted values appearing in the ascending order';
proc freq data=class ORDER= Formatted; 
 tables weight_grp;
 Format weight_grp weight_fmt.;
run;

title1 'One-Way Table ORDER= FREQ';
title2 'Order of categories based on frquencies'; 
title3 '(the category with the highest freqency appears first)';
proc freq data=class ORDER= FREQ; 
 tables weight_grp;
 Format weight_grp weight_fmt.;
run;
 /*cancel title2 and title3 */
 title2; title3;

*Adapted from SAS-L ;
*Contributed by data_null - 7/19/2016;
options nonumber nodate  ps=58 ls=90;
data Have;
  input Age   Regular_cnt;
datalines;
1    2814
2    2187
26   1976
51   345
52   678
;
proc format;
   value agegrp
      0-4 ='<5 Years'
      25-30 = '25-30 Years'
      51-High = '>50 Years';
   run;
title1 'WEIGHT Statement in PROC FREQ';
proc freq data=Have;
   tables age;
   format age agegrp.;
   weight regular_cnt;
   run;

*Calculations of relative Risk using PROC FREQ;
options nonumber nodate  ps=58 ls=90;
data have;
infile datalines firstobs=2;
Label cc='Exposed to Pancreas Cancer';
input Smoking_Status $ 1-10 cc $ 12-19 count 21-23;
datalines;
12345678901234567890123
Smokers    Cases     60
Smokers    Controls 100
Nonsmokers Cases     40
Nonsmokers Controls 300
;
title1 'Relative Risk, and Odds Ratio Calculations';
proc freq data=have;
tables smoking_status*cc /nocol nopercent relrisk;
weight count;
run;

