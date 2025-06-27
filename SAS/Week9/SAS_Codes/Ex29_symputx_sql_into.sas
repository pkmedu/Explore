* Ex29_symputx_sql_into.sas (Part 1);
options center nodate nonumber;
* Adapted from Simon (2017);
proc means data=sashelp.class noprint;
 var weight;
 output out=mystats mean=avweight;
 run;

data _null_;
 set mystats;
 call symputx('meanweight',avweight);
 run;

proc print data=sashelp.class noobs;
var name sex weight;
 where weight > &meanweight;
title 'Students weighing more than average weight';
title2 "Average weight:(%sysfunc(round(&meanweight, 0.01)) lbs)";
title3 '3 DATA/PROC Steps';
run;
title;

* Ex29_symputx_sql_into.sas (Part 2);
title 'Students weighing more than average weight';
title2 'PROC SQL - Just 1 Step';
proc sql ;
 select mean(weight) into: meanweight_x 
		FROM sashelp.class ;
 select name, sex, weight format=6.1
		FROM sashelp.class 
 having weight > &meanweight_x;
quit;

