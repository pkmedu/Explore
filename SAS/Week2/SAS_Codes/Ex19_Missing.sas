*Ex19_Missing.sas (Part 1);

*Instream data include dot(.) as a missing value;
options nocenter nodate nonumber MISSING='X' ;
data Example_M_Equal;
  input x y z c name $;
  format x y z c percent12.2;
datalines;
.38 .0324  1.0 .345  John
.12 .      .    .606 Carl
.15 .7476  .    .049 Choi
 .  .22    .    .    Rubi
.35  .    .     .    Beth
;
title 'Missing values (.) Assigned a Character Value';
proc print data=Example_M_Equal;
  var name;
  sum x y z c;
run;

*Ex19_Missing.sas (Part 2);
* Instream data include ._, .a., and .z, as special missing values;
options nocenter nodate nonumber;
data Example_M_S;
  input x y z c name $;
  format x y z c percent12.2;
datalines;
.38 .0324  1.0 .345   John
.12 .a     .z    .606 Carl
.15 .7476  .z    .049 Choi
._  .22    .z     .   Rubi
.35  .a    .z     .   Beth
;
title 'Different Types of Missing Values Printed';
proc print data=Example_M_S noobs;
  var name;
  sum x y z c;
run;
*Ex19_Missing.sas (Part 3);
* Instream data include a character value in a numeric field; 
options nocenter nodate nonumber  ;
data Example_M_C;
  length state $20;
  infile datalines  FIRSTOBS=2;
  input state  N_Var1-N_Var4 ;
  missing M;
  datalines;
state     N_Var1   N_Var2  N_Var3 N_Var4
Alabama     13.2   236     58     21.2
Alaska      10     263     48      M
Arizona      8.1   294     80     31
Arkansas     8.8   190     50     19.5
California   9     276     91      M
Colorado     7.9    M       78    38.7
Connecticut  3.3   110     77     11.1
;
proc print data=Example_M_C noobs; 
var state  N_Var:;
run;


