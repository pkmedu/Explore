
DATA Want1;
   do i = 1, 7, 9, 11, 19;
     SET sashelp.class point=i;
    output;
   end;
 stop;
run;

DATA Want2;
  SET sashelp.class;
if _N_ in (1, 7, 9, 11, 19);
run;


proc compare base = want1 compare=want2;
run;

proc compare base = want1 compare=want2 novalues listvar;
run;
