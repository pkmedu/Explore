```sas
dm "log; clear; output; clear; odsresults; clear;";
Proc export data=sashelp.demographics 
       (keep=region name pop
        rename=(region=%sysfunc(lowcase(region))
                name=%sysfunc(lowcase(name))
			    pop=%sysfunc(lowcase(pop))
              )
       )
    outfile="c:\data\sashelp_demographics.csv"   
    dbms=CSV  replace ;
run;
```

```SAS
/* format the current date as "YYYY-MM-DD" */
%let current_date = %sysfunc(today());
%let formatted_date = %sysfunc(putn(&current_date., yymmdd10.));
proc export 
  	data=sashelp.class 
  	dbms=xlsx 
  	outfile="C:\Data\Class_&formatted_date..xlsx"
  	replace;
run;

```
The following code converts the SAS data set to a Stata data set.
```SAS
proc export data=sashelSp.class replace 
         outfile= "C:\Data\class.dta";
run;
```
```SAS

ods excel file = 'C:\Data\SASHELP_Datasets_10_14_2020.xlsx'
   options (embedded_titles='on'  sheet_name='List'); 
title "Listing of SASHELP Data Sets";
proc sql number;
  select memname,nobs format=comma10.
         ,nvar format=comma7.
         ,DATEPART(crdate) format date9. as Date_created label='Creation Date'
	 ,TIMEPART(crdate) format timeampm. as Time_created label='Creation Time'
       from dictionary.tables
       where libname = 'SASHELP' 
        and memtype = 'DATA';
     quit;

  ods excel close;
  ods listing;
```
