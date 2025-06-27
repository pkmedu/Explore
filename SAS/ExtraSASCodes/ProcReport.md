
```SAS
DATA work.HC_spend1;
 INFILE DATALINES DLM=',' MISSOVER;
 INPUT service_type: & $ 32. amount_in_B;
 DATALINES;
 Hospital Care, 882.3
 Physician and Clinical Services, 556.0
 Prescription Drugs, 263.3
 Nursing Care, 151.5
 Other Health Care, 138.2
 Dental Services, 110.9
 Home Health Care, 77.8
 Other Medical Products, 95.0
 Other Professional Services, 78.4
 ;
proc report data=work.HC_spend1 nowd SPLIT='*';
column service_type amount_in_B Percent;
define service_type / display  "Type of Services";
define amount_in_B / analysis SUM FORMAT=Dollar8.1 "Expenses (in Billions)"  Width=15;
define Percent / computed FORMAT=Percent8.1;

*Create Temporary Variables;
compute before;
 denom=amount_in_b.sum;
endcomp;

* Create a New Variable;
 compute Percent;
   Percent= amount_in_B.sum / denom;
 endcomp;

rbreak after / summarize UL OL;
Title1 "Health Care Expenditures by Type of Services, United States, 2012";
Title2 '  ';
run;
```

```SAS
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
proc report data=sashelp.cars nowd;
   column make type invoice invper msrp msrpper;
   define make / group;
   define type / group;
   define invper / computed format=percent8.1 'Invoice/Percent';
   define msrpper / computed format=percent8.1 'MSRP/Percent';

   /* Put the total sum of Type within Make into a DATA step variable */
   compute before make;
      invden = invoice.sum;
      msrpden = msrp.sum;
   endcomp;

/* Compute the percents */
   compute invper;
      if invden > 0 then invper = invoice.sum / invden;
   endcomp;
   compute msrpper;
      if msrpden > 0 then msrpper = msrp.sum / msrpden;
   endcomp;

    compute after make;
     type = 'Total';
   endcomp;
  break after make / summarize suppress skip;
 run;
