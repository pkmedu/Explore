*Ex6_sql_moreCode.sas (Part 1);
*** Acknowlegements: Some of the code idea  (INSERT, VALUE, SET,  
      and UPDATE clauses) is obtained from Martha Messineo (2017);

*** Use the INSERT clause to create a data table;
options nocenter nonumber nodate;
proc sql;
Create table have(ID varchar(6), stype varchar(13), Score float);
	Insert into have(id, stype, score)
		Values('S00003', 'Graduate', 19)
 		Values('S00002', 'Graduate', 14)
		Values('S00007', 'Graduate', 18)
 		Values('S00008', 'Graduate', 16)
		Values('M00004', 'Undergraduate', 13)
		Values('E00005', 'Undergraduate', 18)
		Values('M00022', 'Undergraduate', 17)
		Values('E00035', 'Undergraduate', 16)
		;
quit;

*Ex6_sql_moreCode.sas (Part 2);
options nocenter nodate nonumber;
** The following code is eqivalent to PROC PRINT step 
   with a VAR statement in it. The results of the SELECT 
   statement are written to the deafult output destination;

proc sql;
 select *
  From have;
quit;

*Ex6_sql_moreCode.sas (Part 3);
***  Use the INSERT with the VALUE clause to add rows to a data table.
The CREATE TABLE statement creates a daa table from the results of the
query;

proc sql;
create table class AS
select * 
  from sashelp.class;
Insert into class
  values('Amy', 'F', 14,64, 107);
 select *
    from class;
quit;

*Ex6_sql_moreCode.sas (Part 4);
*** Use the INSERT with the SET clause to add rows to a data table;
proc sql;
 insert into class
  set name='John', sex='M', age= 14, height=65, weight=111;
  select * 
    from class;
quit;

*Ex6_sql_moreCode.sas (Part 5);
*** Use the DELETE clause to delete rows from a data table;
proc sql;
 delete from class
  where age >=14;
  select *
    from class;
quit;

*Ex6_sql_moreCode.sas (Part 6);
*** Use the UPDATE clause to conditionally set a value of a particular
variable to another value;
proc sql;
  create table new_class AS
   select *
   from sashelp.class;
   update new_class
    set age=age+1
	where sex='F';
    select *
    from new_class;
quit;

*Ex6_sql_moreCode.sas (Part 7);
*** The following two code blocks (PROC PRINT and PROC SQL) 
    provide the same results;
title1 'Listing from PROC PRINT';
proc print data=sashelp.cars noobs;
  var make type;
 where make='BMW';
run;

*Ex6_sql_moreCode.sas (Part 8);
proc sql;
title1 'Query from from the SELECT clause with PROC SQL';
 select make, type
 From sashelp.cars
 where make='BMW';
quit;
title1;
*** The following two code blocks (DATA Step and PROC SQL) 
    provide the same results -  there are other DATA step solutions
    (not shown here);

*Ex6_sql_moreCode.sas (Part 9);
data _null_;
  set sashelp.cars end=eof;
  count+1;
  if eof then putlog count=;
run;

*Ex6_sql_moreCode.sas (Part 10);
proc sql;
 select count(*) as total_rows
 From sashelp.cars;
quit;


*** The following two code blocks (PROC SORT/PROC PRINT and PROC SQL) 
    provide the same results);

*Ex6_sql_moreCode.sas (Part 11);
proc sort data=sashelp.cars 
       (where=(make='BMW')) nodupkey
  out=distinct_make_type (keep=make type);
  by make type;
run;
proc print data=distinct_make_type noobs;
run;

*Ex6_sql_moreCode.sas (Part 12);
proc sql;
 select distinct make, type
 From sashelp.cars
 where make='BMW'
 order by type;
quit;

*** In the following code, the GROUP BY clause classifies the data based on the values 
of the MAKE column and calculate the mean INVOICE price for each 
unique value of the grouping column (i.e., MAKE). 
The ORDER BY clause order the results in descending order;
 
*Ex6_sql_moreCode.sas (Part 13);
proc sql;
 select make, 
  mean(invoice) as mean_invoice_price format=comma8.
   From sashelp.cars
   group by make
   order by mean_invoice_price desc;
quit;

** In the following code, the HAVING clause subsets groups based on the expression value.
Here we use a column alias to refer to a calculated value. and hence, use 
the CALCULATED keyword with the alias to inform PROC SQL that 
the value is calculated within the query (SAS Documentation);


*Ex6_sql_moreCode.sas (Part 14); 
proc sql ; 
select name
       ,pop
       ,pop/sum(pop) as percent_pop 
          format=percent7.2
	   from  sashelp.demographics
	   having calculated percent_pop >0.02
	   order by percent_pop desc;
quit;



