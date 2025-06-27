data _null_;
	set sashelp.class;
	file "C:\SASCourse\Week8\class.dat" dsd;
	put (_all_) (+0) ;
	run;

%macro create(name);
	data _null_;
	set sashelp.&name;
	file "C:\SASCourse\Week8\&name..dat" dsd;
	put (_all_) (+0) ;
	run;
 %mend create;
 %create(IRIS)

 proc sql noprint ;
  select memname
   into :memlist separated by ' '
   from dictionary.members
     where libname = 'SASHELP' and memtype = 'DATA' ;
  quit ;
%put &memlist;

 %let ds_cnt=%sysfunc(countw(&memlist));
 %put There are &ds_cnt data files in the SASHELP library;

%macro create;
  %do j =1 %to %sysfunc(countw(&memlist));
	 data _null_;
	  set sashelp.%scan(&memlist, &j);
	  file "C:\SASCourse\Week8\%scan(&memlist, &j).dat" dsd;
      put (_all_) (+0) ;
	 run;
  %end;
 %mend create;
 %create
/*
import os
cpt = sum([len(files) for r, d, files in os.walk("C:\SASHELP_Raw")])
cpt
 */
