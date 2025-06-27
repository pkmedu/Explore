*Ex6_Finding_Invalids.sas (Part 1);
/*
Method 1
In the INPUT statement below, the ?? format modifier for the 
S_DATE variable suppresses the invalid data message and, 
in addition, prevents the automatic variable _ERROR_ 
from being set to 1 when invalid data are read.
[See SAS® Documentation for details]
Also see Week2 "Ex11_Question_marks.sas
*/

options nodate nonumber;
PROC FORMAT;
VALUE date_fmt 
   LOW-HIGH = 'valid date'
    other='invalid date';  
run;
DATA work.HAVE;
infile datalines firstobs=2;
input Name $ 1-7 
      @8 s_date ?? mmddyy10.
      @8 s_date_ch $10.;
format s_date mmddyy10. ;
datalines;
12345678901234567890
Alfred 04/22/2005
Alice  01/15/2005
Barbara12/20/2004
Carol  10/29/1999
Henry  02/31/2007
Philip 02/31/2005
Ronald 02/29/2006
;
 Title 'Table lookup using a user-defined format';
proc freq DATA=work.Have;
  table s_date /missing ;
  format S_date date_fmt.;
RUN;

Title "Listing of S_DATE_CH values (invalid dates)"; 
proc print DATA=HAVE noobs;
  var Name s_date_ch;
  where S_date= .;
RUN;

*Ex6_Finding_Invalids.sas (Part 2);
/*
Method 2
Use a sum statement to accumulate the count of bad dates (i.e., S_date=.) 
during DATA step execution.

During the first iteration, specify the column position as well as the text
to the LOG window.

Output to the LOG window the values of bad dates from the 
   "character date variable" (i.e., S_date_ch) at the specified
   column position if the "numeric date variable" (i.e. S_date) 
   has a missing value.

The format argument is the equal sign so that the text (within quotes)
   as well as the variable name precedes it value.

*/
options nodate nonumber;
DATA _NULL_;
infile 'C:/SASCourse/Week3/Sample_dates.txt' firstobs=2 END=lastobs;
input Name $ 1-7 
      @8 s_date ?? mmddyy10.
      @8 s_date_ch $10.;

if s_date = . then invalid_dates+1; 
if _n_=1 then put @10 'List of invalid dates:'; 
if s_date = . then put @10 s_date_ch ;
if lastobs then  put @10 'Number of invalid dates = ' invalid_dates;
run;
