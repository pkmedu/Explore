data ds1;
some_var=1;
run;
data ds2;
some_var=1;
run;
data ds3;
some_var=1;
run;
data ds4;
some_var=1;
run;
data ds5;
some_var=1;
run;
data all;
set
ds1 ds2 ds3 ds4
ds5;
run;
