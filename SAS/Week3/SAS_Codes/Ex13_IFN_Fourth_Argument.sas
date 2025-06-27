*Ex13_IFN_Fourth_Argument.sas;
DATA Work.Ifn_Func;
INPUT property_value;
property_tax = ifn(property_value GE 150000,
               property_value*.02,
		       property_value*.015, .);
format property_value property_tax dollar8.;
datalines;
150000
. 
250000
100000
;
title1 'Ex13_IFN_Fourth_Argument.sas';
proc print data=Work.Ifn_Func; 
run;
title1;
