*Ex6_long_to_wide.sas (Part 1);
options nocenter nodate;
data Have;
 input year $ gdp cpi ;
 datalines;
2010	101.226	218.056	
2011	103.315	224.939	
2012	105.220	229.594	
2013	106.935	232.957	
2014	108.694	236.736	
2015	109.782	237.017	
;

*Ex6_long_to_wide.sas (Part 2);
proc transpose data=Have out=wide1;run;
Title1 'Transposed data with DEFAULT names of the new variables';
proc print data=WIDE1 noobs; run;

*Ex6_long_to_wide.sas (Part 3);
proc transpose data=HAVE out=wide2 prefix=Year 
                         name=Indicator;
id year;
var GDP CPI ; run;
Title1 'Transposed data with DEFAULT names changed';
title2 'ID statement inserted and PREFIX=, NAME= options added';
proc print data=WIDE2 noobs; run;
title1; title2;

*Ex6_long_to_wide.sas (Part 3);
proc transpose data=HAVE out=wide2 prefix=Year 
                         name=Indicator;
id year;
var GDP CPI ; run;
Title1 'Transposed data with DEFAULT names changed';
title2 'ID statement inserted and PREFIX=, NAME= options added';
proc print data=WIDE2 noobs; run;
title1; title2;


*Ex6_long_to_wide.sas (Part 4);
Title1 'Transposed data with DEFAULT names changed at the PROC PRINT step';
title2 'ID and IDLABEL statements added';
proc transpose data=HAVE out=wide3;
id year;
idlabel year;
var GDP CPI ; run;
proc print data=WIDE3 noobs label; 
label _NAME_=indicator;
run;



*Ex6_long_to_wide.sas (Part 5);
** Long to wide format;
Data Long;
input (Name Test) ($) Score ;
datalines;
John Test1 75
John Test2 85
John Test3 76
John Test4 72
John Test5 78
John HW1   82
John HW2   85
John Midterm 68
John Final   75
Hena Test1 75
Hena Test2 80
;
proc sort data=Long; by Name; run;
data want(drop=i Test Score);
   set Long;
   by Name;
   array TestScore (9) Test1 Test2 Test3 Test4 Test5 HW1 HW2 Midterm Final;
   if first.Name then i=1;
   TestScore(i)=score;
   if last.Name then output;
   i+1;
   retain Test1 Test2 Test3 Test4 Test5 HW1 HW2 Midterm Final;
run;
Title1 'Reshaping data using a DATA step and an ARRAY statement';
proc print data=Want noobs;
run;

*Ex6_long_to_wide.sas (Part 6);
proc transpose data=Long out=t_wide (drop=_NAME_);
   by Name;
   var score;
   id Test;
run;
Title1 'Reshaping data using PROC TRANSPOSE';
proc print data=t_wide noobs; run;
