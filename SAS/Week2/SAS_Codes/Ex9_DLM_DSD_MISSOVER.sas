*Ex9_DLM_DSD_MISSOVER.sas (Part 1);
dm 'log; clear; output; clear; results; clear';
data DLM_data;
infile datalines DLM=',';
input airport :$3. departures:8. airlines:8. date:mmddyy10.; 
format date date9.;
datalines;
DCA,617,16,05/18/2018
;
proc print data=DLM_data;
run;

*Ex9_DLM_DSD_MISSOVER.sas (Part 2);
*Use of the DLM= and DSD options;
data DSD_data;
infile datalines  DLM='/' DSD;
input airport: $3. departures :8. airlines :8. date :mmddyy10.; 
format date date9.;
datalines;
DCA/617//"05/18/2018"
;
proc print data=DSD_data;
run;
/* For the code chunk below, the DLM option is not needed,
 because we are using a comma-delimited file. 

Use the DSD Option on the INFILE statement, and 
the ampersand (&) and tilde modifiers (~) 
in the INPUT Statement for the following 
kinds of data values
*/


*Ex9_DLM_DSD_MISSOVER.sas (Part 3);
data DSD_data_X;
infile datalines  DSD;
input airport: $3. departures :8. airlines :8. date :mmddyy10.; 
format date date9.;
datalines;
DCA,617,,"05/18/2018"
;
proc print data=DSD_data_X;
run;



 /* The ~ (tilde) format modifier enables to read delimiter-embedded 
    numeric/character values within double quotation marks and 
    retain this kind of data values. 

   The DSD option on the INFILE statement must be used to get the 
   desired effect of this format modifier.
*/
*Ex9_DLM_DSD_MISSOVER.sas (Part 4);
  DATA Work.Quotation_Surrounded_Values;   
    INFILE DATALINES DSD;
    INPUT st_name ~ $33. percent_pop18p ;
 DATALINES;		
 "Alabama, The Yellowhammer State", 77.0
 "California, The Golden State",  76.1	
 ;
 PROC PRINT;RUN;

 /* In the example-code below, the DSD option is not required because the missing data 
   is not marked by consecutive delimiters. The MISSOVER option, which is required,
   prevents from SAS from loading new record when the end of the 
   current record is reached. */

*Ex9_DLM_DSD_MISSOVER.sas (Part5);
* MISSOVER option on the INFILE statement;
data M_data;
   infile datalines missover;
   input id:1. course :$9.;
   datalines; 
   1 Stat4197
   2 Stat4197
   3  
   4 Stat6197
   ;
proc print data=M_data;
run;

