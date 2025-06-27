*Ex5_generate_SSN_dates_other_vars.sas;
title;
data have (drop=rownum date_a date_b);
call streaminit(123);
  date_a="01JAN1946"d;
  date_b="31DEC1964"d;
  
  do rownum = 1 to 100;
    SSN = put(ceilz(100000000*rand("Uniform")),ssn.);
	/* The difference between the two dates multiplied  
	   by a random number added to the base date, 
	   gives a date between the two values 
	 Adapted from RW9   5/24/207*/
	DOB=date_a + floorz((date_b-date_a) * rand("uniform"));
    value = floorz(1000*rand("Uniform"));
	format dob date9.;
    output;
  end;
run;
proc print data=have; run;
