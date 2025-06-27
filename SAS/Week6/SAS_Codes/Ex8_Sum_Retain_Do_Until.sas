*Ex8_Sum_Retain_Do_Until.sas (Part 1);
options nocenter nodate nonumber;

data have;
infile datalines missover;
input ID value;
datalines;
1 40
1 30
1 20
3 60
3 
2 30
2 50
;
proc sort data=have; by id; run;

*Ex8_Sum_Retain_Do_Until.sas (Part 2);
options nocenter nodate nonumber;
title1 'Sumarizing by Group -  using the Sum Statement';
data want1 (drop=value);
    set have; by ID;
	if first.id then Cumvalue=0;
	 CumValue+Value;
   if last.ID then output;
 run;
  proc print data=want1 noobs; run;

 *Ex8_Sum_Retain_Do_Until.sas (Part 3);
options nocenter nodate nonumber;
title1 'Sumarizing by Group -  using Retain and Assignment Statements';
 data want2 (drop=value);
    set have; by ID;
	retain CumValue;
	if first.id then CumValue=0;
	 CumValue=sum(CumValue,Value);
	  if last.ID then output;
  run;
 proc print data=want2 noobs; run;

*Ex8_Sum_Retain_Do_Until.sas (Part 4);
options nocenter nodate nonumber;
title1 'Sumarizing by Group -  using PROC SQL';
proc sql;
select id,
     sum (value) as cumvalue
from have
group by id;
quit;

*Ex8_Sum_Retain_Do_Until.sas (Part 5);
options nocenter nodate nonumber;
** Summarize data using PROC SUMMARY;
proc summary data=have nway;
  var value;
  class id;  
  output out=want (drop =_type_ _freq_)
    sum=sum_value;
run;
title1 'Sumarizing by Group - using PROC SUMMARY';
proc print data=want noobs; run;


*Ex8_Sum_Retain_Do_Until.sas (Part 6);
options nocenter nodate nonumber;
* Summarize data using PROC MEANS;
proc means data=have noprint;
   class id;
   var value;
    output out=want2 (drop =_type_ _freq_)
       sum = sum_value;
run;
title1 'Sumarizing by Group - using PROC MEAMS';
proc print data=want2; 
where id  ne .;
run;

*Ex8_Sum_Retain_Do_Until.sas (Part 7);
options nocenter nodate nonumber;
*Count occurrences of dates by patient id;
data HAVE;
input pt_id $ vdate :$10.;
cards;
1      09/01/2017   
1      09/01/2017   
1      03/04/2018   
2      05/01/2017  
2      06/03/2017 
;
run;
 
proc sort data=HAVE;
by pt_id vdate;
run;
 
*Ex8_Sum_Retain_Do_Until.sas (Part 8);
options nocenter nodate nonumber;
title1 'Sumarizing by Group - using the SUM Statement';
data want;
  set HAVE ;
  by pt_id vdate;
  if first.vdate then count_id=0;
  count_id+1;
  if last.vdate then output;
run;
proc print data=want noobs; run;

*Ex8_Sum_Retain_Do_Until.sas (Part 9);
options nocenter nodate nonumber;
title1 'Sumarizing by Group - SUM Statement (Another way)';
data want2;
  set HAVE;  by pt_id vdate;
  count + 1;
   if first.vdate then count = 1;
  if last.vdate then output;
run;
proc print data=want2 noobs; run;

