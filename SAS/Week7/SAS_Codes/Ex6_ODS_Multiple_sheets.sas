*Ex6_ODS_Multiple_sheets.sas;
ods _all_ close;
ods excel file='C:\SASCourse\Week7\Example.xlsx' 
  options(sheet_interval='PROC' sheet_name='Age');
proc print data=sashelp.class;
  var age;
run;
ods excel options(sheet_name='Name');
proc print data=sashelp.class;
  var name;
run;
ods excel options(sheet_name='Height');
proc print data=sashelp.class;
  var height;
run;
ods excel close;
 
