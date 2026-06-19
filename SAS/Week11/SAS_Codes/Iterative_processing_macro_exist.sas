
dm "log; clear;";
/* Iterative Processing */

%macro stats(datasets);
   %let i=1;
   %let dsn=%upcase(%scan(&datasets,1));
   %do %while(&dsn ne );
	title "SASHELP.&dsn";
      proc means data=sashelp.&dsn n min mean max;  
	run;
	%let i=%eval(&i+1);
	%let dsn=%upcase(%scan(&datasets,&i));
   %end;
   title;
%mend stats;
%stats(class classfit heart)


/* Create a macro version of the EXIST function */
/* Create once and use for ever */

dm "log; clear;";
%macro exist (dsn);
 %sysfunc(exist(&dsn))
%mend dsn;

%macro stats(datasets);
   %let i=1;
   %do %until(&dsn= );
      %let dsn=%upcase(%scan(&datasets,&i));
      %if &dsn= %then %put NOTE: Processing complete.;
      %else %if %exist(sashelp.&dsn) %then %do;
	  title "SASHELP.&dsn";
         proc means data=SASHELP.&dsn n min mean max;
         run;
      %end;
      %else %put ERROR: No &dsn data set in ORION library.;
      %let i=%eval(&i+1);
   %end;
%mend stats;
%stats(class classfit heart games)

/* The Varlist macro returns a list of variables. */

/* VARNAME Function */
/* The Varlist macro returns a list of variables. */
%macro varlist(dsn,type);
   %local dsid i;
   %let dsid=%sysfunc(open(&dsn));
   %if &dsid=0 %then %do;
     %put ERROR: Cannot open data set: %upcase(&dsn).;
     %return;
   %end;
   %if &type=N %then %do i=1 %to %sysfunc(attrn(&dsid,nvars));
     %if %sysfunc(vartype(&dsid,&i))=N %then %sysfunc(varname(&dsid,&i));
   %end;
   %else %if &type=C %then %do i=1 %to %sysfunc(attrn(&dsid,nvars));
     %if %sysfunc(vartype(&dsid,&i))=C %then %sysfunc(varname(&dsid,&i));
   %end;
   %else %do i=1 %to %sysfunc(attrn(&dsid,nvars)); 
     %sysfunc(varname(&dsid,&i)) 
   %end;
   %let dsid=%sysfunc(close(&dsid));
%mend varlist;

%put %varlist(SASHELP.class,N);
%put %varlist(SASHELP.classfit,C);
%put %varlist(SASHELP.CLASS);
