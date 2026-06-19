DM "Log; clear; output; clear; odsresults; clear;";
OPTIONS nocenter nodate nonumber symbolgen;
libname new 'C:\Data\MySDS'  access=readonly;
libname xnew 'C:\Data\MEPS';
proc datasets nolist kill; run; quit;

%macro loops(list) ;
     %local xcount i yr;                                             
     %let xcount=%sysfunc(countw(&list, %STR(|))); /* Count the number of data sets*/
	 
     %do i = 1 %to &xcount; /* Loop through the total # of data sets */   
	     %let yr=%sysfunc(putn(%eval(&i+5),z2.)); /* Generate values from 06 to 18*/
            data xnew.FY_&yr;
               set new.%scan(&list,&i,%str(|)) 
                  (keep= totexp: perwt: varstr varpsu);
		             year=20&yr.;
		             if totexp&yr >=0 then nmiss_exp=1; 
                     if totexp&yr >0 then any_exp=1;
             run;
	%put _local_;
    %end;
  %mend loops;
%loops(h105|h113|h121|h129|h138|h147|h155|h163|h171|h181|h192|h201|h209)


/*/ mindelimiter=' ' minoperator */

