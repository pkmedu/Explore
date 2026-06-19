*Ex5_how_many_obs.sas ((Part 1);
options nonotes nosource nodate nonumber leftmargin=1cm;
DATA  _NULL_;
 SET sashelp.heart NOBS=numobs;
 if numobs then PUT @7 "Number of cases =" numobs comma7.;
 stop;
run;
*Ex5_how_many_obs.sas ((Part 2);
DATA   _NULL_;
  SET sashelp.heart END=last;
  count+1;
  if last then PUT @7 "Number of cases =" count comma7.;
run;
*Ex5_how_many_obs.sas ((Part 3);
DATA  _NULL_;
 if 0 then SET sashelp.heart NOBS=N;
   CALL SYMPUTX('total', N);
 stop;
run;
/* Below are 3 ways to display the value of the macro variable (&total) */
%PUT &total;
%PUT Number of cases = %SYSFUNC(left(&total));
%PUT Number of cases = %SYSFUNC(left(%qsysfunc(putn(&total, comma7.))));

*Ex5_how_many_obs.sas ((Part 4);
PROC SQL noprint;
select count(*)into :OBSCOUNT
 from sashelp.heart;
quit;
%PUT Number of cases = %SYSFUNC(left(%qsysfunc(putn(&total, comma7.))));



