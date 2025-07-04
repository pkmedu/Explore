%let path = C:\Users\Pradip.Muhuri\OneDrive - HHS Office of the Secretary\HomeDrive1;
%let xpath = C:\Users\Pradip.Muhuri\OneDrive - HHS Office of the Secretary\HomeDrive2;

FILENAME MYLOG "&xpath\_SMIF\Output\Table9_kappa_Part2_log.TXT";
FILENAME MYPRINT "&xpath\_SMIF\Output\Table9_kappa_Part2_output.TXT";
PROC PRINTTO LOG=MYLOG PRINT=MYPRINT NEW;
RUN;
libname new "&path\_SMIF\SDS";

proc format;
value ps_var_fmt
	 1 = 'Received'
	 2 = 'Did not recieve';
run;
proc sort data= new.M_PSAQ_AF_2014_rev; by varstr varpsu; run;


* Kappa for Indicators that pertain to persons aged 35+ years;
 %macro loop(list);
   %let k=1;
   %let var=%scan(&list, &k);
	 %do %while(&var NE);
	 title;
     proc CROSSTAB  data= new.M_PSAQ_AF_2014_rev FILETYPE=SAS DESIGN=WR;
             	 	nest varstr varpsu /missunit;
              		weight  psaqwt;
					subgroup &var %sysfunc(tranwrd(&var, P_, C_));
					subpopn x_psaqage >=35 ;
             		LEVELS 2 2 ;   
					tables %sysfunc(cats(&var,*, %sysfunc(tranwrd(&var, P_, C_))));
                    agree %sysfunc(cats(&var,*, %sysfunc(tranwrd(&var, P_, C_))));
			rformat PR_P_bpcheck PR_P_flusht PR_C_bpcheck PR_C_flusht ps_var_fmt.;
	        setenv colwidth=12 decwidth=3;
            PRINT NSUM wsum colper secol kval sek /
            	kappa=default ktest=default style=nchs 
            	wsumfmt=F10.0 rowperfmt=F6.2 serowfmt=F5.3
            	colperfmt=F6.2 secolfmt=F5.3
            	totperfmt=F6.2 setotfmt=F5.3
            	kvalfmt=F5.3 sekfmt=F7.5; 
      run;
	   %let k = %eval(&k+1);
	   %let var=%scan(&list, &k); 
	  %end;
	  %global glist;
	  %let glist=&list;
%mend loop;
%loop(PR_P_bpcheck PR_P_flusht)

%macro loop(list);
   %let k=1;
   %let var=%scan(&list, &k);
	 %do %while(&var NE);
	 title;
     proc CROSSTAB  data= new.M_PSAQ_AF_2014_rev FILETYPE=SAS DESIGN=WR;
             	 	nest varstr varpsu /missunit;
              		weight  psaqwt;
					subgroup &var %sysfunc(tranwrd(&var, P_, C_));
					subpopn x_psaqage >=35 & x_psaqage<=74;
             		LEVELS 2 2;   
					tables %sysfunc(cats(&var,*, %sysfunc(tranwrd(&var, P_, C_))));
                    agree %sysfunc(cats(&var,*, %sysfunc(tranwrd(&var, P_, C_))));
			rformat PR_P_cholchk PR_C_cholchk ps_var_fmt.;
	        setenv colwidth=12 decwidth=3;
            PRINT NSUM wsum colper secol kval sek /
            	kappa=default ktest=default style=nchs 
            	wsumfmt=F10.0 rowperfmt=F6.2 serowfmt=F5.3
            	colperfmt=F6.2 secolfmt=F5.3
            	totperfmt=F6.2 setotfmt=F5.3
            	kvalfmt=F5.3 sekfmt=F7.5; 
      run;
	   %let k = %eval(&k+1);
	   %let var=%scan(&list, &k); 
	  %end;
	  %global glist;
	  %let glist=&list;
%mend loop;
%loop(PR_P_cholchk)


