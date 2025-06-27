
```SAS
dm "log; clear; output; clear; odsresults; clear;";
options nocenter ls = 150; 
options formchar="|----|+|---+|-/\<>*";
%let path=S:\CFACT\Shared\PMuhuri\SAS_Treasure;
FILENAME MYLOG "&path\ManyWaysAggregate_log.TXT";
FILENAME MYPRINT "&path\ManyWaysAggregate_OUTPUT.TXT";
PROC PRINTTO LOG=MYLOG PRINT=MYPRINT NEW;
RUN;
proc format;
value $regionfmt
    'AFR' = 'Africa'
    'AMR' = 'Americas'
    'EUR' = 'Europe'
    'EMR'  ='Eastern Mediterranean'
    'SEAR' = 'South-East Asia'
    'WPR' = 'Western Pacific';

invalue order            
    'AFR' = 1
    'AMR' = 2
    'EUR' = 3
    'EMR'  = 4
    'SEAR' = 5
    'WPR' = 6
    other = 7; 
run;

* Method 1 - Data step approach;
proc sort data=sashelp.demographics out=demographics; 
  by region; run;
data want1(keep= region country sum_pop);
  set demographics;
  by region;
  if first.region then do;
    sum_pop=pop;
    country=1;
  end;
  else do;
    sum_pop+pop;
    country+1;
  end;
  if last.region then output;
 run;

 data want1x;
    set want1 end=lastobs;
	total + sum_pop;
	if lastobs then do;
     call symputx('total', total);
	output;
    end;
 run;
%put &=total;

 data running_pct;
  set want1;
  running_pct = sum_pop/&total;
run;

Title "Summarization Method 1 (DATA STEP Approach)";
proc print data=running_pct;
var region sum_pop running_pct;
sum sum_pop running_pct;
format region $regionfmt. sum_pop comma14. running_pct percent8.1;
run;

* Method 2;
proc means  data=sashelp.demographics noprint;
  var pop;
  output out=summary2(drop=_:) N= name sum= sum_pop;
run;

proc means data=sashelp.demographics noprint nway;
  class region;
  var pop;
  output out=want2(drop=_:) N=name sum=sum_pop;
run;

data want2x ;
  set want2 summary2(in=in2);
  if in2=1 then region='TOTAL'; 
if region='TOTAL' then call symputx('total2', sum_pop);
run;

%put &=total2;

 data running_pct2;
  set want2x;
  running_pct = sum_pop/&total2;
run;
%put &=total2;

Title "Summarization Method 2 (PROC MEANS)";
proc print data=running_pct2;
format region $regionfmt. sum_pop comma14. running_pct percent8.1;
run;

* Method 3;

proc summary data=sashelp.demographics ;
  var pop;
  output out=summary3 (drop=_:) 
           n=name
           sum=sum_pop;
run;

proc summary data=sashelp.demographics nway;
  var pop;
  class region;
  output out=want3 
           n=name
           sum=sum_pop;
run;

data want3x (drop=_:);
  set want3 summary3(in=in3);
  if in3=1 then region='TOTAL'; 
   if region='TOTAL' then call symputx('total3', sum_pop);
run;
%put &=total3;

 data running_pct3;
  set want3x;
  running_pct = sum_pop/&total3;
run;
%put &=total3;

Title "Summarization Method 3 (PROC SUMMARY)";
proc print data=running_pct3;; 
format region $regionfmt. sum_pop comma14. running_pct percent8.1;
run;

* Method 4; 
Title "Summarization Method 4 (PROC TABULATE)";
proc tabulate data=sashelp.demographics ;
  class region;
  var pop;
  tables  region all, pop*(N*f=4.0 sum*f=comma14. pctsum*f=7.1);
  format region $regionfmt.;
run;

* Method 5;
Title "Summarization Method 5 (PROC REPORT)";
ods listing;
proc report data=sashelp.demographics  headline headskip;
  column region pop pop=sum pop=pct;
  define region / group format=$regionfmt. ;
  define pop / analysis 'N'  n;
  define sum / analysis 'Sum'  format=comma14.;
  define pct / analysis 'Percent of Total' pctsum format=percent8.1;
  
  compute after;
      region = 'Total';
  endcomp;
 rbreak after / skip summarize ;
run;


* Method 6;
Title "Summarization Method 6 (PROC SQL)";
proc sql;
create table want1 as(
select region format= $regionfmt.,
      sum(pop) as sum_pop format=comma14.,
	  sum(pop)/ (select sum(pop) from  sashelp.demographics)*100 as percent_pop format=8.1
    from 
        sashelp.demographics
    group by region 
	
                      )
  union 
 select 'Total', 
         sum(pop) as sum_pop format=comma14.,
         sum(pop)*100/sum(pop) as percent_pop format=8.1
   from sashelp.demographics;
  select * 
   from want1
   order by input(region, order.); 
quit;  

* Summarization Method 7 (Hash Object Approach);
proc sort data=sashelp.demographics out=demographics; 
  by region; 
run;

data want1(keep=region name sum_pop);
  if _n_ = 1 then do;
    declare hash h(ordered:'a');
    h.definekey('region');
    h.definedata('region', 'name', 'sum_pop');
    h.definedone();
  end;
  
  set demographics end=eof;
  by region;
  
  if h.find() ne 0 then do;
    name = 1;
    sum_pop = pop;
  end;
  else do;
    country + 1;
    sum_pop + pop;
  end;
  
  h.replace();
  
  if last.region or eof then do;
    h.find();
    output;
  end;
run;

data want1x;
  set want1 end=lastobs;
  total + sum_pop;
  if lastobs then do;
    call symputx('total', total);
    output;
  end;
run;

%put &=total;

data running_pct;
  set want1;
  running_pct = sum_pop/&total;
run;

proc print data=running_pct;
run;

Title "Summarization Method 7 (Hash Object Approach)";
proc print data=running_pct;
  var region sum_pop running_pct;
  sum sum_pop running_pct;
  format region $regionfmt. sum_pop comma14. running_pct percent8.1;
run;

Title "Summarization Method 8 (PROC IML Approach)";
proc iml;
    /* Read the data */
    use sashelp.demographics;
    read all var {"Region" "Pop"};
    close sashelp.demographics;

    /* Get unique regions */
    unique_regions = unique(Region);
    n_regions = ncol(unique_regions);

    /* Initialize result matrices */
    result_n = j(1, n_regions, 0);
    result_sum = j(1, n_regions, 0);

    /* Calculate N and Sum for each region */
    do i = 1 to n_regions;
        region_mask = (Region = unique_regions[i]);
        result_n[i] = sum(region_mask);
        result_sum[i] = sum(Pop # region_mask);
    end;

    /* Calculate percentages */
    total_sum = sum(result_sum);
    result_pct = result_sum / total_sum;

    /* Create final result matrices */
    region_col = (unique_regions || "Total")`;
    n_col = (result_n || sum(result_n))`;
    sum_col = (result_sum || total_sum)`;
    pct_col = (result_pct || 1)`;
    /* Create column names */

    col_names = {"Region" "N" "Sum" "Percent_of_Total"};

    /* Print results */
    *print region_col n_col sum_col pct_col[colname=col_names];

    /* Create a dataset for PROC PRINT */
    create work.result var {region_col n_col sum_col pct_col};
    append;
    close work.result;
quit;

/* Use PROC PRINT for formatted output */
proc print data=work.result noobs label;
    var region_col n_col sum_col pct_col;
    label region_col = "Region"
          n_col = "N"
          sum_col = "Sum"
          pct_col = "Percent of Total";
    format region_col $regionfmt. n_col comma8. sum_col comma14. pct_col percent8.1;
run;

PROC PRINTTO;
RUN;
```


