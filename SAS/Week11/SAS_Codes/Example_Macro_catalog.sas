*Example_Macro_catalog.sas;
%LET Path = C:\SASCourse;
LIBNAME NEW "&Path";
proc catalog catalog=NEW.sasmacr;
contents;
run;
