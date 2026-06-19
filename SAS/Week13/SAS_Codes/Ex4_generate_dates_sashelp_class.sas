*Ex4_generate_dates_sashelp_class.sas;
title;
data class ;
call streaminit(123);
    set sashelp.class;
      dob=Today()
          -floorz(age*365 + 
                  + floorz(100*rand("Uniform"))
                  +(rand("uniform"))
                  );
	  age2=int((today() - dob)/365.25);
	  /*use the INTCK function to measure the number of intervals 
      between two dates [ DOB and TODAY0 */
	  age3 = INTCK('YEAR',DOB,TODAY());
	  today_date=today();
	  age4=YRDIF(DoB, today(), 'ACT/ACT') ;
     format today_date dob date9.;
  run;
proc print data=class; run;
