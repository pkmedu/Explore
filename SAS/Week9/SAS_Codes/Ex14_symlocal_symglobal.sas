*Ex14_symlocal_symglobal;
proc sql noprint;
select distinct make 
  into :make_list separated by ', '
from sashelp.cars (where=(make=:'A'));
quit;
%put &=make_list;
%put Does make_list exist (0=No/1=Yes)?:
    %symexist(make_list);
%put Is make_list a global macro variable 
     (0=No/1=Yes)?: 
     %symglobl(make_list);
%put Is make_list a local macro variable
     (0=No/1=Yes)?: 
%symlocal(make_list);
%symdel make_list/nowarn;
%put Does make_list exist (0=No/1=Yes)?:
    %symexist(make_list);

%macro test;
	proc sql noprint;
	select distinct make 
        into :x_make_list separated by ', '
	from sashelp.cars (where=(make=:'A'));
	quit;
%global y_make_list;
%let y_make_list=x_make_list;
%put _user_;

%if %symlocal(x_make_list) %then 
 %put %nrstr(%symlocal(x_make_list))=TRUE;
%else %put %symlocal %nrstr((x_make_list))=FALSE;

%if %symglobl(y_make_list) 
   %then %put %nrstr(%symglobl(y_make_list))=TRUE;
%else %put %symglobl %nrstr((y_make_list))=FALSE;
%mend test;
%test
