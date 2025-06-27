```sas
dm "log; clear; output; clear; odsresults; clear;";
options nodate nonumber nodate;
%let inpath = C:\Data;
Libname XL xlsx "&inpath\TestExcelSheet.xlsx";
libname new "C:\Data";

proc format;
value race_fmt 1 = 'Hispanic'
               2 = 'Non-Hispanic Black'
               3 = 'Asian'
               4  = 'Other'
               . ='All';

PICTURE mixed 
		0,1,2,3,4,5,6,7,8,9,10=[3.]
		1000-HIGH= [comma14.]
		other = '000,009.9999'; 
RUN;
```
```sas
options validvarname=any;
%let kept_vars ='QC Step'n Description FY2006_Panel20 FY2011_Panel26 FY2012_Panel:;
data Fictitious_2022;
   set XL."SomeWeights$A1:T42"n (firstobs = 5 keep= &kept_vars);         

        /* Convert character variables to numeric ones  - 4 variables */
		array x{*}  $ FY2011_Panel26 FY2012_Panel24 FY2012_Panel26 FY2012_Panel27;
		array y{*}  Y2011_Panel26 Y2012_Panel24	Y2012_Panel26 Y2012_Panel27;
		array pchange  {3} C_Y2012_Panel24 C_Y2012_Panel26 C_Y2012_Panel27; 
		 do i = 1 to dim(x);
		     y{i} = input(strip(x{i}), best12.);
		 end;

         /* Calculate percent change for three variables */
         	do i = 1 to 3;              
                  pchange { i } = divide( y{i+1}, y{i})-1;   
         	end; 
          drop FY: i;
run;
```
```sas
title "Listing of variables from the output data set";
ods excel file = "c:\Data\Output Data.xlsx"
    options(embedded_titles="yes" sheet_interval="none");
proc print data=Fictitious_2022 noobs;
var 'QC Step'n description y: c:;
format  y: mixed. c: percent8.2;  /* Percent8.2 format to print data from "created columns" */
run;
ods excel close;
```

