*Ex12_SUM_Statement_vs_2_SETs.sas (Part 1);
options nocenter nodate nonumber;
DATA sale_by_mon ;
  INPUT mon $  sale @@;
  cum_sale+sale;
  DATALINES;
  Jan 164083 Feb 164260 Mar 163747 Apr 164759 
  May 165617 Jun 166098 Jul 167305 Aug 167797 
  Sep 169407 Oct 170681 Nov 171025 Dec 172995
  ;
run;
title1 'Example Data Set';
PROC PRINT DATA=sale_by_mon ; 
  FORMAT sale cum_sale dollar12.;
   SUM sale ;
  run;
*Ex12_SUM_Statement_vs_2_SETs.sas (Part 2);
DATA xsale;
  SET sale_by_mon(keep=cum_sale) 
        POINT=last nobs=last;
  SET sale_by_mon (drop=cum_sale);
  Percent_sale = sale/cum_sale;
run;
title1 'Combining the summary data with the detail data';
PROC PRINT DATA=xsale; 
  VAR mon sale Percent_sale;
  SUM sale Percent_sale;
  FORMAT sale dollar10. Percent_sale percent12.2;
run;
