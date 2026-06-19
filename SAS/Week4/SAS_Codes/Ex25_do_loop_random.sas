title1; title2;
*Ex25_do_loop_random.sas;
* Create 100 observations, 40 variables for each;
options nocenter nonumber nodate;
data have;
  call streaminit(1234);
  array vars[20] var1-Var20; /*array of 20 varianles*/
  array xvars[20] xvar1-xvar20; /* array of another 20 variables*/
  do obsnum=1 to 100;  /* create 100 observations*/
     do i=1 to 20;
       vars[i]=round(RAND('Uniform')*100);  /* This distribution has no inputs */
       xvars[i]=round(RAND('Normal', 30,5));
     end;
     output;
  end;
  drop i;
run;
proc print data=have noobs;
run;

options nocenter nonumber nodate;
* Create 25 observations, 20 character variables with ranging from A through E;
data have2;
retain obsnum;
call streaminit(1234);
  array vars[20]  var1-var20; /*array of 20 varianles*/
  array _vars[20] $ _var1-_var20; /*array of 20 varianles*/
  array xvars[20] $  xvar1-xvar20; /* array of another 20 character variables*/
    do obsnum=1 to 25;  /* create 25 observations*/
     do i=1 to 20;
        vars[i]=round(RAND('Integer', 1,5));
		_vars[i]=put(vars[i], 3.);
        xvars[i]=TRANSLATE(_vars[i],'ABCDE','12345'); ;
     end;
     output;
  end;
  drop i v: _: ;   /* Drop these variables */
run;
proc contents; run;
proc print data=have2 noobs;
run;

