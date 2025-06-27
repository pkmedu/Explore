*Ex6_Formated_Input_Dates.sas (Part 1);

DATA work.Have1;
INPUT            
            @1  date1 date11. 
            +1  date2 ddmmyy6.
            +1  date3 mmddyy10. 
            +1  date4 yymmdd8.
            +1  date5 ddmmyy10.
            +1  date6 mmddyy8.
            @1  c_date $11.;    /*re-read the very first field 
			                     as a character variable */

 * Convert the character date variable into a numeric variable
	using the INPUT function;

    n_date = input(c_date,anydtdte11.);

 FORMAT date1 date2 date3 date4 date5 date6 mmddyy10.
       n_date date9. ; 
DATALINES;
14/JAN/2015 140115 01-14-2015 15 01 14 14.01.2015 01/14/15
;
title "Using the original permanent formats (originally added to the variables in the DATA step)";
proc print data=work.have1; 
run;

title "Using the temporary formats in the PROC step";
proc print data=have1;
Format date1 date9. 
      date2 WORDDATE. 
      date3 WORDDATX. 
      date4 WEEKDATE. 
      date5 MONYY.  
      date6 DOWNAME.
      n_date mmddyy10.;
run;



/*Reading Dates Using ANYDATE Informat 

 You can use an ANYDTDTE informat to read in dates
 of different structures including: 

	• DATE, DATETIME, TIME, DDMMYY, 
	• MMDDYY, and YYMMDD 
	• JULIAN, MONYY, and YYQ 

You can also use the following INFORMATs to extract parts of dates:

• ANYDTDTE. Extracts the date portion 
• ANYDTDTM. Extracts the datetime portion 
• ANYDTTME. Extracts the time portion
Adapted from Venky Chakraborty's PharmaSUG2010 paper
*/

*Ex6_Formated_Input_Dates.sas (Part 2);
title ' ';
data work.date_data;
input @1 mix_dates anydtdte19.;
format mix_dates date9.;
datalines;
27Aug2018
08/27/2018
27Aug2018 3:30:32.8
180827
08272018
SEP2018
18Q4
;
proc print data=date_data;
run;

*Ex6_Formated_Input_Dates.sas (Part 3);
* Use of Colon Modifier;
data Modified_List_input_date;
   infile datalines DLM = ',';
   input date :mmddyy. copay_amount;
   month_name=put(date,monname3.);
   format date mmddyy10.;
datalines;
10/05/2004,25
11/5/2004,25
;
proc print data=Modified_List_input_date noobs;
run;

*Ex6_Formated_Input_Dates.sas (Part 4);
data Modified_List_input_x;
	input ID $ Date_Time :DATETIME.   In_out $ ;
	date = datepart(Date_Time);
	time = timepart(Date_Time);
	FORMAT Date_Time DATETIME. date date9. time time10.2;
DATALINES;
E1 18FEB15:07:35 In 
E2 20MAR15:09:15 In 
E3 28FEB05:19:05 Out 
E4 01MAR05:17:28 Out 
;
run;
proc print data=Modified_List_input_x noobs ;
run;

*Ex6_Formated_Input_Dates.sas (Part 5);
* Date Constatnt, and DHMS and DATEPART Functions;
data _null_;
  d='13JAN2016'd;
  put d date.;
  dt=dhms(d,0,0,0);
  put dt datetime.;
  d =datepart(dt);
  put d date.;
run;

data temp1;
   INFILE datalines DLM=',';
   INPUT state_name  : $ 22. dayOfweek : $ 10. 
         Monthday : $15. year ;
         date_entry=strip(dayofweek)||', '||
                    strip(monthday)||', '||
                    strip(year);
   DATALINES;
     Delaware, Friday,  December 7, 1787
     Pennsylvania, Wednesday,  December 12, 1787
     New Jersey, Tuesday,  December 18, 1787
     South Carolina, Friday,  May 23, 1788
;
proc print data=temp1 noobs; run;

*Ex6_Formated_Input_Dates.sas (Part 6);
data temp2;
   INFILE datalines DLM=',';
   INPUT state_name  : $ 22. dayOfweek : $ 10. 
         Monthday : $15. year ;
         date_entry=catx(',', dayofweek, monthday,year);
   DATALINES;
     Delaware, Friday,  December 7, 1787
     Pennsylvania, Wednesday,  December 12, 1787
     New Jersey, Tuesday,  December 18, 1787
     South Carolina, Friday,  May 23, 1788
;
proc print data=temp2 noobs; run;

/* Scenario: Read dates that fall in the 18th century 
using the YEARCUTOFF option, which defines the beginning 
of the 100-year period for those digit year.
In SAS 9.4, the SAS default value for this option
is 1926.

You use this option when your date variable contains
a 2-digit year value (e.g., 78 instead of 1778) and 
the year values are outside of the 100-year span from
1920 to 2019 that is implied by the SAS default option 
YEARCUTOFF=1920.  In the example below, we read in SAS 
the dates when four States joined the Union.  
Since these dates are outside of the default 100-year span
(1920-2019), we need to override the default option by 
using the option YEARCUTOFF=1720 to ensure that all the
dates we are reading range from years 1720 to 1820.
*/

*Ex6_Formated_Input_Dates.sas (Part 7);
options yearcutoff=1720;
data yc;
   INPUT state_name  & $22. date_entry :mmddyy.; 
   FORMAT date_entry :mmddyy10.;
DATALINES;
Delaware  12/07/87
Pennsylvania  12/12/87
New Jersey  12/18/87
South Carolina  05/23/88
;
proc print data=yc noobs; 
run;

