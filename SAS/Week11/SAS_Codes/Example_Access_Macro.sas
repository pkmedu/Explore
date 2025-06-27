*Example_Access_Macro.sas;
%LET Path = C:\SASCourse;
LIBNAME NEW "&Path";
options mstored sasmstore=New;
%Create_logfile 
dm 'log; file "&Path\&xtract._Log&sysdate9." replace';
data new_class;
 SET SASHELP.CLASS ;
 where sex='M';
run;
proc print data=new_class; 
run;
