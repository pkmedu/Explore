*Ex27_Amper_Modifier.sas;

DATA Work.Have; 
    INPUT st_name & $ 22. visit_date :mmddyy. ;
	FORMAT visit_date mmddyy10.;
	DATALINES;		
    Washington DC,  01/01/2013  
    ;
PROC PRINT data=work.Have noobs; 
run;