%macro loop(list);
   %let k=1;
   %let var=%scan(&list, &k);
	 %do %while(&var NE);
	 title;
     proc CROSSTAB  data= new.M_PSAQ_AF_2014_rev FILETYPE=SAS DESIGN=WR;
             	 	nest varstr varpsu /missunit;
              		weight  psaqwt;
					subgroup &var %sysfunc(tranwrd(&var, P_, C_));
					subpopn x_psaqage >=50 & x_psaqage<=74;
             		LEVELS 2 2 ;   
					tables %sysfunc(cats(&var,*, %sysfunc(tranwrd(&var, P_, C_))));
                    agree %sysfunc(cats(&var,*, %sysfunc(tranwrd(&var, P_, C_))));
			rformat PR_P_CSB  PR_C_CSB ps_var_fmt.;
	        setenv colwidth=12 decwidth=3;
            PRINT NSUM wsum colper secol kval sek /
            	kappa=default ktest=default style=nchs 
            	wsumfmt=F10.0 rowperfmt=F6.2 serowfmt=F5.3
            	colperfmt=F6.2 secolfmt=F5.3
            	totperfmt=F6.2 setotfmt=F5.3
            	kvalfmt=F5.3 sekfmt=F7.5; 
      run;
	   %let k = %eval(&k+1);
	   %let var=%scan(&list, &k); 
	  %end;
	  %global glist;
	  %let glist=&list;
%mend loop;
%loop(PR_P_CSB)

* Kappa for indicators that pertain to persons aged 50+ years;
%macro loop(list);
   %let k=1;
   %let var=%scan(&list, &k);
	 %do %while(&var NE);
	 title;
     proc CROSSTAB  data= new.M_PSAQ_AF_2014_rev FILETYPE=SAS DESIGN=WR;
             	 	nest varstr varpsu /missunit;
              		weight  psaqwt;
					subgroup &var %sysfunc(tranwrd(&var, P_, C_));
					subpopn x_psaqage >=35  & psaqage<=64 and sex=2;
             		LEVELS 2 2;   
					tables %sysfunc(cats(&var,*, %sysfunc(tranwrd(&var, P_, C_))));
                    agree %sysfunc(cats(&var,*, %sysfunc(tranwrd(&var, P_, C_))));
					rformat PR_P_PAPS PR_C_PAPS ps_var_fmt.;
					
	        setenv colwidth=12 decwidth=3;
            PRINT NSUM wsum colper secol kval sek /
            	kappa=default ktest=default style=nchs 
            	wsumfmt=F10.0 rowperfmt=F6.2 serowfmt=F5.3
            	colperfmt=F6.2 secolfmt=F5.3
            	totperfmt=F6.2 setotfmt=F5.3
            	kvalfmt=F5.3 sekfmt=F7.5; 
      run;
	   %let k = %eval(&k+1);
	   %let var=%scan(&list, &k); 
	  %end;
	  %global glist;
	  %let glist=&list;
%mend loop;
%loop(PR_P_PAPS)

   %macro loop(list);
   %let k=1;
   %let var=%scan(&list, &k);
	 %do %while(&var NE);
	 title;
     proc CROSSTAB  data= new.M_PSAQ_AF_2014_rev FILETYPE=SAS DESIGN=WR;
             	 	nest varstr varpsu /missunit;
              		weight  psaqwt;
					subgroup &var %sysfunc(tranwrd(&var, P_, C_));
					subpopn x_psaqage >=50  & psaqage<=74 and sex=2;;
             		LEVELS 2 2;   
					tables %sysfunc(cats(&var,*, %sysfunc(tranwrd(&var, P_, C_))));
                    agree %sysfunc(cats(&var,*, %sysfunc(tranwrd(&var, P_, C_))));
					rformat PR_P_Mamo PR_C_Mamo ps_var_fmt.;
	        setenv colwidth=12 decwidth=3;
            PRINT NSUM wsum colper secol kval sek /
            	kappa=default ktest=default style=nchs 
            	wsumfmt=F10.0 rowperfmt=F6.2 serowfmt=F5.3
            	colperfmt=F6.2 secolfmt=F5.3
            	totperfmt=F6.2 setotfmt=F5.3
            	kvalfmt=F5.3 sekfmt=F7.5; 
      run;
	   %let k = %eval(&k+1);
	   %let var=%scan(&list, &k); 
	  %end;
	  %global glist;
	  %let glist=&list;
%mend loop;
%loop(PR_P_MAMO)
proc printto;
run;


