*Ex11_Format_Put_Function.sas;
options nocenter nonumber nodate;
title1; title2;
PROC FORMAT; 
     value regionfmt
        1='Northeast' 2='Midwest' 
        3='South'  4='West';
run;
LIBNAME SDS "C:\SASCourse\Week3";
data Have;
  set sds.pop2013x;
  region_char=put(region, regionfmt.);
run;
proc contents data=Have 
     (keep=region region_char) varnum;
ods select position;
run;
proc print data=Have;
  var region region_char st_name;
  where st_name like 'A%';
run;
title1; title2;
