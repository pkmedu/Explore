*Ex10_create_macro_vars_call_symputx_1.sas (Part 1);
Options nodate nonumber;
proc means data=sashelp.class noprint;
var weight;
output out=mystats mean=mean_weight;
run;

data _null_;
set mystats;
call symputx('AverageWeight', mean_weight);
run;

%put &AverageWeight;
%put _GLOBAL_;

proc print data=sashelp.class noobs;
var name sex weight;
where weight > &AverageWeight;
title1 'Passing Values between Steps';
title2 'Average Body Weight:'; 
title3 "%sysfunc(putn(&AverageWeight, 5.1)) lbs";
run;

*Ex10_create_macro_vars_call_symputx_1.sas (Part 2);
*Code idea adapted from Carpenter (2016);
data S1;
input mvar $ mvalue $;
datalines;
Course Stat6197
Exam  Midterm
Mean 73
SD   7
; 
data _null_;
   set S1;
   call symputx(mvar, mvalue);
  run;
%put _user_;

*Ex10_create_macro_vars_call_symputx_1.sas (Part 3);
%macro mvarlist;
  data _null_;
   set S1;
  call symputx(mvar, mvalue, 'L');
  run;
  %put _Local_;
%mend mvarlist;
%mvarlist

*Ex10_create_macro_vars_call_symputx_1.sas (Part 4);
%macro mvarlist;
 data _null_;
   set S1 (rename=(mvar=x_mvar mvalue=x_mvalue));
   call symputx(x_mvar, x_mvalue, 'G');
  run;
%mend mvarlist;
%mvarlist
%put _GLOBAL_;


*Ex10_create_macro_vars_call_symputx_1.sas (Part 5);
data Have;
 set SASHELP.CLASS end=last;
  if age >14 then do;
   n+1;
  if last then call symputx('number', n);
  output;
 end;
run;
Footnote "There are &number of observations with AGE>14";
proc print data=have; run;
 
*Ex10_create_macro_vars_call_symputx_1.sas (Part 6);
DATA _NULL_;
 set sashelp.class;
 call symputx('Name' || STRIP(put( _N_, 2.)), Name);
run;
%put &Name1 &Name10 &Name13;

* Code obtanied from John Simon (SAS Blog);
ods html close;
%macro deleteALL;
 options nonotes;
 %local vars;
 proc sql noprint;
        select name into: vars separated by ' '
           from dictionary.macros
                 where scope='GLOBAL' 
   and not name contains 'SYS_SQL_IP_';
   quit;
    %symdel &vars;
    options notes;
     %put NOTE: Macro variables deleted.;
 %mend deleteALL;
 %put _user_;
