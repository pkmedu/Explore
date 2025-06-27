*Ex6_Join_macro_var_text.sas (Part 1);
options symbolgen;
*Create a macro variable;
%LET dsn = month;
*Add a macro variable as a suffix;
data work.&dsn;
var1=1;
run;
%put work.&dsn;

*Ex6_Join_macro_var_text.sas (Part 2);
*Must add a dot when adding a text 
 to the macro variable;
data &dsn.1;
var1=1;
run;
%put &dsn.1;

*Ex6_Join_macro_var_text.sas (Part 3);
*Join two macro variables;
%LET xdsn=1;
data work.&dsn&xdsn;
var1=1;
run;
%put work.&dsn&xdsn;

*Ex6_Join_macro_var_text.sas (Part 4);
*Define macro variables;
%LET Path=C:\;
%LET Libref=New;
libname &Libref "&Path";
*Must add a dot when adding a text 
  to the macro variable;
data &Libref..&dsn;
var1=1;
run;

*Ex6_Join_macro_var_text.sas (Part 5);
*Display GLOBAL macro variables;
%put _GLOBAL_;

*Delete user-defined macro variables;
%symdel Path Libref /nowarn;

* and check all macro variables deleted;
%put _GLOBAL_;

***Part 2: Referencing macro variables with a trailing period;
*Ex6_Join_macro_var_text.sas (Part 6);
options SYMBOLGEN;
%let fld_name = c:\SASCourse\Week9;
%let lref = mylib;
libname &lref "&fld_name";
data &lref..newclass2;
 set sashelp.class;
 ratio_h_w = height/weight; 
run;
%put &=fld_name;
%put &=lref;

%symdel fld_name /nowarn;
%put _user_;

