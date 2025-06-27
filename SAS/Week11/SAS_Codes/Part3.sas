
options nocenter nodate nonumber;
title1 'Listing from HAVE2 Data Set';
proc print data=work.have2 noobs; 
var id P_: wpt; 
Format wpt 5.0;
run;
