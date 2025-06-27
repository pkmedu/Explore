```sas
data Long2;
infile datalines truncover;
length VarName $2;
input VarName X Value @;
do until( Value=. );
   output;   
input X Value @;
end;
datalines;
Y1 10 2 15 0 20 1
Y2 10 3 12 4 13 5 16 4 17 3 18 3 20 4
Y3 9 3 11 4 14 6 18 4 19 5
;
proc print data= Long2;
run;

data Wide;
input X Y1 Y2 Y3;
datalines;
10 2 3 4
15 0 4 6
20 1 4 5
;
 
data Long;
set Wide;
VarName='Y1'; Value=Y1; output;
VarName='Y2'; Value=Y2; output;
VarName='Y3'; Value=Y3; output;
drop Y1-Y3;
run;
proc print data=Long;
run;
```
