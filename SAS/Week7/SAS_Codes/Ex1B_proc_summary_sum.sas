*Ex1B_proc_summary_sum.sas;
options nonumber nodate  ps=58 ls=90;
data heart;
 set sashelp.heart;
if status= 'Alive' then death=0;
else death=1;

if status= 'Alive' then survived =1;
else survived =0;
run;
proc summary data=heart;
   class smoking_status;
   var death survived;
   output out=count_data
      sum(death)=death_count
	  sum(survived)=survived_count;
run;
proc print data=count_data; run;

proc summary data=heart;
   class sex smoking_status;
   var weight;
   output out=stats
      mean=meanWEIGHT/ levels ways;
run;
proc print data=stats; run;
