*Ex3_putlog_PercentPut.sas;
options nodate nonumber nocenter 
        leftmargin=0.5in symbolgen;
%LET Path=C:\SASCourse\Week9;
LIBNAME perma "&Path";
data work.stocks; 
 set sashelp.stocks END=last;
  count+1;
  if last then putlog 
     @5 "Note: Number of observations=" count;
 run;
/*old way to display the macro-variable-value */  
 %put Note: Macro Variable Path = &Path; 

 /*new way to display the macro-variable-value */
 %put Note: Macro variable &=Path; 


