*Ex35_Select_Top_Bottom_Values.sas (Part 1);
*Selecting 2 top and 2 bottom values;
data a;
input a @@;
infile datalines dlm = ' ';
datalines;
1 2 3 4 6 99 118 190 0 4 5 8
;

* Solution 1;
ODS select ExtremeObs; 
proc univariate data=a; 
run;

*Ex35_Select_Top_Bottom_Values.sas (Part 2);
*Solution 2;
proc summary data=a;
output out=top 
  idgroup(min(A) out[2](A)=);
output out=bot 
 idgroup(max(A) out[2](A)=);
run;
data topbotsum(keep=fro A_:);
  retain fro;
  set top(in=t) bot;
  if t then fro='TOP';
  else fro='BOT';
run;
proc print data=topbotsum; run;
 
*Ex35_Select_Top_Bottom_Values.sas (Part 3);
*Solution 3;
proc iml;
use a;
   read all var _NUM_ into a;
close a;
call sort(a);
rows = nrow(a);
fin = (a[1:2, ])// 
      (a[rows - 1:rows, ]);
print fin ;
create res 
  var {fin};
append;
close res;
quit;
proc print data=res; run;
 
