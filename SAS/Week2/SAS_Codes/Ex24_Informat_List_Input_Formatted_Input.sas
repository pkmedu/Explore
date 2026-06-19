*Ex24_Informat_List_Input_Formatted_Input.sas (Part 1);
Data MLI; 
infile datalines firstobs=2;
input Address & $50. income :comma.;
format income dollar10.2;
datalines;
123456789012345678901234567890123456789012345678901234567890
Ann Tye 2219 Pine St Rockville MD 28057  $89,500.50
Rubi Tyson 6504 Spring St Philadelphia PA 19104  $46,500.00
;
/*
In the above code, the & modifier indicates that the value for 
Address should be read until two consecutive blanks are encountered.
Therefore, in the FIRST RECORD, the value Address is read from 
column 1 to 39. When blanks are encountered in both columns 40 and 41, 
the value is written to the PDV.

The LIST INPUT reads until the next blank is detected.  The default
length of numeric variables is 8. So you don't need to specify a w value
to indicate the length of a numeric variable.

This is different from using a numeric informat with formatted input 
(see the second example below).  In that case, you must specify a w value
in order to indicate the number of columns to be read.

*/
title 'Modified List Input';
PROC print data=MLI; run;
PROC contents data=MLI varnum; 
ods select position; 
RUN;

* Ex24_Informat_List_Input_Formatted_Input.sas (Part 2);
Data FI; 
infile datalines firstobs=2;
input @1 Address $50. @51 income comma10.2;
format income dollar10.2;
datalines;
123456789012345678901234567890123456789012345678901234567890
Ann Tye 2219 Pine St Rockville MD 28057           $89,500.50
Rubi Tyson 6504 Spring St Philadelphia PA 19104   $46,500.00 
;
title 'Formatted Input';
PROC print data=FI; run;
PROC contents data=FI varnum; 
ods select position; 
RUN;
