

/* Journeymen’s Tools:... by Ronald J. Fehd; */
Proc Contents data = SAShelp.Class;
run;

Proc Datasets library = SAShelp
details nolist
memtype = data;
contents
data = Class;
quit;

PROC Print data = SAShelp.Vcolumn
(where = ( Libname eq 'SASHELP'
 and MemName eq 'CLASS') );
run;

PROC SQL; 
 describe table SAShelp.Class; 
quit;

PROC SQL; select Name, Type, Length, Label
from Dictionary.Columns
where Libname eq 'SASHELP'
and MemName eq 'CLASS'; 
quit;




/* Default behavior of the CONTENTS procedure
- generates variable attributes that are listed 
in alphabetical order in the data set*/

Proc contents data=sashelp.heart;
Run;
proc contents data=sashelp.class order=collate;
ods select variables;
run;

proc contents data=sashelp.class position;
ods select variables;
run;


 ** With the VARNUM option, the CONTENTS procedure generates 
    variable attributes that are listed  by their  
    position in the data set;


Proc contents data=sashelp.class varnum;
ods select position;
Run;
Proc contents data=sashelp.class p;
ods select position;
Run;

** With the SHORT option, variable names are listed in a 
   row-by-row format;
Proc contents data=sashelp.heart short;
Run;

** The CONTENTS statement in the DATASETS procedure does also similar
output that PROC CONTENTS generate;

proc datasets;
contents data=sashelp.class;
quit;

/* You can add the OUT= filename option to the CONTENTS procedure
   to create a SAS data set where each observation is a variable 
   from the original data set. The NOPRINT option supresses the listing 
   of the output data set */

proc contents data = sashelp.heart
out = varsdata (keep= name type length label) noprint;
run; 

** Sort the output data set by VARNUM;
proc sort data=varsdata; by varnum; run;
**  Get the listing;
proc print data= varsdata noobs;
run;

** SAS Data Files that are stored in the SASHELP Library;
ods listing close; 
ods output attributes=sashelp_attout; 
proc contents data=mydir._all_;
run;
ods rtf file="E:\sashelp_contents.rtf";
proc print data=sashelp_attout;
run;
ods rtf close;
ods listing;


/** The SAS System generates the information at run time 
about SAS libraries, data sets, catalogs,
indexes, macros, system options, titles, and views in a collection
of read-only tables called dictionary tables.

When you work in a SAS environment where all your libraries are defined 
 in SAS metadata and they are available in every SAS job. 

The following code below extracts the information about "column" 
from a SQL table  (i.e. SAS data set);
*/

 proc sql; 
 select varnum, name, type 
	from dictionary.columns 
	where libname = 'SASHELP' and memname = 'HEART'; 
quit; 

* Create a macro variable (VARIABLE_NAME) that will hold all variable names 
(horizontal list) in the SAS data set (Advanced Topic);
proc sql noprint; 
     select name into :Variable_Names separated by ' ' 
     from dictionary.columns 
     where LIBNAME='SASHELP' and memname = 'HEART';
 quit; 
 %put &Variable_Names;


proc sql ;
          select *
            from sashelp.vcolumn
                 where libname='SASHELP'
				      & memtype='HEART';
quit;

/* SASHELP.VCOLUMN contains the information about variables (columns) 
  in a data set. You can create an output data set using SAS DATA step 
  from the Dictionary view SASHELP.VCOLUMN and then print the 
  variable attributes */

data vars; 
set sashelp.vcolumn;
where libname = 'SASHELP' and memname = 'CLASS'; 
keep varnum name type; 
run; 

proc print data= vars noobs;
run;

/* You can also use PROC SQL to print variable attributes 
  from the Dictionary view SASHELP.VCOLUMN */ 
  
proc sql;
select name
, type
, label
, length
, informat
, format
from sashelp.vcolumn
where libname = 'SASHELP'
   and memname='HEART';
quit;


proc sql;
select name, type, length
 from dictionary.columns
 where libname= "SASHELP" and memname = "HEART"
 and name like "%_Status";
 quit;

options nocenter nodate nonumber;
proc sql;
select memname, nobs format =comma9. ,
  nvar format=comma9.
from dictionary.tables
where libname='SASHELP' and memname like 'IRIS';
quit;

options nocenter nodate nonumber;
* Step 1: Store SASHELP DATA SET NAMES in a macro variable dynamically;
proc sql noprint ;
  select distinct memname
   into :memlist separated by ' '
   from dictionary.columns
       where libname = 'SASHELP' 
        and memtype = 'DATA'
   group by memname
   having sum(length) <=32767;
   %let df_cnt=&sqlobs;
quit;

title "There are &df_cnt data files in the SASHELP library";
proc sql;
select memname, nobs format =comma9. ,
  nvar format=comma9.
from dictionary.tables
where libname='SASHELP' and memtype = 'DATA';
quit;


/* Remember: SASHELP.vcolumn is a data view, not a data set, maintained by SAS. */

/* Also, remember: Dictionary.Columns is sashelp.vcolumn. */

	 proc sql;
         select name, type, length, label
         from
             sashelp.vcolumn
         where
             libname="SASHELP" and
             memname = "HEART"
      ;quit;

	
proc print data=sashelp.vcolumn label;
  var name type format length label;
  where libname='SASHELP' and memname='HEART';
run;

	   proc sql;
         select name, type, length, label
         from dictionary.columns
         where libname="SASHELP" and
             memname = "HEART"
      ;quit;

     options label;
      proc sql;
       describe table sashelp.heart
      ;quit;

      options label;
	 proc contents data=sashelp.heart position;
	 ods select variables;
     run;
	
	  proc contents data=sashelp.heart;
	  ods select variables;
	  run;

	  proc contents data=sashelp.heart varnum;
	  run;


   proc datasets lib=sashelp;
     contents data=heart position;
     quit;

