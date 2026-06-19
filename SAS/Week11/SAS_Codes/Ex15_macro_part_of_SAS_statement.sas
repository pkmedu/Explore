*Ex15_macro_part_of_SAS_statement.sas;
options nocenter nodate nonumber;
%macro run_freq(row_var);
   proc freq data=sashelp.heart;
    	 tables
   %if &row_var ne  %then &row_var *;
      smoking_status;
   run;
%mend run_freq;

%run_freq()
%run_freq(sex)
%run_freq(Weight_Status)
