*Ex31_CMISS_Base_IML.sas (Part 1);
data Missing;
input A B C;
datalines;
2 1 1
4 . .
1 3 1
. 6 1
. 1 .
3 4 2
;
data A;
set Missing;
array vars(3) A--C; 
numMissing = cmiss(of vars[*]);
run;
proc print data=A; run;

*Ex31_CMISS_Base_IML.sas (Part 2);
proc iml;
use Missing;
  read all var _NUM_ into x;
close Missing;
rowMiss = countmiss(x, "ROW"); 
print (x || rowmiss);
jdx = loc(rowMiss>0);
print jdx;
idx = loc(rowMiss=0);
y = x[idx,]; 
print y;
quit;
