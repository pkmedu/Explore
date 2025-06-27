*Ex2_download_unzip_create_macro.sas;
/***********************************************************************
This program automates the following repeated tasks:
 - download a zipped SAS transport file from the MEPS website
 - unzip the downloaded SAS transport file into a folder
 - convert the SAS transport file into a SAS data set in a pernament folder:
Written by: Pradip Muhuri with SAS(R) Institute's Technical Support 
************************************************************************/

%macro load_MEPS(file);
*Ex11_download_unzip_create.sas;
*** Task 1: Download the zipped SAS transport file from the MEPS web site;
Filename GoThere "C:\Data\&file.ssp.zip";
proc http 
   url="https://meps.ahrq.gov/data_files/pufs/&file.ssp.zip" 
   out=GoThere;
run;


*** Task 2: Unzip the SAS transport data file into the work folder;
filename inzip zip "c:\Data\&file.ssp.zip" ;
filename sit "C:\Users\pmuhuri\downloads\&file..ssp" ;
data _null_;
infile inzip(&file..ssp) lrecl=256 recfm=F length=length eof=eof unbuf;
file sit lrecl=256 recfm=N;
input;
put _infile_ $varying256. length;
return;
eof: stop;
run;

*** Task 3: Create a SAS data set from the SAS transport file;

libname test xport "C:\xtra\&file..ssp";
libname myfolder "C:\Data";
proc copy in=test out=Myfolder;
run;
%mend;

%load_meps(h50) %load_meps(h60) %load_meps(h70) %load_meps(h79) 
%load_meps(h89) %load_meps(h97) %load_meps(h105)
%load_meps(h113) %load_meps(h121) %load_meps(h129) %load_meps(h138) %load_meps(h147)
%load_meps(h155) %load_meps(h163) %load_meps(h171) %load_meps(h181) %load_meps(h192)





