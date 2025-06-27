*Ex11_one_multiple_mvars_sql.sas (Part 1);
proc sql noprint;
 select count(*)
        INTO :nobs
		FROM SASHELP.CARS;
quit;
%put Number of Observations = %SYSFUNC(LEFT(&nobs));
run;

*Ex11_one_multiple_mvars_sql.sas (Part 2);
Options nosymbolgen;
proc sql noprint;
 select distinct make
        INTO :makes separated by ',' 
	    FROM SASHELP.CARS;
quit;
%put List of Values of Car Make (Unique) : &makes;

*Ex11_one_multiple_mvars_sql.sas (Part 3);
%let Put_title = List of Values into a Series of Macro Variables;
proc sql noprint;
 select distinct make
        INTO :makes1-
		FROM SASHELP.CARS ;
 %put Number of Rows: &sqlobs;
quit;
%macro reveal;
 %put &Put_title;
 %Do i=1 %TO &Sqlobs;
    %put &&makes&i;
  %end;
%mend reveal;
%reveal

*More examples;
*Ex11_one_multiple_mvars_sql.sas (Part 4);
*Create a macro variable containing a single value that equals the
number of distinct value of a DATA step variable;

proc sql;
    select count(distinct Sex) into :sex_value
    from sashelp.class;
 quit;
 %put &sex_value;

*Ex11_one_multiple_mvars_sql.sas (Part 5);

 *Create multiple macro variables, each containing a distinct 
  value of a DATA step variable;

 proc sql;
    select distinct Sex into :sex1-
    from sashelp.class;
 %put Number of Rows: &sqlobs;
 quit;
 %macro reveal;
 %put &Put_title;
 %Do i=1 %TO &Sqlobs;
    %put &&makes&i;
  %end;
%mend reveal;
%reveal







