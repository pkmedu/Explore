
* Contributed by Joe Matise at SAS-L;
* The "CDT" (timezone) portion is ignored;
data want;
  date_char = 'Wed Jul 01 13:21:05 CDT 2020';
  d_day = scan(date_char,3);
  d_mon = scan(date_char,2);
  d_year = scan(date_char,-1);  *-1 means "last one";
  d_time = scan(date_char,4);
  dt_var = input(cats(d_day,d_mon,d_year,':',d_time),datetime.);
  format dt_var DATETIME20.;
run;

* Contributed by Andrew Smith to SAS-L - October 23, 2020;
data;
  input dt ANYDTDTM28. ;
  format dt E8601DZ. ;
  datalines;
Wed Jul 01 13:21:05 CDT 2020
Wed Jul 01 13:21:05 EST 2020
Wed Jul 01 13:21:05 UTC 2020
;

proc print;
run;
