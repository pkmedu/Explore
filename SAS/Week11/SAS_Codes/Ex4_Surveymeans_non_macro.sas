
OPTIONS nocenter nodate nonumber ;
libname new 'C:\Data\MEPS';
  
 title "MEPS, 2015";
 ods graphics off;
 ods exclude all;                        
 ods exclude statistics;
          proc surveymeans data=new.FY_15 nobs sumwgt mean stderr sum ;
          stratum varstr;
          cluster varpsu;
          weight perwt15f;
          var  totexp15;
          domain nmiss_exp('1') ;
          ods output domain=_overall_15;
          run;
 *******;
data overall_HD (drop= domainlabel varname);   
  set  _overall_15 indsname=source;
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
title2 'civillian noninstitutionalized population,';
title3 'United States, MEPS 2015';
proc print data=overall_HD noobs label; 
var year N mean sum ;
label N= 'Number of sample persons'
      mean = 'Mean expenditure per person ($)'

sum= 'Total expenditures ($)';
format n comma9. mean dollar7. sum bigmoney.;
run;
ods _all_ close;
