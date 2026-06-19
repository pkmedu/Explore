*Ex11_MFILE.sas;
options nocenter nodate nonumber symbolgen;
%LET path=C:\SASCourse\Week10;
* Directing generated code to a SAS file;
%macro read_year(start=, stop=);
  %do i = &start %to &stop;
    data Data&i; 
      infile "&path\yob&i..txt" DLM=','; 
      input (name sex) ($) count;
	  title "Listing from Data&i Data Set"; 
    proc print data=Data&i (obs=5) noobs; 
    run;
 %end;
%mend read_year;
Filename mprint "&Path\Ex12_Generated_Code1.sas";
options mprint mfile;
%read_year (start=2012, stop=2015)
* Create a macro to generate text on the SET statement;
%macro names(prefix, initial, maxnum);
  %do i=&initial %to &maxnum;
    &prefix&i
  %end;
  ;
%mend names;
*Concatenate data sets using the macro already created;
Filename mprint "&Path\Generated_Code_SET1.sas" ;
options mprint mfile;
data all;
  set %names(Data,2012,2015)
;
run;
proc print data=all; run;









