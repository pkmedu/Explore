
libname new 'C:\Data2';
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
libname new 'C:\Data';
data pgdb.pdf_table;
    set new.EMB_data;
run;
  



