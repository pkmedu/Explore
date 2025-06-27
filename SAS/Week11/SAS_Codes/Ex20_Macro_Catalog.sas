*Ex20_Macro_Catalog.sas;
Libname Mylib 'C:\SASCourse\Compiled_Macros';
proc catalog catalog=Mylib.sasmacr;
contents;
run;
