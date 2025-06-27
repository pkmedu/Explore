
dm "log; clear; output; clear; odsresults; clear;";
proc datasets lib=work kill nolist;
OPTIONS center nodate nonumber symbolgen;
libname new 'C:\Data\MEPS';
  
%macro runit (first=, last=);
%do yr=&first %to &last;
 title "MEPS, 20%sysfunc(putn(&yr,z2.))";
 ods graphics off;
 ods exclude all;   
          proc surveymeans data=new.FY_%sysfunc(putn(&yr,z2.)) nobs sumwgt mean stderr sum ;
          stratum varstr;
          cluster varpsu;
          weight perwt%sysfunc(putn(&yr,z2.))f;
          var  totexp%sysfunc(putn(&yr,z2.));
          domain nmiss_exp('1') ;
          ods output domain=_overall_%sysfunc(putn(&yr,z2.));
          run;
  %end ;
%mend runit;
%runit(first=00, last=18)
*******;
data new.overall_HD (drop= domainlabel varname);   
  set  _overall: indsname=source;
  Year = cats('20',scan(source, -1, '_'));
run;

proc format;   
   picture bigmoney (fuzz=0)
      1E06-<1000000000='0000.99 M' (prefix='$' mult=.0001)
      1E09-<1000000000000='0000.99 B' (prefix='$' mult=1E-07)
      1E12-<1000000000000000='0000.99 T' (prefix='$' mult=1E-010);
run;
ods exclude none;
ods listing;
title 'Health care expenditures for';
title2 'the civillian noninstitutionalized population,';
title3 'United States, MEPS 2000-2018';
proc print data=new.overall_HD noobs label; 
var year N mean stderr sum stddev ;
label N= 'Number of sampled persons'
      mean = 'Mean HC expenditure per person'
      stderr = 'SE'
      sum= 'Total HC expenditures'
	  stddev 'STD';
format N comma9. mean stderr dollar7. sum stddev bigmoney.;
run;
ods _all_ close;

