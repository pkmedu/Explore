*Example_datastep_macro_var_func.sas;
data _null_;
  var1= 'George Washington University';
  var2 ='Stat Department';
  length_var1=length(var1);
  length_var2=length(var2);
  loc_fc_Washington_var1=index(var1, 'Washington');
  upcase_var1=upcase(var1);
  scan_var1=SCAN(var1, 2);
  substr_var2=substr(var2, 1, 4);
  putlog (_ALL_) (= /);
run;

%let mvar1= George Washington University;
%let mvar2 =Stat Department;
%let mvar3 = (GE Capital Real Estate);
%let length_mvar1=%length(&mvar1);
%let length_mvar2=%length(&mvar2);
%let loc_fc_mvar1=%index(&mvar1, Washington);
%let upcase_mvar1=%upcase(&mvar1);
%let scan_mvar1=%scan(&mvar1,2);
%let substr_mvar1=%scan(&mvar2,1);
%let qscan_mvar1=%qscan(&mvar3,1);

%put &=mvar1; %put &=mvar2; %put &=mvar3;
%put &=length_mvar1; 
%put &=length_mvar2;
%put &=loc_fc_mvar1; 
%put &=upcase_mvar1; 
%put &=scan_mvar1;
%put &=substr_mvar1;
%put &=qscan_mvar1;


