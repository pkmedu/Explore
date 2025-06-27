*Ex11A_put_function.sas;
options nocenter nonumber nonotes nosource; 
proc format;
 value $stypeF  U='Undergraduate'  G='Graduate' ;
 value stypeF  1='Undergraduate'  2='Graduate' ;
run;  
data put_function_data;
c_stype ='U';  
f_stype = put(c_stype, $stypeF.);
n_stype=2;
f_stype_n = put(n_stype, stypeF.);
n_id = 12345678; 
c_id =put(n_id, 8.);
n_amount = 23500; 
c_amount = put(n_amount, dollar7.);
SAS_date_value = 1357;    
c_date = put(SAS_date_value, Weekdate.);
putlog (_ALL_) (=/ +2);
proc contents data=put_function_data;
ods select variables;
run;


