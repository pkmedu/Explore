*Ex10_Freq_ods_output_crosstabs.sas (Part 1);
options nocenter nodate nonumber;
*The following code was obtained from SAS_L
ods output crosstabfreqs=summary;
proc freq data=sashelp.class  noprint;
table sex*(_all_) /out=summary;
run;
proc print data=summary; run;

*Ex10_Freq_ods_output_crosstabs.sas (Part 2);
data long;
	length variable $32. variable_value $50.;
	set summary;
	Variable=scan(table, 2, '*');
	Variable_Value=strip(trim(vvaluex(variable)));
	presentation=catt(frequency, " (", trim(put(percent/100, percent7.1)), ")");
	keep sex variable  variable_value frequency percent presentation;
	label variable='Variable' variable_value='Variable Value';
run;
proc print data=long; run;

