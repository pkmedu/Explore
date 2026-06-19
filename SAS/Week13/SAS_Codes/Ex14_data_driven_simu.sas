*Ex14_data_driven_simu.sas;
*Acknowledgement: Rick Wicklin;
/* Static simulation: Parameters embedded in the simulation program */
data AnovaStatic;
/* define parameters for three simulated group */
array N[3]       _temporary_ (50,   50,   50);   /* sample sizes */
array Mean[3]    _temporary_ (14.6, 42.6, 55.5); /* center for each group */
array StdDev[3]  _temporary_ ( 1.7,  4.7,  5.5); /* spread for each group */
 
call streaminit(12345);
do k = 1 to dim(N);              /* for each group */
   do i = 1 to N[k];             /* simulate N[k] observations */
      x = rand("Normal", Mean[k], StdDev[k]); /* from k_th normal distribution */
      output;
   end;
end;
run;
proc print data=AnovaStatic; run;

data params;                     /* define parameters for each simulated group */
input N Mean StdDev;
datalines; 
50 14.6 1.7
50 42.6 4.7
50 55.5 5.5
;
 
data AnovaDynamic;
call streaminit(12345);
set params;                      /* implicit loop over groups k=1,2,... */
do i = 1 to N;                   /* simulate N[k] observations */
   x = rand("Normal", Mean, StdDev); /* from k_th normal distribution */
   output;
end;
run;
proc print data=AnovaDynamic; run;
