
data sum_example;
  input x 1-5;
  retain sum_x 0;
  sum_x = sum_x + x;
cards;
10
20
30
40
50
;
run;
proc print data=sum_example;
run;








proc sort data = sashelp.cars; by make; run;
data cars;
  set sashelp.cars;
  count + 1;
  by make;
  if first.make then count = 1;
  if last.make;
run;
proc print data=cars;
var make count;
run;
proc sort data=sashelp.cars out=cars; by make; run;
data counts (keep= make model type count_of_make);
   set cars; by make;
   if first.make then count_of_make=0;
    count_of_make+1;
   if last.make;
  run;
proc print data=&syslast; run;
