*Author: Rick Wicklin - SAS-L - 6/30/2018;
*Ex18_collapse_multiple_cols.sas;
/*Collapse multiple boolean columns into single 
attribute column with new rows for each combination*/

data have;
input A$ S1 S2 S3 S4;
datalines;
ex1 1 0 0 0
ex2 0 1 0 0
ex3 0 0 1 0
ex4 1 1 0 0
ex5 0 1 0 1
ex6 0 1 0 0
ex7 1 1 1 0
ex8 0 1 1 0
ex9 0 0 1 0
ex10 1 0 0 0
;

proc iml;
use have;
read all var "A";
read all var _NUM_ into ss[colname=varName];
close;

idx = loc(ss=1);                  /* indices where ss = 1 */
rc = ndx2sub(dimension(ss), idx); /* convert to subscripts (row, col) */
row = A[rc[,1]];                  /* names of rows */
TYP = varName[rc[,2]];            /* names of columns */
print row TYP;
quit;
