*Ex17_Filename_Libname.sas ;

OPTIONS nocenter nodate nonumber;
%LET Path=C:\SASCourse\Week2;
FILENAME raw "&Path\SAS_Codes\pop2013_no_headers.txt";
LIBNAME SDS "&Path";
PROC FORMAT; 
     value regionfmt
       1='Northeast' 2='Midwest'
       3='South' 4='West';
run;
DATA SDS.Pop;
 INFILE raw DLM=',';
 input sumlev region division fips name :$22.
         pop :comma12.
         pop18p :comma12.  p_pop18p; 
  LABEL region ='Region'     
        FIPS ='State FIPS'
        name ='State Name'  
        pop ='Population*(All Ages)'
        pop18p ='Population*(Aged 18+)'
        p_pop18p = 'Percent*Population*(Aged 18+)'; 
  FORMAT pop pop18p comma12. FIPS z2.;
run;
proc sort data=SDS.pop out=pop; by descending pop; run;
title '8 most populaous states - United States of America, 2013';
proc print data=pop (obs=8) noobs split='*';
var name pop pop18p;
run;
title "United States Total Population, 2013";
LIBNAME SDS "C:\SASCourse\Week2";
proc sql;
 select sum(pop) format=comma12. as TotalPopulation
  from sds.pop
   quit;
title ' '; 
