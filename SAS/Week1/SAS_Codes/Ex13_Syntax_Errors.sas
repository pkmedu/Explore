*Example_Syntax_Errors.sas;
DAAT class;
SET sashelp.class;
where SEX ='M';
run;

proc print data=sashelp.calss (obs=5);
var Name sex; 
run;

proc print data=sashelp.class (obs=5);
 var Name sx;
run;

proc print data=sashelp.class (obs=5);
 var Name sex;
 title 'Listing from CLASS;
run;
