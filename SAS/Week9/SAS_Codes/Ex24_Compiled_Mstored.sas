*Ex24_Compiled_Mstored.sas;
options nodate nonumber symbolgen;
%LET Path= C:\SASCourse\Week9;
Libname New "&Path";
options mstored sasmstore=New;
%macro format(value,format)/store source
        des='Macro that formats macro variables';
	%if %datatyp(&value)=CHAR 
         %then %sysfunc(putc(&value,&format));
	%else %left(%qsysfunc(putn(&value,&format)));
%mend format;
%sysmstoreclear;








 
