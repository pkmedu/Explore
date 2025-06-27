*Example_put_align_values.sas;
options nodate nonumber;
data have;
  prevalence = 23.05; SE=1.9845; output;
  prevalence = 3.05; SE=0.1845; output;
run; 
data want;
set have;
  cattdvar= catx(' ', put(prevalence, 5.1), 
                  cats( '(',put(SE, 4.2),')' )
                 );
  xcattdvar= put(cattdvar,$11. -r);
run;
proc print data=want noobs; run;

