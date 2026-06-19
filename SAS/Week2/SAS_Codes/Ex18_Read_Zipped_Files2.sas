*Ex18_Read_Zipped_File2.sas;

Filename ZIPFILE SASZIPAM 'c:\Data\names.zip';
DATA newdata;
  INFILE ZIPFILE(yob1908.txt) DLM=',';
  INPUT name $ gender $ number;
      
RUN;
proc sort data=newdata; by gender descending number;
title " 5 most common girls' names";
proc print data=newdata (obs=5) noobs; 
var name number;
format number comma9.;
where gender='F';
run;
title " 5 most common boys' names";
proc print data=newdata (obs=5) noobs; 
var name number;
format number comma9.;
where gender='M';
run;
title ' ';


