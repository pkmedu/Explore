
* Topic: Listing ODS Table names by turning on tracing 
* Written by Pradip Muhuri
* Use the program at your own risk (no warranties).
  
```sas
DM "Log; clear; output; clear; odsresults; clear";
proc datasets lib=work nolist kill; quit; 
OPTIONS NOCENTER LS=155 PS=79 NODATE NONUMBER
	FORMCHAR="|----|+|---+=|-/\<>*" PAGENO=1;
```

```sas
proc format;
value sex_fmt 1 = 'Male'
              2 = 'Female';
value povcat_fmt 
    1   = 'Poor'
    2,3 = 'Near Poor/Low Income'
      4   = 'Middle Income'
      5   = 'High Income';
run;
```

* ADJUST=BON also automatically invokes DIFFMEANS;
```sas
ods trace on;
ods html close;
PROC SURVEYMEANS DATA= pufmeps.h209 
                   mean q1 q3 median 
                   percentile= (10, 90, 95);
    VAR  totexp18;
    STRATUM VARSTR ;
    CLUSTER VARPSU ;
    WEIGHT  PERWT18F ;
    DOMAIN povcat18/Adjust=Bon cldiff; 
    DOMAIN sex*povcat18('High Income')/diffmeans cov ; 
    format sex sex_fmt. povcat18 povcat_fmt.;
RUN;
ods trace off;
```

```sas
ods trace on;
ods graphics off;
ods exclude all;
PROC SURVEYMEANS DATA= pufmeps.h209 
                   mean q1 q3 median 
                   percentile= (10, 90, 95);
    VAR  totexp18;
    STRATUM VARSTR ;
    CLUSTER VARPSU ;
    WEIGHT  PERWT18F ;
    DOMAIN povcat18/diffmeans Adjust=Bon cldiff; 
    DOMAIN sex*povcat18('High Income')/diffmeans cov ; 
    ods output Summary=S_Summary
	       Statistics=S_Statistics
	       Quantiles=S_Quantiles
	       Domain=S_Domain
	       DomainDiffs=S_Domain_Diffs
	       DomainQuantiles=S_DomainQuantiles
	       DomainDiffs=S_DomainDiffs
	       DomainMeanCov=S_DomainMeanCov;
	format sex sex_fmt. povcat18 povcat_fmt.;
run;
ods trace off;
```
