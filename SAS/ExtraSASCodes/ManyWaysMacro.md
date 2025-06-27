```SAS
dm "log; clear; output; clear; odsresults; clear;";
proc sql noprint;
    select distinct trim(name)
        INTO :AFR_clist separated by ','
        FROM SASHELP.demographics
        where region="AFR";
quit;

%put NOTE: Nonmacro processing region AFR;
%put NOTE: Processing region AFR;
%put Number of countries for AFR_clist = &sqlobs;
%put &=AFR_clist;
%put NOTE: End of region AFR processing;
%put ;

* Macro approach 1;
%macro runit(rname);
proc sql noprint;
    select distinct trim(name)
        INTO :&rname._clist separated by ','
        FROM SASHELP.demographics
        where region="&rname";
quit;
%put NOTE: Processing region &rname using a macro with positional parameter;
%put &rname._clist = %superq(&rname._clist);
%put Number of countries for &rname._clist = &sqlobs;
%put NOTE: End of region &rname processing;
%mend runit;
%runit(AFR)
%runit(AMR)
%runit(EMR)
%runit(SEAR)
%runit(WPR)
%runit(EUR)

* Macro approach 2;
%macro process_region(rname);
    proc sql noprint;
        select distinct trim(name)
            into :&rname._clist separated by ","
            from SASHELP.demographics
            where region="&rname";
    quit;
    %put NOTE: Processing region &rname using a macro Loop;
    %put NOTE: SQL Observation count = &sqlobs;
    %put &rname._clist = %superq(&rname._clist);
    %put NOTE: End of region &rname processing;
%mend process_region;
%macro run_all;
    %let regions = AFR AMR EMR SEAR WPR EUR;
    %do i = 1 %to %sysfunc(countw(&regions));
        %let region = %scan(&regions, &i);
        %process_region(&region)
    %end;
%mend run_all;
%run_all

* Macro approach 3;
%macro process_region(rname);
    proc sql noprint;
        select distinct trim(name)
            into :&rname._clist separated by ","
            from SASHELP.demographics
            where region="&rname";
    quit;
    %put NOTE: Processing region &rname using macro with CALL EXECUTE;
	%put NOTE: SQL Observation count = &sqlobs;
    %put &rname._clist = %superq(&rname._clist);
    %put NOTE: End of region &rname processing;
%mend process_region;
data _null_;
    length region $4;
    array regions[6] $4 ('AFR' 'AMR' 'EMR' 'SEAR' 'WPR' 'EUR');
    do i = 1 to dim(regions);
        region = regions[i];
        call execute('%nrstr(%process_region(' || region || '));');
    end;
run;
```
