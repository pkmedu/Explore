
proc sql;
select type, mean(invoice) as Mean_invoice_by_Type
             format=dollar8.
from sashelp.cars
group by type
union all
select 'Total',
     mean(invoice) as Mean_invoice_by_Type
             format=dollar8.
from sashelp.cars;
quit;

proc means data=sashelp.cars noprint;
  class type;
  var invoice;
  output out=mean_data1(drop=_type_) mean=;
run;
proc print data=mean_data1; run;

proc summary data=sashelp.cars nway;
  class type;
  var invoice;
  output out=mean_data(drop=_type_) mean=;
run;
proc print data=mean_data; run;

PROC TABULATE data=sashelp.cars ;
  CLASS type;
  VAR  invoice;
  KEYLABEL N='Total'  mean = 'Mean Invoice Price';
  TABLE (type all), (N*f=comma5. invoice*mean*f=dollar9.);
run;

/*https://communities.sas.com/t5/SAS-Programming/calculate-average-in-data-step/td-p/592430*/
*Inspired: hashman (Paul D.);
proc sort data=sashelp.cars out=cars (keep=type invoice); 
  by type; run;
data want (drop=invoice) ;                              
  do until (last.type) ;              
    set cars;                              
    by type;                         
    num_invoice = sum (num_invoice, N(invoice)) ;
    sum_invoice = sum (sum_invoice, invoice) ;   
  end ;                                  
  mean = divide (sum_invoice, num_invoice) ;   
run ;   
proc print data=want; 
format num_invoice comma5. sum_invoice mean dollar12.;
run; 
*Inspired by novinosrin;
proc sort data=sashelp.cars out=cars (keep=type invoice); 
  by type; run;
data want3  (drop=invoice);
 do num_invoice=1 by 1 until(last.type);
  set cars;
  by type;
  sum_invoice=sum(sum_invoice,invoice);
 end;
 mean=sum_invoice/num_invoice;
run;

proc print data=want3; 
var type num_invoice sum_invoice mean;
format num_invoice comma5. sum_invoice mean dollar12.;
run;

/* Code idea from SASKiwi */
proc sort data=sashelp.cars out=cars (keep=type invoice); 
  by type; run;
data want2 (drop=invoice);
set cars (keep=type invoice);
by type;
if first.type then do;
  sum_invoice=0;
  num_invoice = 0;
end;
sum_invoice+invoice;
num_invoice+1;
if last.type then mean=sum_invoice/num_invoice;
if last.type;
run;
proc print data=want2; 
var type num_invoice sum_invoice mean;
format num_invoice comma5. sum_invoice mean dollar12.;
run; 


proc report data=sashelp.cars ;
columns type n invoice,(mean);
 define type / group; 
 define n / 'Count';
 define invoice / analysis f=dollar12.; 
 *define n  / analysis f=comma5.; 
 rbreak after/summarize;
 run;
 
 * Select car type in the top 1% based on the invoice price;

 * Calculate the 99th percentile;
proc summary data=sashelp.cars;
var invoice;
output out=pct p99=p99;
run;
* Filter invoice prices that are >= p99;
proc sql ;
select a.type, invoice
    from sashelp.cars as a
    where a.invoice >= (select p99 from pct);
quit;
