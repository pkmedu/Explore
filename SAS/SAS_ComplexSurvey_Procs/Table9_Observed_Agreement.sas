%let path = C:\Users\Pradip.Muhuri\OneDrive - HHS Office of the Secretary\HomeDrive1;
%let xpath = C:\Users\Pradip.Muhuri\OneDrive - HHS Office of the Secretary\HomeDrive2;

FILENAME MYLOG "&xpath\_SMIF\Output\Table9_obsAdj_Agree_log.TXT";
FILENAME MYPRINT "&xpath\_SMIF\Output\Table9_obsAdj_Agree_output.TXT";
PROC PRINTTO LOG=MYLOG PRINT=MYPRINT NEW;
RUN;
libname new "&path\_SMIF\SDS";

proc format;
value sexfmt 1= 'Male'
         2='Female' ;
 value xd_fmt 1 = 'Both Yes/Both No'
             2 = 'Other'
             . = 'Missing';
run;

proc sort data= new.M_PSAQ_AF_2014_rev; by varstr varpsu; run;


title 'All PSAQ responsdents';

%macro loop(spop, list);
   %let k=1;
   %let var=%scan(&list, &k);
	 %do %while(&var NE);
     proc CROSSTAB  data= new.M_PSAQ_AF_2014_rev FILETYPE=SAS DESIGN=WR;
             	 	nest varstr varpsu /missunit;
              		weight  psaqwt;
					subgroup &var;
					subpopn &spop;
             		LEVELS 2;   
	         		tables &var;
					rformat &var xd_fmt.;
					setenv colwidth=20 decwidth=3;
             		PRINT NSUM wsum rowper  serow /style=nchs 
             		wsumfmt=F10.0 rowperfmt=F6.2 serowfmt=F5.3;       
      run;
	   %let k = %eval(&k+1);
	   %let var=%scan(&list, &k); 
	  %end;
	  %global glist;
	  %let glist=&list;
%mend loop;

%loop(x_psaqage>=35, PR_A_bpcheck)
%loop(x_psaqage>=35 & x_psaqage<=74, PR_A_cholchk)
%loop(x_psaqage>=35, PR_A_flusht)
%loop(x_psaqage>=50 & x_psaqage<=74 & PR_P_csb <=3, PR_A_csb)
%loop(x_psaqage>=35 & x_psaqage<=64 & sex=2 & PR_P_paps<=3, PR_A_paps)
%loop(x_psaqage>=50 & x_psaqage<=74 & sex=2 & PR_P_mamo <=3, PR_A_mamo)


title 'PSAQ responsdents who self-reponded in MEPS';
%macro loop(spop, list);
   %let k=1;
   %let var=%scan(&list, &k);
	 %do %while(&var NE);
     proc CROSSTAB  data= new.M_PSAQ_AF_2014_rev FILETYPE=SAS DESIGN=WR;
             	 	nest varstr varpsu /missunit;
              		weight  psaqwt;
					subgroup &var;
					subpopn &spop & resp53=1;
             		LEVELS 2;   
	         		tables &var;
					rformat &var xd_fmt.;
					setenv colwidth=20 decwidth=3;
             		PRINT NSUM wsum rowper  serow /style=nchs 
             		wsumfmt=F10.0 rowperfmt=F6.2 serowfmt=F5.3;       
      run;
	   %let k = %eval(&k+1);
	   %let var=%scan(&list, &k); 
	  %end;
	  %global glist;
	  %let glist=&list;
%mend loop;

%loop(x_psaqage>=35, PR_A_bpcheck)
%loop(x_psaqage>=35 & x_psaqage<=74, PR_A_cholchk)
%loop(x_psaqage>=35, PR_A_flusht)
%loop(x_psaqage>=50 & x_psaqage<=74 & PR_P_csb <=3, PR_A_csb)
%loop(x_psaqage>=35 & x_psaqage<=64 & sex=2 & PR_P_paps<=3, PR_A_paps)
%loop(x_psaqage>=50 & x_psaqage<=74 & sex=2 & PR_P_mamo <=3, PR_A_mamo)



proc printto;
run;

