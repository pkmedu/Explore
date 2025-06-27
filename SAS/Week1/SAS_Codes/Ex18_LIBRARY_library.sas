*Ex18_LIBRARY_library.sas;
OPTIONS nodate nonumber nocenter;
%LET path=C:\SASCourse\Week3;
LIBNAME sds "&path";
LIBNAME library "&path";
title1 'Ex18_LIBRARY_library.sas';
PROC FREQ data=sds.pop2013x; 
 TABLES REGION;
RUN;
title1;

