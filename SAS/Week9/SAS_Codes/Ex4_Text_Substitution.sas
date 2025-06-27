*Ex4_Text_Substitution.sas (Part 1);
***Part 1: No macro variables used;
proc means data=SASHELP.CLASS; 
run;
title "Data Set: SASHELP.CLASS";
proc print data=SASHELP.CLASS (obs = 5); 
run;

*Ex4_Text_Substitution.sas (Part 2);
***Part 2: Macro variables used;
options nocenter nodate nonumber symbolgen;
%let dsn = SASHELP.CLASS;
%let HowMany = 5;
%put _user_;
proc means data=&dsn; 
run;
title "Data Set: &dsn";
proc print data=&dsn (obs = &HowMany); 
run;
