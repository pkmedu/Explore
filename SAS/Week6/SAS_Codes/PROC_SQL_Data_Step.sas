
options obs=max;
proc print data=sashelp.demographics (obs=25);
var name pop;
run;


***** FIND COUNTRIES WITH AT LEAST 2% OF THE WORLD POPULATION; 
Options nocenter nodate nonumber;
 *** PROC SQL Solution;
title 'PROC SQL Solution: COUNTRIES WITH AT LEAST 2% OF THE WORLD POPULATION';
proc sql number; 
select name
       ,pop
       ,pop/sum(pop) as percent_pop 
        label = 'Percentage of World Population'
	    format=percent7.2
  from  sashelp.demographics
   having calculated percent_pop >=0.02
   order by percent_pop desc;
quit;
title;

*** DATA Step Solution;

*Step 1:  Create summary data (1 observation and 1 variable);
proc means data=sashelp.demographics  noprint;
var pop;
output out=work.summary (drop=_:)  sum= /autoname;
run;

* Step 2: Combine the summary and detail data;
Data work.demographics;
 if _N_ = 1 then set work.summary;
  set sashelp.demographics (keep=name pop);
  percent_pop = pop/pop_sum;
  label percent_pop =  'Percentage of World Population';;
 Format percent_pop percent7.2;
 if percent_pop >=0.02;
run;

* Step 3: Sort the data;
proc sort data=work.demographics;
 by descending percent_pop;
run;
proc print data=work.demographics (drop=pop_sum) label;
run;

