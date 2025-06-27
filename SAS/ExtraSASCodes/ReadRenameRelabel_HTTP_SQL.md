
[Acknowledgements](https://gist.github.com/cjdinger/2950c1a62acd7f50c33473c311b0d9fe)

### The program does the following:

 * Read the CSV file from the web.    
 * Import to SAS with nonstandard var names.     
 * Rename/relabel to conform with standard SAS variable name rules.                      

Fetch the file from the web site.

```sas
filename probly temp;
proc http
 url="https://raw.githubusercontent.com/zonination/perceptions/master/probly.csv"
 method="GET"
 out=probly;
run;
```

Tell SAS to allow "nonstandard" names and import the CSV data file to a SAS data set. 

```sas
options validvarname=any;
proc import
  file=probly
  out=work.probly replace
  dbms=csv;
run;
```

* Generate new names to comply with SAS rules.                          

* Assume names contain spaces, and can fix with COMPRESS. 

* Other deviations (like names that start with a number)      
would need different adjustments    

* NVALID() function can check that a name is a valid V7 name.            

```sas
proc sql noprint;
  select cat("'",trim(name),"'n","=","'",trim(name),"'") 
     into :labelStmt separated by ' '  
   from sashelp.vcolumn
   where memname="PROBLY" and libname="WORK";

  select cat("'",trim(name),"'n","=",compress(name,,'kn')) 
     into :renameStmt separated by ' '  
      from sashelp.vcolumn
      where memname="PROBLY" and libname="WORK"
      AND not NVALID(trim(name),'V7');
quit;

```sas
proc datasets lib=work nolist ;
  modify probly / memtype=data;
  label &labelStmt.;
  rename &renameStmt.;
  contents data=probly nodetails;
quit;
```

```sas
options validvarname=v7;

proc print data=work.probly(obs=10) label ;
run;

```
