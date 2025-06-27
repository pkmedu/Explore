The following code converts the SAS data set to a Stata data set.

```sas
proc export data=sashelSp.class replace 
         outfile= "C:\Data\class.dta";
run;
```
NOTE: The export data set has 19 observations and 5 variables.
NOTE: "C:\Data\class.dta" file was successfully created.
NOTE: PROCEDURE EXPORT used (Total process time):
      real time           0.10 seconds
      cpu time            0.06 seconds


