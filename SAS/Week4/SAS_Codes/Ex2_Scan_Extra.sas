

data test;
   var2 ='Tim Johnson';
   get_LastName= scan(var2,2);
   get_something = scan(var2,3);
 run;

proc print data=test;
run;
proc contents data=test; run;
