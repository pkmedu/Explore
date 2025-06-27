*Ex8_surveyfreq.sas;
options nonumber nodate ls=132 ps=58;
%LET Path=C:\Users\Pradip Muhuri\SASClassGWU\TopicsByWeek\Week9;
LIBNAME xnew "&Path";
options fmtsearch=(xnew.formats);
proc surveyfreq data=xnew.xh163;
      tables  age_group *AMTOTV_cat13 / cv deff nowt ;
      strata  varstr;
      cluster varpsu;
      weight  perwt13f;
     title1 "MEPS 2013 Public Use Files"; 
run;


