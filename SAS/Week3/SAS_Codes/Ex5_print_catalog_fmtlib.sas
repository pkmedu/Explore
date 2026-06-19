*Ex5_print_catalog_fmtlib.sas;
options nocenter nonumber nodate nosource;
options FORMCHAR='1----1+1---+=1-1\<>*';
libname sds 'C:\SASCourse\Week3';
proc catalog catalog = sds.catalogpop;
contents;
run;

proc format library = sds.catalogpop fmtlib;
select REGIONFMT;
title 'Formats for Pop2013x Data Set';
run;


