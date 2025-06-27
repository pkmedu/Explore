[How To Add Total to Table](https://communities.sas.com/t5/SAS-Programming/How-to-add-quot-Total-quot-to-the-table/td-p/499859)

```sas
/*Create the total row*/
proc means noprint data=sashelp.cars ;
  output out=summary(keep=mpg_city) sum=mpg_city;
run;

/*Create the necessary table using proc sql*/
proc sql;
	create table test as
		select make, count(make) as count
		from sashelp.cars
		group by make
		order by make;
quit;

/*Combine the tables*/
data want ;
  set test summary(in=in2); /*concatenate the tables. In= option creates a temp variable called in2*/
  if in2=1 then Make='TOTAL'; /*In2 will =1 when SAS brings in the row from summary. This will allow us to change the column name we want to "Total"*/
run;

```
##### Alternative code
```SAS
proc sql;
    select make, count(make) as count
    from sashelp.cars
    group by make
    UNION
    select 'Total' as make, 
           count(*) as count format=comma14.
    from sashelp.cars
    order by case when make = 'Total' then 1 else 0 end,
             make;
quit;
```
```SAS
proc sql;
    select make, 
           count(make) as count,
           (count(make) / (select count(*) 
            from sashelp.cars)) * 100 as percentage format=5.2
    from sashelp.cars
    group by make
    
    UNION
    
    select 'Total' as make, 
           count(*) as count,
           100.00 as percentage format=5.2
    from sashelp.cars
    
    order by case when make = 'Total' then 1 else 0 end,
             make;
quit;
```
```SAS
proc report data = sashelp.cars nowd;
 column make n pctn;
 define make /group id order = internal;
 define n / format =8. "N";
 define pctn / "Percentage" format =percent7.1;
 rbreak after /summarize style=[font_style=italic];
 compute after ;
	  make='Total';
endcomp;
run; 
```
