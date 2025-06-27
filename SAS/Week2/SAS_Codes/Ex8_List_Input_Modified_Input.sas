*Ex8_List_Input_Modified_Input.sas (Part 1);

OPTIONS nodate nonumber ps=58 ls=98;

*List input style with LENGTH and INFORMAT statements; 
data work.Students_x; 
  length Id $6 Name $14 Address $16 City $20 State $2 zip $5 ; 
  informat Reg_date mmddyy10.;
  format Reg_date mmddyy10.;
  infile datalines dlm=',';
  input Id -- Reg_date;
datalines;
G009876, Ann Miller,2219 Pine St, Rockville,MD,28057, 08/20/2016
G008765, Rubi Tyson,6504 Spring St, Philadelphia,PA,19104,08/13/2016
;
PROC PRINT data=students_x noobs; 
RUN;

*Ex8_List_Input_Modified_Input.sas (Part 2);
*List input style with INFORMAT statement; 
data students_y; 
informat Id $6. Name $14. Address $16. City $20. State $2. zip $5. 
         Reg_date mmddyy10.;
format Reg_date mmddyy10.;
infile datalines dlm=',';
input Id -- Reg_date;
datalines;
G009876, Ann Miller,2219 Pine St, Rockville,MD,28057, 08/20/2016
G008765, Rubi Tyson,6504 Spring St, Philadelphia,PA,19104,08/13/2016
;
PROC PRINT data=students_y noobs;  
RUN;

/* Code Explnation (Part 3): 
  The CITY variable is read in as a character variable using 
  the $20.  ($w. ) Informat.   This informat tells SAS that the variable 
  is character with a length of 22.  
  The REG_DATE variable is read as date informat MMDDYYw.  
  (the qualifier $w. is set to 10 since this date field occupies 10 spaces).

Points to remember (Modified List Input): 
The colon (:) format modifier enables you to use list input 
and also to specify an informat after a variable name, 
whether character or numeric. SAS reads until it encounters 
a blank column, the defined length of the variable (character only), 
or the end of the data line, whichever comes first.

*/

*Ex8_List_Input_Modified_Input.sas (Part 3);
* List input style with colon modifier;
data students_z; 
infile datalines dlm=',';
input Id :$6. Name :$14. Address :$16. City :$20. 
      State :$2. zip :$5. Reg_date :mmddyy.;
format Reg_date mmddyy10.;
datalines;
G009876, Ann Miller,2219 Pine St, Rockville,MD,28057, 08/20/2016
G008765, Rubi Tyson,6504 Spring St, Philadelphia,PA,19104,08/13/2016
;
PROC PRINT data=students_z noobs;  
RUN;


*Ex8_List_Input_Modified_Input.sas (Part 4);
  DATA work.Have1; 
    INFORMAT visit_date mmddyy10. amount comma7.; 
    INPUT visit_date amount ;
	FORMAT visit_date mmddyy10. amount comma7.;
	DATALINES;		
    01/01/2013  125,000
    03/02/2014  38,000	
    12/18/2015 145,000
  ;
  PROC PRINT data=Have1 noobs; RUN;

  /* Notice that the mmddyyw.d informat does not specify a w value 
   and that the commaw.d informat does also not specify a w value.
   Here, we have used use the MMDDYY. INORMAT    instead of the 
   mmddyy10. INFORMAT. and the COMMA. INFORMAT instead of COMMA6.

   The rule is that you do not specify a w value to indicate the length 
   of a numeric variable when modifying list input with the 
   colon (:) modifier. 
   
  The quoted text below is from SAS Certification Preparation Guide: 
  Base Programming for SAS® 9 Third Edition (page 552).
  "...list input reads each value until the next blank is detected.  
  The default length of numeric variables is w, so you don’t need to 
  specify a w value to indicate the length of a numeric variable.
  This is different from using a numeric informat with formatted input.  
  In that case, you must specify a w value in order to indicate the 
  number of columns to be read."
*/
    
*Ex8_List_Input_Modified_Input.sas (Part 5);

  DATA Work.Have2; 
    INPUT visit_date :mmddyy. amount :comma.;
	FORMAT visit_date mmddyy10. amount comma7.;
	DATALINES;		
    01/01/2013      125,000
    03/02/2014      38,000	
    12/18/2015     145,000
  ;
  PROC PRINT data=Have2 noobs; run;

 
 




