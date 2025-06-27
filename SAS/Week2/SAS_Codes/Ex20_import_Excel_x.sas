*Ex20_Import_Excel_x.sas (Part 1);

* Method 1: Importing an Excel Spreadsheet into a SAS data set;
 options nodate nonumber nodate;
  PROC IMPORT DATAFILE= "C:\SASCourse\Week2\class.xlsx"
     dbms=xlsx REPLACE OUT= work.class_x;
     SHEET="Sheet1";
     GETNAMES=YES;
 RUN;
Title;
 proc print data=work.class_x (obs=5); 
 run;

/* Method 2: The LIBNAME statement references the whole Excel file, 
 which is viewed as a SAS library and, the members inside 
 (spreadsheet or named range) are viewed as data files.
 The SET statement uses the Excel sheet as an input data file 
 for this DATA step */

*Ex20_Import_Excel_x.sas (Part 2);
options validvarname=any;
libname XL XLSX 'C:\SASCourse\Week2\class.xlsx';
data work.class;
  set XL.Sheet1;
run;
libname XL CLEAR; 
proc print data=work.class (obs=5); 
run;

*Ex20_Import_Excel_x.sas (Part 3 - Another example);
%let Path = C:\SASCourse\Week2;
options validvarname=any;
Libname XL XLSX "&Path\MEPS_MCCC.xlsx";
Libname new "C:\SASCourse\Week2";
data new.MCCC_Data(keep=CCSR_Code MCCC);
  set XL.sheet1;
run;
libname XL CLEAR; 

proc freq data=new.MCCC_Data;
tables MCCC /nocum;
run;

