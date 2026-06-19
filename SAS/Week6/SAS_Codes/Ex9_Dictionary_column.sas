*Ex9_Dictionary_column.sas (Part 1);
OPTIONS nocenter nodate nonumber ;
Title1 'Get column names and column type from a particular SAS Table';
proc sql;
 SELECT NAME, TYPE, LABEL  
  FROM DICTIONARY.COLUMNS  
   WHERE UPCASE(LIBNAME)="SASHELP" AND  
         UPCASE(MEMNAME)="HEART";  
QUIT;

*Ex9_Dictionary_column.sas (Part 2);
Title 'Get the column names that are the same in all SAS tables in the same library';
OPTIONS nocenter nodate nonumber ;
proc sql;
 SELECT MEMNAME 'Table Names', NAME
  FROM DICTIONARY.COLUMNS  
   WHERE UPCASE(LIBNAME)="SASHELP" AND  
         UPCASE(NAME)="WEIGHT";  
QUIT;

*Ex9_Dictionary_column.sas (Part 3);
OPTIONS nocenter nodate nonumber ;
proc sql noprint; 
     select name into : COLNAMES separated by ' ' 
     from dictionary.columns 
     where LIBNAME='SASHELP' and memname = UPCASE('class');
 quit; 

 %put  Get a horizontal list of column names of a SAS table: &COLNAMES;

 * Contributed by Reza to SAS-L - 9/25/2018;

/* SASHELP.VTABLE has the information on the number of 
  numeric variables and the number of character variables
  for every SAS dataset: num_character, num_numeric.*/

* Get this information into macro variables and then extract;

 *Ex9_Dictionary_column.sas (Part 4);
* Solution 1 - PROC SQL Approach;
 
%let lref=SASHELP;
%let dsn=CLASS;

proc sql noprint;
select num_character, num_numeric into :n_char_x, :n_num_x
from sashelp.vtable
where libname = upcase("&lref.") and upcase(memname) = upcase("&dsn.");
quit;

%put Number of character variables = &n_char_x;
%put Number of numeric variables = &n_num_x;



 *Ex9_Dictionary_column.sas (Part 5);
*** Solution 2 SUM function in PROC SQL;
/* Query the SASHELP or DICTIONARY table*/

%let lref=SASHELP;
%let dsn=CARS;

proc sql noprint;
select sum(type='char'), sum(Type='num') into :n_char, :n_num
from sashelp.vcolumn
where libname = upcase("&lref.") and upcase(memname) = upcase("&dsn.");
quit;

%put Number of character variables = &n_char_x;
%put Number of numeric variables = &n_num_x;


 *Ex9_Dictionary_column.sas (Part 6);
*  Solution 3 - Data Step Approach;
Data test;
  set sashelp.cars;
  array nums(*) _numeric_;
  array chrs(*) _character_;
     call symputx('nb1',dim(nums),'G');
     call symputx('nb2',dim(chrs),'G');
run;

%put Number of numeric variables = &nb1;
%put Number of numeric variables = &nb2;

 *Ex9_Dictionary_column.sas (Part 7);

proc sql noprint; 
 select name into :varlist_status separated by ' '
 from dictionary.columns
 where libname='SASHELP' and memname='HEART'
 and name like "%#_Status" escape '#';
 quit;
%put &varlist_status;
