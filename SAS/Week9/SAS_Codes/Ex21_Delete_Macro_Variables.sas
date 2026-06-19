*Ex21_Delete_Macro_Variables.sas;
options SYMBOLGEN nodate nonumber;
* Create macro variables;
%let mvar1=var_name1;
%let mvar2=var_value2;
%let mvar3=var_label;
%let mvar4=var_name2;
%let mvar5=var_value2;
%put _user_;
%symdel mvar3;
%put _user_;

%macro delete_m;
  %if %symexist (mvar4) %then %symdel mvar4;
  %if %symexist (mvar5) %then %symdel mvar5;
%mend delete_m;
%delete_m
%put _user_;

data _null_;
 call symdel('mvar1', 'nowarn');
 call symdel('mvar2', 'nowarn');
run;
%put _user_;


*https://blogs.sas.com/content/sastraining/2018/05/07/deleting-global-macro-variables/;
%macro deleteALL;
   	options nonotes;
   	%local vars;
   	proc sql noprint;
      	     select name into: vars separated by ' '
         	  from dictionary.macros
            	      where scope='GLOBAL' 
			   and not name contains 'SYS_SQL_IP_';
   	quit;
   	%symdel &vars;
   	options notes;
   	%put NOTE: Macro variables deleted.;
%mend deleteALL;
%deleteAll
