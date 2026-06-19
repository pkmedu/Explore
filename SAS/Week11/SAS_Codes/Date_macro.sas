*Date_macro.sas;

data _null_;
 today_date = put(date(), worddate18.);
 put today_date=;
run;

%let today_date = %left(%qsysfunc(date(),worddate18.));
%put &=today_date;

%macro date_macro;
   %put %left(%qsysfunc(date(),worddate18.));
%mend;

%date_macro;


title "SASHELP.CLASS - %left(%qsysfunc(date(),worddate18.))" ;
proc print data=sashelp.class (obs=5);
run;
/*

Why are double quotes used in the title statement?

Because:

The TITLE statement expects a text string, and we want the resolved macro value embedded inside it.
Key rule illustrate.

Final takeaway
Double quotes here are not about macro variables—they’re required by the TITLE statement.
Macro functions (%sysfunc, %qsysfunc, %left) are resolved inside the quotes.
%qsysfunc is used to safely handle special characters like commas.

Single quotes prevent all macro resolution, including macro variable references and macro functions.

This is the opposite of %LET usage:

%LET → quotes are optional and literal
"..." in SAS statements → required for character strings, and macro expressions resolve inside them
*/