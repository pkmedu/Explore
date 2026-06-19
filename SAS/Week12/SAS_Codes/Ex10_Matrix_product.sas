*Ex10_Matrix_product.sas ((Part 1);
options nocenter nodate nonumber;
proc iml;
	M1 = {1 2 3, 4 5 6};  
	M2 = {7 8, 9 10, 11 12};  
	M1_M2_Product=M1*M2; 
	print M1 M2  M1_M2_Product;
quit;

*Ex10_Matrix_product.sas ((Part 2);

/* remove any rows that contain a missing value:
   https://blogs.sas.com/content/iml/2015/02/23/complete-cases.html */
data cars;
set sashelp.cars;
if not nmiss(of _numeric_);
run;
 

/* Adapted from "4 ways to compute an SSCP matrix" -  by Rick Wicklin
 only 1 way shown below */
*Ex10_Matrix_product.sas ((Part 3);

proc iml;
use cars;  read all var _NUM_ into X[c=varNames]; close;
n = nrow(X);
p = ncol(X);
SSCP = X`*X;         /* 1. Matrix multiplication */
print n p, SSCP;
quit;

