
dm "log; clear; output; clear; odsresults; clear;";

/* Create a macro variable containing a horizontal list of countries 
   under the region AFR */

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

/* Create six macro variables, each containing a horizontal list of countries 
   under each of the six regions */

* Macro approach 1 (macro with a positional parameter);
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

* Macro approach 2 (macro call with a %do loop);
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

* Macro approach 3 (macro call with  CALL EXECUTE);

%macro new_process_region(rname);
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
%mend new_process_region;

data _null_;
    length region $4;
    array regions[6] $4 ('AFR' 'AMR' 'EMR' 'SEAR' 'WPR' 'EUR');
    
    do i = 1 to dim(regions);
        region = regions[i];
        call execute('%nrstr(%new_process_region(' || region || '));');
    end;
run;


/* Loop through each region of the year_list dataset and call the macro */
data _null_;
	set year_list;
	call execute('%nrstr(%get_puf('||strip(puf_num)||'));');
run;

/* Additional Examples 
https://communities.sas.com
/t5/SAS-Programming/How-to-use-macro-to-create-a-series-of-logistic-regressions/m-p/410934#M100426

/*
You can easily make a macro for what you are talking about, but if your 
variables are not numbered sequentially you will have to generate 
a macro call for each one, like this data example;
*/
input dependent_var _123 _234 _341;
datalines;
0 23 12 0
1 45 48 9
1 0 23 6
0 89 12 34
;
run;
/*
However, if your variables were numbered sequentially for example, 
from 1 to 100, you could generate the regression code like this.
*/
%macro regression(var);
proc logistic data=example;
 model dependent_var = _&var;
run;
%mend;

%regression(123);
%regression(234);
%regression(341);

