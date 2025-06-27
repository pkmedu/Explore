%Let Path = C:\Users\pmuhuri\SASCourse\Week11\SAS_Codes;
%macro split (indsn=, keyvar=, targvarlist= );
data 
%do i=1 %to %sysfunc(countw(&targvarlist.) );
   %let targvar = %scan(&targvarlist.,&i.);
   work.&targvar. (keep= &keyvar &targvar)
%end;
;  /* this ; ends the data statement*/

set &indsn.;
run;
%mend;
filename mprint "&Path\Ex27_Generated_Code.sas";
options mprint mfile;
%split (indsn=sashelp.class, keyvar=name, targvarlist=age weight height sex)

