DM 'log;clear;output;clear;';
/***************************************************************************
* GOAL: Create .CSV files with column headers dynamically based on 
        SASHELP DATA files.
****************************************************************************/

*First, delete all files from the folder before new files are written;
*The code  below (Author: Art Carpenter) is obtained from communities.sas.com;
filename list pipe 'dir "c:\SASHELP_Raw1" /b/o';
data _null_;
   length fname $40;
   infile list truncover;
   input fname $;
   rc=filename('abc',catt("C:\SASHELP_Raw1\",fname));
   if rc = 0 and fexist('abc') then rc=fdelete('abc');
   rc=filename('abc');
run;
*options symbolgen mlogic mprint;
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
%put There are &df_cnt data files in the SASHELP library;


 * Step 2: Store SASHELP VARIABLE LISTS, one list per data set,  
           in a macro variable dynamically;
%macro xcreate;
  %do j =1 %to %sysfunc(countw(&memlist));
       %global %scan(&memlist, &j)_vlist;
       proc sql noprint;
        select name into :%scan(&memlist, &j)_vlist separated by ','
         from dictionary.columns
          where libname= "SASHELP" and 
              memname = "%scan(&memlist, &j)"
             order by varnum;
       quit;
   %end;
  %put _global_;
 %mend xcreate;
 %xcreate

 *Step 3: Create CSV files with column headers, one per SASHELP data set, 
          dynamically;
%macro create;
  %do j =1 %to %sysfunc(countw(&memlist));
	 data _null_;
	  set sashelp.%scan(&memlist, &j);
	  file "C:\SASHELP_Raw1\%scan(&memlist, &j).dat" dsd;
	  if _N_ = 1 then put "%sysfunc(cats(&,%scan(&memlist, &j)))_vlist";
      put (_all_) (+0) ;
	 run;
  %end;
 %mend create;
 %create
 
 * Step 4: Count the number file CSV files wriiten to the folder;
*** Code obtained from Michele Austin (SAS Institute);
Filename test pipe 'dir c:\SASHELP_Raw1'    ;
data _null_;
infile test truncover end=last;
length var1 $ 150;
input var1 $char150.;
datfound+index(var1,'.dat ')>0;
if last then
call symput('numfiles',datfound);
run;
 
%put number of .dat files was &numfiles;
/*
import os
cpt = sum([len(files) for r, d, files in os.walk("C:\SASHELP_Raw")])
cpt
 */
