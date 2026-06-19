*Ex12_IFC_IFN_Function.sas;
proc format;
    value agefmt
       . = 'Unknown'
       1 = 'TRUE'
       0 = 'FALSE'
;
 data IFC1_IFN1;
  length age 3 age_group_IFC1 $10;
  input age @@ ; 
    age_group_IFC1 = IFC(0<=age<=64, '0-64 Years', '65+ Years'); 
	age_LE64_IFN1 = IFN(0<=age<=64, 1, 0);
    age_LE64_IFN1_formatted = put(age_LE64_IFN1, agefmt.);
	drop age_LE64_IFN1;
  datalines;
  0 5 10 17 40 48 50 59 62 81 99 100
  ; 
 title1 'Ex12_IFC_IFN_Function.sas';
 proc print noobs; run;
 title1;

 

