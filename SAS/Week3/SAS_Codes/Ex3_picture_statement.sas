*Ex3_Picture_Statement.sas (Part 1);
/* 
Use the PROC FORMAT PICTURE statement to specify a template 
 (up to 40 characters enclosed in quotation marks) for labeling numbers.

There are three types of characters in the template.
* Digit selectors (e.g., 0 through 9)
* Message characters (e.g., M for Million, B for Billion) 
* Directives (special characters e.g.,  %A %B %d %Y - to format date values)
*/
Proc format;
 picture week_x 1-52='99'; /*Non-zero digit selector*/
 picture week_y 1-52 ='00';  /*Zero digit selector*/
 run;
 data have;
   input week @@;
     * Create two new variables based on the original variable;
     week_x = week;
     week_y = week;
 datalines; 
 1 3  6 8 9 14 15 34 52
 ;
options nocenter nodate nosource;
title1 'Ex3_Picture_Statement.sas (Part 1)';
title2 'Non-zero digit selectors in the PICTURE format add zeros to the formatted value for WEEK_X as needed';
title3 'Zero digit selectors in the PICTURE format do not add zeros to the formatted value for WEEK_Y';
proc print data=have noobs;
 var week week_x week_y;
 format week_x week_x. week_y week_y.;
run;
title3;
*Ex3_Picture_Statement.sas (Part 2);

/*
Create picture formats to display:
* "billion" figures in millions (template showing digit selectors)
* "million" figures in thousands (template showing digit selectors)
* "million" figures with template showing with message charactes

Code explanation (PROC FORMAT features):

* Keywords are low-high, representing the range of non-missing values to 
which the format will be applied.

* The MULT= specifies the number to multiply the variable's value 
before it is formatted.

* The Round option with the PICTURE statement rounds the data to the 
nearest integer before formatting.

* The message character (e.g., M) is inserted into the picture
after the numeric digits are formatted.

*/

proc format;
picture thou (round)
      low-high='000,000,000' (mult=.001);
picture mil (round)
      low-high='0,000,000,000' (mult=.000001);
picture m (round)
      low-high='0,000.9 M' (mult=.00001);
run;

  data work.Pop2005;
  input name $1-14 pop: comma.;
  pop_x = pop;
  pop_y=pop;
  pop_z=pop;
  datalines;
CHINA              1,323,344,591
INDIA              1,103,370,802
UNITED STATES        298,212,895
INDONESIA            222,781,487
BRAZIL               186,404,913
PAKISTAN             157,935,075
RUSSIA               143,201,572
;
title1 'Ex3_Picture_Statement.sas (Part 2)';
title2 'User-defined format that expresses the numbers in thousands and millions';
proc print data=work.pop2005 noobs split='*';
label pop='Population*Size'
      pop_x= 'Population*Size*(in millions)'
	  pop_y= 'Population*Size*(in thousands)'
      pop_z= 'Population*Size*(in M)'
;
Format pop comma14. pop_x mil. pop_y thou. pop_z m.;
run;

*Ex3_Picture_Statement.sas (Part 3);
/*
Code explanation (PROC FORMAT features):

* The Round option with the PICTURE statement rounds the data to the 
  nearest integer before formatting.

* PREFIX= specifies a character prefix for the formatted value.

* Leading 0's as digit selectors mean blanks.

* Nines mean some values.
*/
proc format;
  picture test (round)
         low-<0='09.99' (prefix='-')
         0-<10 ='09.99'
		 10-<100='99.9'
		 100-999 ='999';
run;

DATA temp;
INPUT  Some_value @@;
 datalines;
  457.677 7.219 0.303 -0.027 95.307 752.789 
  ; 
title1 'Ex3_Picture_Statement.sas (Part 3)';
title2 'User-defined format that expresses the decimal values in percentages';

proc print noobs; 
   var Some_value ;
   format Some_value test.;
run;
  
*Ex3_picture_statement.sas (Part 4);
PROC FORMAT;
 PICTURE p_fmt (ROUND)
     LOW-<0 = "009.99%" (PREFIX="-" MULT=10000)
         0-HIGH = "009.99%" (MULT=10000);
PICTURE p_fmt_x (ROUND)
     LOW-<0 = "009.99" (PREFIX="-" MULT=10000)
         0-HIGH = "009.99" (MULT=10000);
RUN;
DATA work.have;
 INPUT Value1 @@;
 Value2 = Value1; Value3 = Value1;
 Value4 = Value1; Value5 = Value1;
DATALINES;
0.0345678  -0.00123456  -0.456789 .120
;
options nodate nonumber;
title1 'Ex3_Picture_Statement.sas (Part 4)';
title2 'SAS Formats and User-Defined Formats Applied';

PROC PRINT DATA=work.have SPLIT="*" NOOBS;
 VAR Value: ;
 FORMAT Value2 PERCENT8.2  Value3 PERCENTN8.2  
        Value4 p_fmt. Value5 p_fmt_x.;
 LABEL Value1="No"*"Format"*"Applied"
       Value2="SAS"*"Percent"*"Format"*"PERCENT8.2"*"Applied"
	   Value3="SAS"*"Percent"*"Format"*"PERCENTN8.2"*"Applied"
       Value4="User"*"Picture"*"Format 1"*"Applied"
	   Value5="User"*"Picture"*"Format 2"*"Applied";
RUN;

*Ex3_picture_statement.sas (Part 5);
/*
   The % followed by a letter indicates a directive.
   %A - full weekday name
   %B - full month name
   %D - day of the month 
   %Y - four-digit year
   The Datatype PICTURE option specifies that the above format 
   will be applied to a SAS date, SAS time or SAS datetime. 
   */
proc format; 
      picture date_fmt(default = 45)
      other='%A, %B %D,%Y' (datatype=date); 
   run;
 
 data have; 
    some_date1=today(); 
	some_date2='01Jul2019'd;
  run;
options nodate nonumber;
title1 'Ex3_Picture_Statement.sas (Part 5)';
title2 'User-Defined Picture Formats Applied';

PROC PRINT DATA=have NOOBS;
 VAR Some: ; 
format Some:  date_fmt.;
run;
