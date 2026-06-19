Filename TSA "c:\Data\claims-2014.xls";
proc http
url="https://www.dhs.gov/sites/default/files/publications/claims-2014.xls"
method = "GET"
out=TSA;
run;
 
options validvarname = any; 
proc import datafile='C:\Data\claims-2014.xls' out=results replace
dbms=xlsx;
run;

proc contents data=results;
run;
