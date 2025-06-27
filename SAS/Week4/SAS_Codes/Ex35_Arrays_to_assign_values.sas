*Ex35_Arrays_to_assign_values;
data _null_;
put 'PUT 1 => ' _all_;
array x[3] (1, 2, 3); output;
put 'PUT 2 => ' _all_;
array y[3] (4, 5, 6); output;
put 'PUT 3 => ' _all_;
array z[3] (7, 8, 9); output;
run;

data have;
array x[3] (1, 2, 3); output;
array y[3] (4, 5, 6); output;
array z[3] (7, 8, 9); output;
run;
proc print data=have; run;

*Contributed by Rick Wicklin to SAS-L - 1/5/2016;
data _null_;
array x[3] (1, 2, 3);
x_sum=put( sum(of x[*]), Z6.);
x_avg=put( mean(of x[*]), 5.1);
x_std=put( std(of x[*]), 5.3);
put _ALL_;
run;

*Contributed by Data _Null_ to SAS-L - 1/5/2016;
data _null_;
  x=1;
  v1=2;
  v2=3;
  v3=4;
  v4=1;
  array v[*] v:;
  if x in v then put 'TRUE'; else put 'FALSE';
  put _ALL_;
run;
