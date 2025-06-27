
proc means data=SASHELP.CLASS;
  var age;
 output out=dsn_means;
run;
proc print data=dsn_means; run;

data _NULL_;
 set dsn_means (where=(_STAT_="MEAN"));
 CALL SYMPUTX ("ave_age", input(age, 8.0));
 CALL SYMPUTX ("ave_age_ch", put(age, 8.0));
 run;
%put &=ave_age;
%put &=ave_age_ch;

proc print data=SASHELP.BUY (obs=max); run;

