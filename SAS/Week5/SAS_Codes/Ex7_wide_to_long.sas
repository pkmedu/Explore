*Ex7_wide_to_long.sas;
DATA wide;
 INPUT Student_id $ Test1-Test5;
DATALINES;
A001	 80 80 80 82 75
B002	 85 72 85 89 81
C003 	 87 88 89 91 79
D004  	 87 88 89 90 82
;
proc sort data=wide; by Student_ID; run;
proc transpose data=wide 
   out=long (rename=(_NAME_=Test col1=Score));
by Student_id;
run;
title1 'Wide data transposed to long';
title2 'BY statement added to PROC TRANSPOSE step';
proc print data=long noobs; 
run;

data Long_x;
set wide;
array Tests[*] Test1-Test5;
do _t = 1 to dim(Tests);
  Test = tests[_t];
  output;
end;
keep Student_id Test;
run;
title1 'Wide data transposed to long';
title2 'Using the DATA step and ARRAY statement';
proc print data=long_x noobs; 
run;
