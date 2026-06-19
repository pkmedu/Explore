options nocenter nonumber nodate;
options formchar="|----|+|---+=|-/\<>*";
ods trace on /listing;
PROC FREQ data=sashelp.heart;
 tables sex*status /chisq measures relrisk list nopercent nocum;
  run;
ods trace off;




ods exclude all; *to suppress the printed output;
PROC FREQ data=sashelp.heart;
 tables sex*status /chisq measures relrisk nopercent nocum;
 ods output CROSSTABFREQS = FREQS (keep=table sex status frequency);
 ods output CHISQ = PVAL (keep=table statistic prob where=(statistic = "Chi-Square"));
 ods output RELATIVERISKS = ODDS(where=(studytype="Case-Control (Odds Ratio)"));
 run;
ods select all; *restore the default printed output;
proc print data=FREQS; run;
proc print data=PVAL; run;
proc print data=odds; run;

