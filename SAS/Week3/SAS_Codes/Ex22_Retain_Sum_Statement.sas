*Ex22_Retain_Sum_Statement.sas (Part 1);
* Creating the accumulator variable using the SUM statement;
DATA temp ;
  INPUT month sales;
      Total_sales+sales;
 FORMAT Sales Total_sales dollar8.;
  DATALINES;
    1 4000 
    2 5000 
    3 . 
    4 5500 
    5 5000 
    ;
title1 'Ex22_Retain_Sum_Statement.sas (Part 1)';
title2 'SUM Statement';
PROC PRINT noobs; run;

*Ex22_Retain_Sum_Statement.sas (Part 2);
* Creating the accumulator variable using the REATIN and 
  ASSIGNMENT statements;

DATA temp1 ;
   RETAIN Total_sales 0;
   FORMAT Sales Total_sales dollar8.;
   INPUT month sales ;
    Total_sales= sum(Total_sales, sales);
   DATALINES;
   1 4000 
   2 5000 
   3 . 
   4 5500 
   5 5000 
   ;
title1 'Ex22_Retain_Sum_Statement.sas (Part 2)';
title2 'RETAIN Statement';
PROC PRINT data=temp1; 
  VAR month sales Total_sales;
run;

/*
Overriding the Default Behavior of the Sum Variable
By default, the sum variable is automatically set to 0
before the first observation is read. 
To reset the sum variable to a different number, 
you need to use the RETAIN statement.  
*/
*Ex22_Retain_Sum_Statement.sas (Part 3);

* Creating the accumulator variable using RETAIN and 
  SUM statements;

DATA temp;
   RETAIN Total_sales 1000;
   INPUT month sales;
    Total_sales+sales;
   FORMAT Sales Total_sales dollar8.;
   DATALINES;
   1 4000 
   2 5000 
   3 . 
   4 5500 
   5 5000 
   ;
title1 'Ex22_Retain_Sum_Statement.sas (Part 3)';
title2 'RETAIN and SUM Statements';
PROC PRINT noobs; 
 var month sales Total_sales;
RUN;

*Ex22_Retain_Sum_Statement.sas  (Part 4);
proc sort data = sashelp.cars out=cars; by make; run;
data cars_x;
  set cars;
  count + 1;
  by make;
  if first.make then count = 1;
  if last.make;
run;
title1 'Ex22_Retain_Sum_Statement.sas (Part 4)';
title2 'SUM Statement';
proc print data=cars_x;
var make count;
run;
title1; title2;



