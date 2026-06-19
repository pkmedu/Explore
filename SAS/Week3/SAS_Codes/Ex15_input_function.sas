*Ex15_input_function.sas (Part 1);
options nocenter nonumber nodate nosource;
data input_function_data;
  c_id = '12345678'; 
  n_id =input(c_id, 8.); 
  c_id_x =input(c_id, $8.);
  c_amount = '$23,500'; 
  n_amount = input(c_amount, dollar7.);
  c_amount_x = '9999';
  n_amount_x = input(c_amount_x, 5.2);
  c_date = '13Sep1963'; 
  n_date = input(c_date, date9.);
FORMAT n_date date9.  n_amount dollar7.; 
putlog (_ALL_) ( =/ +2);  
run;

*Ex15_input_function.sas (Part 2);
title1 'Ex15_input_function.sas (Part 2)' ;
proc contents data=input_function_data varnum; 
ods select position;
run;
title1;

*Ex15_input_function.sas (Part 3);
** ?? Modifier used in the INPUT function;
data _null_;
input c_date $; 
n_date=input(c_date, ?? mmddyy10.);
put c_date= n_date=date9.;
datalines;
02292017
03202017
;
