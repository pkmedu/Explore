[How to roll up two rows into one by Ksharp](https://communities.sas.com/t5/SAS-Enterprise-Guide/Roll-up-two-rows-into-one/td-p/604612)

##### Roll up multiple records at the ID level
```sas
data sample;
input repID IndID name $;
cards;
5424 19080134 Tom
5424 19080135 Jon
5424 19080136 Bob
5425 19081134 Ken
5425 19081135 Matt
5425 19081136 Rick
;
run;

proc sql noprint;
 select max(n) into : n
  from (select count(*) as n from sample group by repID);
quit;
proc summary data=sample;
by repID;
output out=want idgroup(out[&n] (IndID name)=);
run;

```
[How can I combine multiple rows into a single row by Tom and PGStats](https://communities.sas.com/t5/SAS-Programming/How-can-I-combine-multiple-rows-to-a-single-row/m-p/16038#M2220)
```sas
data have;
input ID Year Value1 Value2 Value3;
datalines;
1  1999      .      270 .
1  1999      . .                 350
1  1999   . . .
1  2000    20 . .
1  2000    .         300 .
1  2000    .          .           320
1  2001     .        122 .
1  2001     .         . .
1  2001     .         .           500
;

data want;
update have(obs=0) have;
by id year;
run;

proc print; 
run;
```
[How can I combine multiple rows into a single row By Linlin](https://communities.sas.com/t5/SAS-Programming/How-can-I-combine-multiple-rows-to-a-single-row/m-p/16038#M2220)
```sas
data have;
input ID Year Value1 Value2 Value3;
datalines;
1  1999      .      270 .
1  1999      . .                 350
1  1999   . . .
1  2000    20 . .
1  2000    .         300 .
1  2000    .          .           320
1  2001     .        122 .
1  2001     .         . .
1  2001     .         .           500
;

proc sql;
  create table want as
    select distinct id,
           year,
           sum(value1) as value1,
           sum(value2) as value2,sum(value3) as value3
            from have
             group by id,year;
quit;

proc print data=want;
run;

```
[How can I combine multiple rows into a single row By  ballardw](https://communities.sas.com/t5/SAS-Programming/How-can-I-combine-multiple-rows-to-a-single-row/m-p/16038#M2220)
```sas
data have;
input ID Year Value1 Value2 Value3;
datalines;
1  1999      .      270 .
1  1999      . .                 350
1  1999   . . .
1  2000    20 . .
1  2000    .         300 .
1  2000    .          .           320
1  2001     .        122 .
1  2001     .         . .
1  2001     .         .           500
;

proc summary data=have nway;
  class id year;
  var value1 value2 value3;
  output out=want (drop=_type_ _freq_) max=;
run;

proc print data=want;
run;
```
