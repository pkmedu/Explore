*Ex1_Motivation_for_macro_variables (Part 1);
proc means data=sashelp.class mean maxdec=1 noprint;
 var weight;
 output out=stats mean=average_wgt;
run;

*Ex1_Motivation_for_macro_variables (Part 2);
data test;
 set SASHELP.class;
 *This line of code does not work;
 weight_ratio=weight/average_wgt;
 run;

 *Ex1_Motivation_for_macro_variables (Part 3);
 * Create a macro variable using CALL SYMPUTX;
 data _null_;
  set stats;
  call symputx('average_wgt', average_wgt);
 run; 
 %put _user_;
 %put &=average_wgt;

 *Ex1_Motivation_for_macro_variables (Part 4);
  *The macro variable value can be retrieved in a data step; 
 data test2;
  set SASHELP.class;
  weight_ratio=weight/"&average_wgt";
 run;
 title " Program dated &sysdate9";
 proc print data=test2; run;
 title;


 data test2;
 if _n_ = 1 then  set stats;
 set SASHELP.class;
 weight_ratio=weight/average_wgt;
 run;
 title 'Nonmacro code using two SET statements';
 proc print data=test2; run;
 title;

