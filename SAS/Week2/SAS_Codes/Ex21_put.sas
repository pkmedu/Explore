*Ex21_put.sas;

* List all DATA step variables and their values;
options nosource nodate nonumber;

data _null_;
  set sashelp.class(obs=2);
  put _all_;
run;
* Exclude automatic variables;
data _null_;
  set sashelp.class(obs=2);
  put (_all_)(=);
run;
* Put each value on a new line;
data _null_;
  set sashelp.class(obs=2);
  put (_all_)(=/);
run;
/* Put each value on a new line and apply 
a common format to all numeric variables*/
data _null_;
  set sashelp.class(obs=2);
  put (_all_)(=/12.2);
run;
/* List values as a table and apply formats 
to groups of variables*/
data _null_;
  set sashelp.class(obs=2);
  if _n_=1 then put @1 'NAME' @19 'SEX' @23 'AGE' 
                    @30 'HEIGHT' @38 'WEIGHT';
  put (_all_)(1*$20.,1*$2.,1*3.,2*8.2);
run;


/* List values as a table and apply formats 
to groups of variables. Route output to the 
standard SAS output window. */
options nodate nonumber;
title;
data _null_;
  set sashelp.class(obs=2);
  file print;
  if _n_=1 then put @1 'NAME' @19 'SEX' @23 'AGE' 
                    @30 'HEIGHT' @38 'WEIGHT';
  put (_all_)(1*$20.,1*$2.,1*3.,2*8.2);
run;

/* List values as a table and apply formats 
to groups of variables. Route output to a file */
options nodate nonumber;
title;
data _null_;
  set sashelp.class(obs=2);
  file "E:\class_data.txt";
  if _n_=1 then put @1 'NAME' @19 'SEX' @23 'AGE' 
                    @30 'HEIGHT' @38 'WEIGHT';
  put (_all_)(1*$20.,1*$2.,1*3.,2*8.2);
run;

/* List values as a table and apply formats 
to groups of variables. Route output to a file 
Write an informational message to the log using 
an PUTLOG statement */
options nodate nonumber;
title;
data _null_;
  set sashelp.class(obs=2)END=last;
  file "E:\class_data2.txt";
  if _n_=1 then put @1 'NAME' @19 'SEX' @23 'AGE' 
                    @30 'HEIGHT' @38 'WEIGHT';
  put (_all_)(1*$20.,1*$2.,1*3.,2*8.2);
  if last then putlog "User's NOTE: Writing to the File is completed";
run;


proc export data=sashelp.class
    outfile='c:\test\sashelp_class1.csv'
    dbms=csv
    replace;
run;

data _null_;
 file " C:\test\class2.csv ";
 set sashelp.class;
 put (_all_) (',');
run;


filename csv 'C:\test\class4.csv';
data _null_;
set sashelp.class;
file csv dlm=',';
put ( _all_ ) (+0);
run;

libname myxls xlsx "c:\test\class5.xlsx" ;
data myxls.class5;
 set sashelp.class;
 run;
libname myxls clear;

ods excel file="c:/test/class6.xlsx";
ods excel options(sheet_name="class" sheet_interval="none" start_at="B1");
proc print data=sashelp.class;
run;

ods csv file= 'C:\test\class7.csv ';
proc print data = sashelp.class noobs;
run;

ods trace on; 
ods csv close;

ods Excel file= 'C:\test\class8.xlsx';
proc print data = sashelp.class noobs;
run;
ods trace on; 
ods Excel close;





