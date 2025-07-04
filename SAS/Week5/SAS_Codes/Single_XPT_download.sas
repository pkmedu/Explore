* Single_XPT_Download.sas;
/************************************************************************************
* TO DOWNLOAD, UNZIP AND RESTORE a SAS data set from only a single XPORT-created 
* trnsposrt file only one at a time) from the MEPS website     
*
* Just create a macro variable for the data file you are interested in
* (%LET file = h197g;)   That's it! There is no macro program involved here. 
*
* The output files are saved in the WORK folder. 
* CAUTION: Downloaed unzipped/zipped/restored SAS data files will only exist 
* in the current SAS session.
*
* Adjust the code as appropriate to save the files permanently.
*
* Written by: Pradip Muhuri                                                         
***************************************************************************************/

proc datasets library=work kill;run;quit;
%LET file=h197g; 
%put &=file;
/* use pathname function to get work library's path and store in macro variable wpath */
/*%let wpath=%sysfunc(pathname(work));*/

* Create a macro variable containing a folder to store the data file;

%let wpath=c:\Data;
%let spath=c:\Data\SDS;

*** Task 1: Download a zipped SAS transport file from the MEPS web site;

/* use wpath macro variable and append filename to it in filename statement */
*options symbolgen mprint mlogic merror;
Filename GoThere "&wpath\&file.ssp.zip";
proc http 
   url="https://meps.ahrq.gov/data_files/pufs/&file.ssp.zip" 
   out=GoThere;
run;
/***********************************************************************
* Acknowledgements:
* https://blogs.sas.com/content/sasdummy/2015/05/11/using-filename-zip-to-unzip-and-read-data-files-in-sas/
* Read the "members" (files) from the ZIP file
***************************************************************************************************************/
/*Assign a fileref wth the ZIP method */
filename inzip zip "&wpath\&file.ssp.zip";
 
data contents(keep=memname);
 length memname $200;
 fid=dopen("inzip");
 if fid=0 then
  stop;
 memcount=dnum(fid);
 do i=1 to memcount;
  memname=dread(fid,i);
  output;
 end;
 rc=dclose(fid);
 call symputx ('memname', memname);
run;
 %put &=memname;
/* create a report of the ZIP contents */
title "Files in the ZIP file";
proc print data=contents noobs N;
run;
 
*** Task 2: Unzip the SAS transport data file (Member name in upper case);
filename inzip zip "&wpath\&file.ssp.zip" ;
filename sit "&wpath\&memname" ;
/* hat tip: "data _null_" on SAS-L */
 data _null_; 
infile inzip(&memname) recfm=F lrecl=256 length=len_length eof=eof unbuf;
file sit lrecl=256 recfm=N; 
input @; put _infile_ $varying256. len_length;
return; 
eof: stop;
run;

*** Task 3: Restore the SAS data set from the XPORT-engine-created SAS transport file;

libname xpt xport "&wpath\&memname";
libname new "&spath";
 proc copy in=xpt out=new; 
run;

/*********************************************************
* Show the metadata for the SAS data set restored from the transport file (optional)               
***********************************************************/
proc sql;
select memname,
        nobs format =comma9.
       ,nvar format =comma9.
	   ,DATEPART(crdate) format date9. as Date_created label='Creation Date'
	   ,TIMEPART(crdate) format timeampm. as Time_created label='Creation Time'
from dictionary.tables
 where libname='NEW' and memname like upper("&file");
 quit;


