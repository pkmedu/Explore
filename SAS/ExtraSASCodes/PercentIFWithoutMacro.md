```sas
%if %sysfunc(exist(sashelp.class)) %then %do;
   proc means data=sashelp.class;
   run;
%end;
%else %do;
   %PUT WARNING: Missing SASHELP.CLASS - report process skipped.;
%end;
```
