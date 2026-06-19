*Ex25_Macro_catalog.sas;
%LET Path = C:\SASCourse\Week9;
LIBNAME NEW "&Path";
proc catalog catalog=NEW.sasmacr;
contents;
run;
