*Ex4_Formatted_Input.sas;

OPTIONS nocenter nonumber nodate;
/*Formatted input - 
  Column pointer control that moves the pointer COLUMN n */

data have1;  
infile datalines firstobs=3;   /*Read from the 3rd record - Why? */
input software $5.             /* $w.informat left-justifies the value*/
      @1 x_software $char5.     /* $char informat right-justifies the value*/
      @7 book_titles 3.         /*SAS moves the pointer to column 7*/
      @11 date_searched mmddyy10.; /*Informat specified*/ 
format date_searched mmddyy10.;    /*Format specified*/
datalines; 
http://r4stats.com/articles/popularity/
12345678901234567890
  SAS 576 06/01/2015
 SPSS 339 07/01/2015
    R 240 08/01/2015
Stata  62 09/01/2015
;  
title 'Formatted Input';  
proc print data=Have1 noobs ; run;
proc contents data=Have1 p; 
ods select position;
run;


/*Formatted input - 
  Column pointer control that moves the pointer n POSITIONS */

data Have2;  
infile datalines firstobs=3;   /*Read from the 3rd record - Why? */
input software $5.             /* $w.informat left-justifies the value*/
      @1 x_software $char5.     /* $char informat right-justifies the value*/
      +1 book_titles 3.         /*SAS moves the pointer to 1 position */
      +1 date_searched mmddyy10.; /*informat specified */ 
format date_searched mmddyy10.;    /*Format specified */
datalines; 
http://r4stats.com/articles/popularity/
12345678901234567890
  SAS 576 06/01/2015
 SPSS 339 07/01/2015
    R 240 08/01/2015
Stata  62 09/01/2015
;   
title 'Formatted Input';                                                                                            
proc print data=Have2 noobs ; run;

/*
Point to remember: You must use informats to read numeric values
that contain letters or other special characters (e.g., / in the
above example).
*/

