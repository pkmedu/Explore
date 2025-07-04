
dm "log; clear; output; clear; odsresults; clear;"; 
proc datasets library=work kill;
run;
quit;  
OPTIONS nocenter symbolgen mlogic mprint ps=58 ls=256 nodate nonumber
   OPTIONS FORMCHAR='|----|+|---+=|-/\<>*';
%let path=S:\CFACT\Shared\PMuhuri\HerbRequest_USC;
libname new "&Path";
libname library "&Path";
options fmtsearch=(library.formats);
ods graphics off;
ods exclude all;
%let key_vars = Location x_typepe42 ;
%macro run_proc (first=, last=, option=);
	%do yr=&first %to &last;
      proc surveymeans data=new.FY_&yr nobs sumwgt mean &option;
  			stratum varstr;
  			cluster varpsu;
  			weight perwtf;
  			var &key_vars;
			class &key_vars;
	   DOMAIN   ACCELI42('1');
	  format Location Location_f. x_typepe42  x_typepe_f.;
	  ods output domain=all_%sysfunc(putn(&yr,z2.))&option; 
      run;
	%end ;
%mend run_proc;
%run_proc(first=18, last=21, option=)
%run_proc(first=18, last=21, option=missing)


data d_18_21 (drop=domainlabel varlabel ACCELI42);
 length year $5;
 set all_: indsname=source;
 Year = cats(20,substr(source,10));
 filter_var =  substr(year, 5);
where n ne 0; 
run;

proc format;
value $varname_f location = 'Provider Location'
      x_typepe42 = 'Provider Characteristics';
run;

dm "log; clear; output; clear; odsresults; clear;"; 
ods exclude none;
ods listing close;
options nocenter ls=132;
/* Format the current date */
%let current_date = %sysfunc(today());
%let formatted_date = %sysfunc(putn(&current_date., mmddyyd10.));

%macro printit (sn=, num=, w=, fv=);
ods excel options(sheet_name=&sn embedded_titles="yes");
title "%sysfunc(date(),worddate.)";
title2 "Table &num: Percentage distribution of usual source of care by provider location vs. provider characteristics";
title3 "(&w missing values as categories), MEPS 2018 to 2021";

proc report data=d_18_21 (where=(filter_var = &fv)); 
  column year VarName varname2  VarLevel N SumWgt Mean StdErr;
  define year / order width=6;
  define varname /order width=10 noprint;
  define varname2 /computed 'Variable Name' format=$varname_f. width=25 ;
  define VarLevel/display  width=50;
  define N / analysis format = Comma12. width=12;
  break after varname /summarize 
                       style=[font_weight=bold]
					   suppress;
  compute varname2 /character length=25;
    varname2 = varname;
  endcomp;
  compute after varname;
     varname2 = 'Total ' || varname;
     line ' ';
  endcomp;
  define Sumwgt / display  format = Comma12. "Pop size" width=12;
  define mean / analysis sum format = percent7.1 "Percent" width=8;
  break after varname /summarize 
                       style=[font_weight=bold]
					   suppress;
  define stderr / display format = percent7.3 "SE of Percent" width=8;
  
run;
%mend printit;
ods excel file = "&path\USCTablesForHW_&formatted_date..xlsx";
%printit(sn= "Without_Missing_Values", num=1, w=WITHOUT, fv= " ")
%printit(sn= "With_Missing_Values", num=2, w=WITH, fv= "M")
ods _all_ close;

