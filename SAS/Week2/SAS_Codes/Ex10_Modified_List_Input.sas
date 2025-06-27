/* In the example-code below, the & modifier after the  variable ST_NAME, which indicates 
   that its value should be read until two consecutive blanks 
   are encountered. 

   Also note the comma. Informat for the variable pop. 
  The quoted text below is from SAS Certification Preparation Guide: 
  Base Programming for SAS® 9 Third Edition (page 552).

  "...list input reads each value until the next blank is detected.  
  The default length of numeric variables is w, so you don’t need to 
  specify a w value to indicate the length of a numeric variable.
  This is different from using a numeric informat with formatted input.  
  In that case, you must specify a w value in order to indicate the 
  number of columns to be read."

   In the data, there two blanks instead of one blank after each of 
   the data values: Alabama, California, and District of Columbia; 
   two blanks, which are required.
*/


*Ex10_Modified_List_Input.sas;
OPTIONS nodate nonumber ps=58 ls=98;
  DATA work.Have1;   
    INPUT st_name & $20. pop :comma. percent_pop18p ;
	FORMAT pop comma10.;
	DATALINES;		
    Alabama  4,833,722  77
    California  38,332,521 76.1	
    District of Columbia  646,449 82.8
  ;
  PROC PRINT data=HAVE1 noobs;  RUN;







