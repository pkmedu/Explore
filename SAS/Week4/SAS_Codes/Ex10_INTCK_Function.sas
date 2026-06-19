*Ex10_INTCK_Function.sas;
options nocenter nodate nonumber;
data count_interval;
  years=intck('year','01jan2009'd,'01jan2010'd);
  SEMIYEAR=intck('SEMIYEAR','01jan2009'd,'01jan2010'd);
  quarters=intck('qtr','01jan2009'd,'01jan2010'd);
  months=intck('month','01jan2009'd,'01jan2010'd);
  weeks=intck('week','01jan2009'd,'01jan2010'd);
  days=intck('day','01jan2009'd,'01jan2010'd);
run;
proc print data=count_interval noobs; 
run;

