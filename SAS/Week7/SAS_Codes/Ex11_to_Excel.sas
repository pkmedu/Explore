proc export data=sashelp.class
    outfile='c:\SASCourse\Week7\sashelp class1.csv'
    dbms=csv
    replace;
run;

data _null_;
 file " C:\SASCourse\Week7\class2.csv ";
 set sashelp.class;
 put (_all_) (',');
run;

ods csv file= 'C:\SASCourse\Week7\class3.csv ';
proc print data = sashelp.class noobs;
run;
ods csv close;

filename csv 'C:\SASCourse\Week7\class4.csv';
data _null_;
set sashelp.class;
file csv dlm=',';
put ( _all_ ) (+0);
run;

libname myxls xlsx "c:\SASCourse\Week7\class5.xlsx" ;
data myxls.class5;
 set sashelp.class;
 run;
libname myxls clear;



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
