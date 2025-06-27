
/*You can use a two-level name to reference a temporary SAS Data Set, 
but the libref must be named as WORK.*/

data work.Mclass;
  set sashelp.class;
  where sex='M';
run;

/*Alternatively, you can use a one-level name to reference 
 a temporary SAS Data Set.*/

data Fclass;
  set sashelp.class;
  where sex='F';
run;

* Create a permanent SAS data set in a SAS library;
libname new 'C:\SDS';
data new.Fclass;
  set sashelp.class;
  where sex='F';
run;


/*You can get path to directory using %SYSFUNC and PATHNAME 
on a libref.*/
%put %sysfunc(pathname(new));


/*SAS automatically creates a SAS library with the libref SASUSER.
You don't not need to include LIBNAME statement*/

data sasuser.Mclass;
  set sashelp.class;
  where sex='M';
run;

/*You can use a one-level name in 
 the DATA statement to reference a permanent SAS Data Set, 
 if your libref is named as USER in the LIBNAME statement.*/

libname user 'C:\SASCourse\Week1';
data Fclass_x;
  set sashelp.class;
  where sex='F';
run;



