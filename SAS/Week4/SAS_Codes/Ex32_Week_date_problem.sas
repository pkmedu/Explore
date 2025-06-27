*Ex32_Week_date_problem.sas;
/*Week date input problem
Author: KurtBremser
According to the author, you need to remove the redundant weekday 
first with substr(), then  anydtdte will recognize the date
SAS Support Community Web Site- 04-23-2018
*/
options nocenter nodate nonumber;
data test;
input datestr $30.;
i = index(datestr,' ');
date = input(substr(datestr,i),anydtdte30.);
*drop i;
format date weekdate30.;
cards;
Saturday March 31, 2018
;
run;
proc print data=test noobs; run;
