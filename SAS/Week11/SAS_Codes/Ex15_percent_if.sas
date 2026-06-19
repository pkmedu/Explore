*Ex15_macro_part_of_SAS_statement.sas;
%macro run_freq(row_var);
   title 'SASHELP Data Set - Selected Frequency Tables';
   proc freq data=sashelp.heart;
    	 tables
   %if &row_var ne  %then &row_var *;
      smoking_status;
   run;
%mend run_freq;

%run_freq()
%run_freq(sex)
%run_freq(Weight_Status)
