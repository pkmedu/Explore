/*RW9 @SAS-L - 9/6/2018*/
data one;
input year ;
cards;
2015
2015
2016
2017
2018
;
run;
proc sort data=one out=loop nodupkey;
  by year;
run;
*novinosrin @SAS-L 9/6/2018;;
data _null_;
  set loop;
  call execute(cats('data year',put(year,4.),'; 
     set one; where year=',put(year,4.),'; run;'));
run;

data one;
input year ;
cards;
2015
2015
2016
2017
2018
;
run;
proc sql;
select count(distinct year) into:cnt trimmed
from one;
quit;
proc sql;
select distinct year into :yr1- /*trimmed*/
from one;
quit;

%put &yr4;
options nosymbolgen nomprint nomlogic;
%macro test;
%do i=&yr1 %to &&yr&cnt;
data year_&i;
set one;
where year =&i;
run;
%end;
%mend test;
%test;

options symbolgen;
%let data = class;
%let class = students; 
%put Note: %nrstr(&data) resolves to: &data;
%put Note: %nrstr(&&data) resolves to: &&data;
%put Note: %nrstr(&&&data) resolves to: &&&data;
