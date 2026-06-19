*** Ex3_call_symputx_date.sas;
*** Adapted from KurtBremser (SAS Communities)
   - 5/24/2017;
%let start=01/01/1999;
%let end=01/01/2000;

data _null_;
start = input("&start",mmddyy10.);
end = input("&end",mmddyy10.);
interval = end - start;
call symput('start',put(start,best.));
call symput('interval',put(interval,best.));
run;
%put &=start;
%put &=interval;

data want (drop=_:);
do _i = 1 to 10;
  newdate = &start + rand("Uniform") * &interval;
  format newdate ddmmyy10.;
output;
end;
run;
proc print data=want; run;
