 ### Write multiple SAS outputs to various Excel sheets
 ##### The 'PROC' option creates a new Excel worksheet for each SAS procedure.
```sas
 ods excel file = "c:\SASCourse\Week7\class_classfit.xlsx"
    options(sheet_name="class" embedded_titles="yes" sheet_interval='PROC');
 title 'PROC CONTENTS - SASHELP.CLASS File';
 proc contents data=SASHELP.CLASS position;
 ods select variables;
 run;
 ods excel options(sheet_name="classfit" embedded_titles="yes" sheet_interval='PROC');
 title 'PROC CONTENTS - SASHELP.CLASSFIT File';
 proc contents data=SASHELP.CLASSFIT position;
 ods select variables;
 run;
 ods excel close;
```
### Write multiple SAS outputs to the same Excel sheet.
##### The 'NONE' option creates all the output on the same page (Excel sheet).
```sas
 ods excel file = "c:\SASCourse\Week7\class_classfit_x.xlsx"
    options(embedded_titles="yes" sheet_interval="none");
 title 'PROC CONTENTS - SASHELP.CLASS File';
 proc contents data=SASHELP.CLASS position;
 ods select variables;
 run;
 ods excel options(embedded_titles="yes" sheet_interval="none"); 
 title 'PROC CONTENTS - SASHELP.CLASSFIT File';
 proc contents data=SASHELP.CLASSFIT position;
 ods select variables;
 run;
 ods excel close;
```
### Write two SAS outputs per Excel spreadsheet.
##### Trick: Suspend a destination temporarily and move to a new Excel spreadsheet
```SAS
ods listing close; /* Closing the default listing output */
ods excel file="C:\Data\TwoOutputPerShhet.xlsx" 
      options(embedded_titles='yes' embedded_footnotes='yes'
      title_footnote_width="80"); /* Open an Excel destination */

/* Create the first sheet named "Heart_Cars" and prints two tables */
ods excel options(sheet_name="Heart_Cars" sheet_interval="none");
title "Table 1: SASHELP.HEART data set's variable attributes";
proc print data=sashelp.vcolumn label;
 var name type format length label;
 where libname='SASHELP' and memname='HEART';
run;

title "Table 2: SASHELP.CARS data set's variable attributes";
proc print data=sashelp.vcolumn label;
 var name type format length label;
 where libname='SASHELP' and memname='CARS';
run;

/* Suspend a destination temporariliy and move to a new Excel spreadsheet */
ods select none;
ods excel options(sheet_interval="proc");
proc print data=sashelp.class; run;
ods select all;

/* Create another sheet "Demographics_IRIS" and prints two more tables  */
title "Table 3: SASHELP.DEMOGRAPHICS data set's variable attributes";
ods excel options(sheet_name="Demographics_IRIS" sheet_interval="none");
proc print data=sashelp.vcolumn label;
 var name type format length label;
 where libname='SASHELP' and memname='DEMOGRAPHICS';
run;

title "Table 4: SASHELP.IRIS data set's variable attributes";
proc print data=sashelp.vcolumn label;
 var name type format length label;
 where libname='SASHELP' and memname='IRIS';
run;
ods excel close;
title;
ods listing;
```
