
#### Find the total number of observations from a SAS data set (SAS macro statements)

```sas
%let dsn=sashelp.class;
%let dsid    = %sysfunc(open(&dsn,i)) ;
%let nobs    = %sysfunc(attrn(&dsid,nlobs));
%let dsclose = %sysfunc(close(&dsid));
%put &=nobs;
```
