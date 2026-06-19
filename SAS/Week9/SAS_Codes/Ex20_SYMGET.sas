*Ex20_SYMGET_RESOLVE.sas (Part 1);
data Have;
Quiz1_score=70;
call symputx('weight', .05);
wgt1=symget('weight');
W_Quiz1_score=Quiz1_score*symget('weight');
W_Quiz1_score_x=Quiz1_score*input(symget('weight'), best12.);
run;
proc contents data=Have;
ods select variables;
run;
proc print data=Have;run;

*Ex20_SYMGET_RESOLVE.sas (Part 2);
%let factor=.05;
data Have2;
var_factor1=&factor;
var_factor2 = symget('factor');
var_factor3= resolve('&factor');
run;
proc contents data=Have2;
ods select variables;
run;

