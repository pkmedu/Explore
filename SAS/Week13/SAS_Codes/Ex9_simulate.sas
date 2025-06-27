* Ex9_simulate.sas;
%LET Path=C:\SASCourse\Week14;
LIBNAME NEW "&Path";
%MACRO generate_state(state=, nstores=);
   data _null_;
     CALL STREAMINIT(1234);
      file "&PATH/&state..txt";
      %DO i = 1 %TO &nstores;
	     sales = FLOORZ(80000 + RAND("NORMAL") * 15000);
            put sales 7.;
            output;
	      %END;
	  run;
%MEND generate_state;
Filename mprint "&path\California.sas";
options mprint mfile;
%generate_state(state = California, nstores = 8)

Filename mprint "&path\Texas.sas";
options mprint mfile;
%generate_state(state = Texas,  nstores = 5)

%MACRO generate_state(state=, nstores=);
data _null_;
 CALL STREAMINIT(1234);
 file "&PATH/&state..txt";
        do x=1 to &nstores;
		    sales = FLOORZ(80000 + RAND("NORMAL") * 15000);
            put sales 7.;
           output;
        end;
        run;
%MEND generate_state;
%generate_state(state = California_x, nstores = 8)
%generate_state(state = Texas_x, nstores = 5)

