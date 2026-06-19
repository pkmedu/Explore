
OPTIONS nocenter nodate nonumber symbolgen;
libname new 'C:\Data\sds_folder'  access=readonly;
libname xnew 'C:\Data\MEPS';
proc datasets nolist kill; run; quit;

%macro loops(list) / mindelimiter=',' minoperator;
     %local xcount i yr;                                             
     %let xcount=%sysfunc(countw(&list, %STR(|))); /* Count the number of data sets*/
     %do i = 1 %to &xcount; /* Loop through the total # of data sets */   
	     %let yr=%sysfunc(putn(%eval(&i-1),z2.)); /* Generate values from 00 to 18*/
            data xnew.FY_&yr;
               set new.%scan(&list,&i,%str(|)) 
                  (keep= totexp: perwt:
						%if %scan(&list,&i,%str(|)) in (h50, h60) %then %do;
						      varstr&yr varpsu&yr
		                %end;
						%else %do;
						   varstr varpsu
		                %end;
				
                       rename=(
 				               %if %scan(&list,&i,%str(|)) in (h50, h60) %then %do;
				                  varpsu&yr=varpsu
		                          varstr&yr=varstr
                               %end;
                               )
                  );
		             year=20&yr.;
		             if totexp&yr >=0 then nmiss_exp=1; 
                     if totexp&yr >0 then any_exp=1;
             run;
    %end;
  %mend loops;
%loops(h50|h60|h70|h79|h89|h97|h105|h113|h121|h129|h138|h147|h155|h163|h171|h181|h192|h201|h209)




