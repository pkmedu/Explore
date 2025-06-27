*Ex16_put_function.sas;
proc format;
 value $stypeF  U='Undergraduate'  G='Graduate' ;
run;  
data put_function_data;
c_stype1 ='U';  
c_stype2 = put(c_stype1, $stypeF.);
n_id = 12345678; 
c_id =put(n_id, 8.);
n_amount = 23500; 
c_amount = put(n_amount, dollar7.);
n_date = 1357;    
c_date = put(1357, Weekdate.);
FORMAT n_date Weekdate.  n_amount dollar7.; 
putlog (_ALL_) (=/ +2);
run;
*Ex16_put_function.sas (Part 2);
title1 'Ex16_put_function.sas (Part 2)';
proc contents data=put_function_data varnum; 
ods select position;
run;
title1;

* Resolving the issue with Numeric-to-Character conversion
when the numeric value has missing values

data class;
	set sashelp.class;
	if age<=12 then	weight=.;
run;
data have_x;
	set class;
	weight_char1=put(weight, best.);
	if weight > . then weight_char2 = put(weight, best.);
	else weight_char2 = ' ';
run;
proc print data=have_x; run;

