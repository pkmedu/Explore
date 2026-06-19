*Ex4_Value_cntlin_compared.sas;
proc format ;
value $xcausesfmt A00 =	 "Cholera "
                  A00.0 = "Cholera due to Vibrio cholerae 01, biovar cholerae" 
                  A00.1	= "Cholera due to Vibrio cholerae 01, biovar eltor" 
                  A01.1	= "Paratyphoid fever A" 
                  A01.2	= "Paratyphoid fever B" 
                  A01.3	= "Paratyphoid fever C" 
                  A01.4	= "Paratyphoid fever, unspecified" 
                  A02	= "Other salmonella infections" 
                  A02.0	= "Salmonella enteritis" 
                  A02.1	= "Salmonella septicaemia" 
;
data have1; 
input id $ cause_dth_code $ @@;
format cause_dth_code $xcausesfmt.; 
datalines; 
12345 A01.4 23456 A01.3 34567 A02.0
; 
title1 "Format created using the PROC FORMAT VALUE statement";
proc print data=have1 noobs; run;

data causes_of_death;
 retain FMTNAME '$causesfmt' type 'C';;
input START $ LABEL & $50.;
datalines;
A00	    Cholera 
A00.0	Cholera due to Vibrio cholerae 01, biovar cholerae 
A00.1	Cholera due to Vibrio cholerae 01, biovar eltor 
A01.1	Paratyphoid fever A 
A01.2	Paratyphoid fever B 
A01.3	Paratyphoid fever C 
A01.4	Paratyphoid fever, unspecified 
A02	    Other salmonella infections 
A02.0	Salmonella enteritis 
A02.1	Salmonella septicaemia 
;

proc sort data=causes_of_death
  out=causes_of_death nodupkey;
  by START;
run;
proc format cntlin=causes_of_death;
run;

data have2; 
input id $ cause_dth_code $ @@;
format cause_dth_code $causesfmt.; 
datalines; 
12345 A01.4 23456 A01.3 34567 A02.0
; 
title1 "Format created using the PROC FORMAT cntlin= optiion";
proc print data=have2; run;

/*CNTLIN= Option
Creating a User-Defined Format from a SAS Data Set
If there is a long list of variable values and if the values and 
their labels are available in an electronic file 
(ASCII, EXCEL or data base mode), the file can be read into SAS to 
create a SAS data set. There is no need to type this long list under the PROC FORMAT VALUE statement!  
Requirements: The data set must have three required columns–
FMTNAME, START, and LABEL.  The data set can have the optional 
column called the TYPE column with values of ‘C’ for the character variable 
and ‘N’ for the numeric variable.   
The CNTLIN=input-control-SAS-data-set (as shown in line 42 below) 
specifies a SAS data set from which PROC FORMAT builds INFORMATs. 
Note that CNTLIN= builds FORMATS and INFORMATS without using a VALUE, 
PICTURE, or INVALUE statement. 

*/

dm "log; clear; output; clear; odsresults; clear;";
OPTIONS FORMCHAR="|----|+|---+=|-/\<>*";
options validvarname=any;
Libname new "C:\SASCourse\Week3";
libname XL XLSX 'C:\SASCourse\Week3\MEPS_MCCC.xlsx';
data work.MCCC_Data
     new.MCCC_Data (keep=CCSR_Code MCCC FMTNAME
                          rename=(CCSR_Code=start mccc=label));
	 retain FMTNAME '$MCCC_fmt' type 'C';
  set XL.sheet1;
run;
libname XL CLEAR; 
proc print data=new.MCCC_Data 
               (drop=FMTNAME obs=5); 
run;

proc sort data=new.MCCC_Data
  out=new.MCCC_fmt_data nodupkey;
  by START;
run;

proc format LIBRARY=new cntlin=new.MCCC_fmt_data;
run;


proc format LIBRARY=new.formats fmtlib;
 select $MCCC_fmt;
run;






