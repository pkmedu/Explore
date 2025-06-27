*Ex15_Absolute_Relative_Pointer_controls.sas;

data Example_formatted_column_input;
input id $ 1 x1 3-7
     @9 x2 dollar7. 
     +1 x3 dollarx7. 
     +1 x4 6. 
     +1 x5 percent7.;
format x2 dollar7. x3 dollarx7. x5 percent7.;
datalines;
A 12909 $12,909 $12.909 12.909 12%
;
proc print data=Example_formatted_column_input noobs;
run;
