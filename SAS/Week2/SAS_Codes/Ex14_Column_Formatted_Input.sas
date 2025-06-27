*Ex14_Column_Formatted_Input.sas;

data Mix_column_Formatted;    
input software $1-5 @9 date date9. @21 amount comma5.;     
format date date9. amount comma5.;      
datalines;                                                                                                                              
SAS     06jan1976   2,345       
Stata 	05jan1998   1,560  
R       07jun1996   4,567  
;                                                                                                      
proc print data=Mix_column_Formatted noobs; 
run; 
