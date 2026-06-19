*Ex9b_SASHELP_Dict_Tables;
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


