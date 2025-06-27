*Ex22_Macro_vars_num_char.sas;
/*
A macro variable value is neither character nor numeric; 
it is just text. SAS decides what type it is based 
on the context in which it is used.  In the example below, 
x is numeric,and y is character.  
*/

%let year=2018;
data test;
 x=&year;
 y="&year";
run;
proc sql; 
 select varnum, name, type 
	from dictionary.columns 
	where libname = 'WORK' and memname = 'TEST'; 
quit; 
