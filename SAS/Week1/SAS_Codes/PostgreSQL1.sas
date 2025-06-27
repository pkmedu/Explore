
/* Step 1: Set options and libname  statements */
OPTIONS SASTRACE=',,,d' SASTRACELOC=SASLOG NOSTSUFFIX;
 /* to see what part of the query was executed in Postgres*/
libname pgdb postgres 
   server='localhost'        /* or '127.0.0.1' */
   port=5432                 /* default PostgreSQL port */
   user='postgres' 
   password='Phariom108$' 
   database='classdb' 
   schema='public';

   /* Step 2: Summarize visits by type */
proc sql;
   create table work.weight_summary as
   select sex length=1 format=$1. informat=$1., 
     /* format and informat $1024 in the input table (students) do not know why? */
      avg(weight) as mean_weight
   from pgdb.students
   where age >=14
   group by sex;
quit;


/* Step 3: Print summary */
proc print data=work.weight_summary label noobs;
   label sex = 'Sex'
         mean_weight = 'Average Weight';
   format mean_weight 6.1;
run;

