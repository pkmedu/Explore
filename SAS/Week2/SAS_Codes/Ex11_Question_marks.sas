*Ex11_Question_marks.sas (Part 1);

/*
The single question mark (?) format modifier 
in the INPUT statement below suppresses the invalid data message.

The second data record has the invalid data in the “date” field.

*/
data temp2;
   infile datalines DLM = ',';
   input date ? :mmddyy.  copay_amount;
    format date mmddyy10.;
datalines;
10/05/2004,25
02/29/2015,25
;
proc print data=temp2; run;
/*
The ?? format modifier also suppresses the invalid data message and, 
in addition, prevents the automatic variable _ERROR_ 
from being set to 1 when invalid data are read.
[See SAS® Documentation for details]
*/
*Ex11_Question_marks.sas (Part 2);
data temp3;
   infile datalines DLM = ',';
   input date ?? :mmddyy.  copay_amount;
   format date mmddyy10.;
datalines;
10/05/2004,25
02/29/2015,25
;
proc print data=temp3; run;




