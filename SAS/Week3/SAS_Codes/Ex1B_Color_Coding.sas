*Ex1B_Color_coding.sas;
PROC FORMAT;
value $sexfmt 'M' = 'Male'
              'F' = 'Female';
run;
Title "Table from SASHELP Data Set";
PROC FREQ DATA=SASHELP.CLASS;
Tables Sex;
format Sex $sexfmt.;
run;

Title "One-way Table;
PROC FREQ DATA=SASHELP.CLASS;
Tables Sex;
format Sex $sexfmt.;
run;

