*Ex2_column_Input_PAD_Option.sas;
*** To clean up the "work" library used;
proc datasets lib=work nolist kill; quit;

data HAVE;
*** LRECL= and PAD option on the INFILE statement;
 infile 'C:\SASCourse\Week2\SAS_Codes\short_records.txt'
         Lrecl=25 pad;
 input id 1-3 name $ 5-16 
       score 18-19 @21 some_value 5.2;
proc print data=HAVE noobs; run;


/*Note: The PAD option in the INFILE statement has caused 
the DATA step to correctly assign missing values
for the data field (score_value) at the end of the "shorter"
record.*/
