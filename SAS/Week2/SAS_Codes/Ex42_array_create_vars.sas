
data have;
id='A1';
array x[5] a1 a2 a3 a4 a5 ( 1 2 3 4 5);
output;
id='A2';
array y[5] a1 a2 a3 a4 a5 ( 6 7 8 9 10);
output;
run;
proc print data=have; run;
