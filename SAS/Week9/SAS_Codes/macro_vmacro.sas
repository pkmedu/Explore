
%let Put_title = List of Values into a Series of Macro Variables;
proc sql noprint;
 select distinct make
        INTO :makes1-
  FROM SASHELP.CARS ;
 %put Number of Rows: &sqlobs;
quit;
%macro reveal;
 %put &Put_title;
 %Do i=1 %TO &Sqlobs;
    %put &&makes&i;
  %end;
%mend reveal;
%reveal
%put _user_;
%put _global_;

 data vars;
  set sashelp.vmacro;
  temp=lag(name);
  run;
  proc print data=vars;
  where scope = 'GLOBAL' & temp ne name;
  run;
%macro delete_mvars;
 data vars;
  set sashelp.vmacro;
  run;
%mend;
%delete_mvars
