*Ex13_proc_datasets.sas;

LIBNAME NEW "C:\SASCourse\Week5";
LIBNAME XNEW "C:\Misc";


/* Use PROC DATASETS as an alternative to PROC CONTENTS 
   to see the descriptor portion of the data set */

proc datasets library=NEW;
contents data=new.pop details varnum memtype=data;
quit;
proc print data=new.pop (obs=5) noobs split='*'; 
run;


/* Copy a data set from one folder to another folder */
proc datasets nolist;
copy in=NEW out=XNEW;
select pop;
quit; 

/* Change formats and labels and rename variables of a SAS data set */
proc datasets lib=xnew;
 modify pop;
 FORMAT p_pop18p  percent8.2; 
 label  Name = 'Name of*State';
 rename p_pop18p = Percent_pop18p;
quit;

proc datasets library=XNEW;
contents data=pop details varnum memtype=data;
quit;


*** Another data set - Notice the attributes of the variables
    in this data set;
proc contents data=sashelp.mdv varnum;run;

* Create a temporary data set based on SASHELP.MDV;
data mdv;
  set sashelp.mdv;
 run;

 * Delete the LABEL, FORMAT, and INFORMAT of all variables
   in this data set;

proc datasets lib=work memtype=data;
   modify mdv;
     attrib _all_ label=' ';
     attrib _all_ format=;
	 attrib _all_ informat=;
   contents data=work.mdv;
 quit;

