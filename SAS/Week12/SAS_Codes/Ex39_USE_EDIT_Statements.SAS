*Ex39_USE_EDIT_Statements.SAS;
OPTIONS nofmterr FORMCHAR="|----|+|---+=|-/\<>*";
libname imlin "C:\SASCourse\Week12";
 options fmtsearch=(imlin.formats);
proc iml;
reset deflib=imlin;
 use imlin.for_iml_pop2013 var {State_Name Pop}; 
 show contents;
close imlin.for_iml_pop2013;
edit imlin.for_iml_pop2013 
  var {State_FIPS State_Name Pop} 
   where(State_FIPS <=8);
list all;
var_group = {State_Name Pop};
list all var var_group 
   where(State_FIPS <=4);
show contents;
show datasets;
quit;

