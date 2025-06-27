*Ex23_read_data_add_format.sas ;
OPTIONS nocenter nodate nonumber;
%LET Path=C:\SASCourse\Week3;
FILENAME raw "&Path\pop2013_no_headers.txt";
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
proc sort data=SDS.pop; by descending pop; run;
title1 'Ex23_read_data_add_format.sas';
title2 'U.S. Population, 2013 (Seven largest states)';
proc print data=SDS.pop (obs=8) split='*' noobs;
var name pop pop18p;
run;
title1; title2;
  
