### How to get SAS variable attributes dynamically (Various) 

 Notes: SASHELP.vcolumn is a data view, not a data set, maintained by SAS.
 Dictionary.Columns is sashelp.vcolumn.
 
 ```sas
	 proc sql;
         select name, type, length, label
         from sashelp.vcolumn
         where libname="SASHELP" and  memname = "HEART";
      quit;
	
proc print data=sashelp.vcolumn label;
  var name type format length label;
  where libname='SASHELP' and memname='HEART';
run;
```
```sas
  proc sql;
         select name, type, length, label
         from dictionary.columns
         where libname="SASHELP" and
             memname = "HEART";
  quit;
```
```sas
     options label;
      proc sql;
       describe table sashelp.heart
      ;quit;
```
```sas
   proc contents data=sashelp.heart;
   run;
```
```sas
      options label;
	 proc contents data=sashelp.heart position;
	 ods select variables;
     run;
```
```sas
   proc contents data=sashelp.heart;
	  ods select variables;
   run;
```
```sas
   proc contents data=sashelp.heart varnum;
   run;
```
```sas   
proc datasets lib=sashelp;
     contents data=heart position;
     quit;
```
```sas
LIBNAME pufmeps  'C:\Data' access=readonly;
proc print data=sashelp.vcolumn label;
 var memname name type length label;
 where libname='PUFMEPS' and memname='H197G'
 and name in ('DUPERSID', 'MAMMOG' 'XRAYS', 'MRI');
run;
```
Use the above programs at your own risk (no warranties).
