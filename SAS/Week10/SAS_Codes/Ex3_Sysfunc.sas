*Ex2_sysfunc.sas;


*Example _SAS-L.sas;
data _Null_; x1=today(); x2=intnx('year',x1,-2,'s');
format x1 x2 date9.; PUT @4  x1= x2=; run;

%let x1=%sysfunc(today(),date9.);
%let x2=%sysfunc(intnx(year,%sysfunc(today()),-2,s),date9.);
%put &x1 &x2;

%let x3=%sysfunc(today());
%let x4=%sysfunc(intnx(year,%sysfunc(today()),-2,s));
%put &x3 &x4;

%let x5 = '27jan2016'd;  
%let x6 = '27dec2014'd; 
%put &x5 &x6 ;

%let x7=%sysfunc(today(),monname3.);
%let x8=%sysfunc(intnx(month,%sysfunc(today()),1),monname3.);
%put &x7 &x8 ;

%let x9=%sysfunc(today(),year.);
%let x10=%sysfunc(intnx(month,%sysfunc(today()),-1,s),year.);
%put &x9 &x10;

%let x11=%sysfunc(intnx(year,%sysfunc(today()),-1),year.);
%let x12=%sysfunc(intnx(year,%sysfunc(today()),2),year.);
%put &x11 &x12;

%let x13=%sysfunc(intnx(month,%sysfunc(today()),1));
%let x14=%sysfunc(putn(%eval(&x13-1),year.));
%put &x13 &x14;

%let x15=%sysfunc(intnx(month,'01dec2015'd,1));
%let x16=%sysfunc(putn(%eval(&x15-1),year.));
%let x17=%sysfunc(putn(&x15,monname3.));
%put &x15 &x16 &x17;

Title "Date Geneated on %sysfunc(left(%qsysfunc(today(), worddate.)))";

**************************;
/*SAS Code (Adapted from SAS Listserve)
Example _SAS-L.sas; Adapted from SAS-L */
data _Null_; x1=today(); x2=intnx('year',x1,-2,'s');
format x1 x2 date9.; PUT @4  x1= x2=; run;
%let x1=%sysfunc(today(),date9.);
%let x2=%sysfunc(intnx(year,%sysfunc(today()),-2,s),date9.);
%put &x1 &x2;
%let x3=%sysfunc(today());
%let x4=%sysfunc(intnx(year,%sysfunc(today()),-2,s));
%put &x3 &x4;
%let x5 = '27jan2016'd;  
%let x6 = '27dec2014'd; 
%put &x5 &x6 ;
%let x7=%sysfunc(today(),monname3.);
%let x8=%sysfunc(intnx(month,%sysfunc(today()),1),monname3.);
%put &x7 &x8
%let x9=%sysfunc(today(),year.);
%let x10=%sysfunc(intnx(month,%sysfunc(today()),-1,s),year.);
%put &x9 &x10;
%let x11=%sysfunc(intnx(year,%sysfunc(today()),-1),year.);
%let x12=%sysfunc(intnx(year,%sysfunc(today()),2),year.);
%put &x11 &x12;
%let x13=%sysfunc(intnx(month,%sysfunc(today()),1));
%let x14=%sysfunc(putn(%eval(&x13-1),year.));
%put &x13 &x14;
%let x15=%sysfunc(intnx(month,'01dec2015'd,1));
%let x16=%sysfunc(putn(%eval(&x15-1),year.));
%let x17=%sysfunc(putn(&x15,monname3.));
%put &x15 &x16 &x17;
/*SAS-L Examples end above.*/
%let x18=%sysfunc(left(%qsysfunc(today(), worddate.)));
%put &x18;



%let date_hr = %sysfunc(intnx(month, &date_arr, - 3  ,e), ddmmyy10.);

%put  &date_hr ;



/*
https://communities.sas.com/t5/SAS-Programming/countw-and-double-quoted-string-list/td-p/106084
Author Haikuo - 08/09/2013;
*/

  %let lst= '1234' '3222' '0056';

data _null_;
  j = countw("&lst2");
  put j=;
run;

 %let lst2= "1234" "3222" "0056" "12345" "123456";
 %put &=lst2;
 %put %sysfunc(countw(%sysfunc(quote(&lst2))) );


  %let lst3= '1234', '3222', '0056';
 %put %sysfunc(countw(%sysfunc(quote(&lst3))),%str(,) );


 Data work.Created_%sysfunc(today(),date9.);
  set sashelp.class;
run;


*The following is from the SAS Documentation;
proc format;
  value category
  Low-<0  = 'Less Than Zero'
  0       = 'Equal To Zero'
  0<-high = 'Greater Than Zero'
  other   = 'Missing';
run;
%macro try(parm);
  %put &parm is %sysfunc(putn(&parm,category.));
%mend;
%try(1.02)
%try(.)
%try(-.38)


options nodate nonumber;
title1 "%sysfunc(date(),worddate.) Class Report";
proc print data=sashelp.class (obs=3);
run;

/* SAS Docementation 9.4 - Example 1 */

/* %SYSFUNC executes the TRANSLATE function to translate the Ns in a string to Ps.  */

%let string1 = V01N01-V01N10;
%let string1 = %sysfunc(translate(&string1,P, N));
%put With N translated to P, V01N01-V01N10 is &string1;

*** %QSYSCFUNC Function;
%put %sysfunc(left(%qsysfunc(today(), worddate.)));


*SAS Documentation 9.4;
%macro checkds(dsn);
   %if %sysfunc(exist(&dsn)) %then
      %do;
         proc print data=&dsn;
         run;
      %end;
      %else
         %put The data set &dsn does not exist.;
%mend checkds;
%checkds(Sasuser.Houses)


*Ex23_Sysfunc_DateStamp.sas;
options nocenter nodate nonumber;
*Author of this code: Art Carpenter;
title1 " %left(%qsysfunc(date(),worddate18.))";
title2 'Listing from SASHELP.class';
proc print data=sashelp.class (obs=5);
run;


*https://communities.sas.com/t5/SAS-Programming/Datestamp-output/td-p/32367;
*Author: TheShark;
PROC FORMAT;
PICTURE datestamp(default=15)
   other='%Y%0m%0d%0H%0M%0S' (datatype=datetime);
RUN;
 
%let datestamp=%sysfunc(datetime(), datestamp.);

data class_&datestamp.;
set sashelp.class;
RUN;
title "&datestamp - Listing of Class Data";
proc print data=class_&datestamp;
run;










