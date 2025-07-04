*Example_Surveymeans_ODS2.sas;
OPTIONS nocenter nodate nonumber ps=58 ls=132  ;
libname out "U:\A_DataRequest";
libname library "U:\A_DataRequest";
ods graphics off;
proc surveymeans data=out.MEPS_FYC_2014 nobs mean ;
  			stratum varstr;
  			cluster varpsu;
  			weight perwt14f ;
  			var TOTEXP14;
			domain age_grp sex age_grp*sex('Male');
  			ods output Statistics=out.ALL_FYC14 
                   domain=out.Stat_FY14;
run;

data new;
set out.ALL_FYC14
     out.Stat_FY14;
Label age_grp = 'Age Group'
      sex = 'Sex'
      mean= 'Weighted Annual Mean *Health Care Expenses ($)'
      StdErr= 'Standard Error';
run;
proc contents data=new; run;
proc format;
value n_age_fmt 
     .='All Ages'
	 1='0-17 yrs'
	 2='18-64 yrs'
     3='65+ yrs';
value n_sex_fmt
     .='Both Sexes'
	 1='Male'
	 2='Female';
run;
ods path (prepend) work.templat(update);
proc template;
     define style styles.test;
       parent=styles.journal;
      class HeadersAndFooters /
             font=(Arial,12pt);    
       class SystemTitle from TitlesAndFooters /
             font=(Arial,12pt);
      class SystemFooter/font=(Arial,12pt);
     end;
   run;
options nocenter nodate nonumber;
ods rtf file="U:\A_DataRequest\Surveymeans.rtf" style=styles.test bodytitle;   
title 'Table 1: Average Health Care Expenses by Age and Sex, MEPS-HC 2014' ;
proc print data=new noobs split='*'; 
var age_grp SEX N  Mean  StdErr;
format age_grp  n_age_fmt. 
       SEX n_sex_fmt.
       N Mean  StdErr comma7.;
run;
ods rtf close;

