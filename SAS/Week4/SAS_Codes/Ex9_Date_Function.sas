*Ex9_Date_Function.sas (Part 1);
options nocenter nodate nonumber nonotes nosource;
Data _Null_;
 date_time = '13Jan2016:23:15:30'dt;
date_part=datepart(date_time);
time_part=timepart(date_time);
month = month(date_part);
weekday=weekday(date_part);
day=day(date_part);
year=year(date_part);
new_date=mdy(1,27,2016);
Today = date();
Today_x = today();
Quiz1_date ='23Sep2016'd;
System_date="&sysdate"d;
System_date_x="&sysdate9"d;
format date_time datetime20. 
       date_part new_date Today  Today_x 
       Quiz1_date System_date
       System_date_x date9. 
       time_part time.;
putlog (_ALL_)  (=/ +2);
run;

*Ex9_Date_Function.sas (Part 2);
data work.have;
input @1 date_time1 anydtdtm21.
      @1 date1 anydtdte15.
	  @11 time1 anydttme13.;

      * Create new variables;
      date_time2 = date_time1; 
      time2=timepart(date_time1);  

format date_time1 datetime18.
       date1 date9.
	   time1  time5. 
       time2 timeampm11.
       date_time2 dateampm22.2;
datalines4;
01Jul2016:15:30:55
;;;;
proc print data=work.Have noobs;
var date1 date_time1 date_time2 time1 time2;
run;
