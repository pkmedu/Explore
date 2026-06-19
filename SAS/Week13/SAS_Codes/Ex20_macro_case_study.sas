*Ex20_macro_case_study.sas;
proc datasets lib=work nolist kill; quit;
OPTIONS nocenter obs=max ps=58 ls=132 nodate nonumber
     FORMCHAR="|----|+|---+=|-/\<>*" PAGENO=1;
libname pufmeps  'C:\MEPS' access=readonly;
libname new 'C:\SDS';
FILENAME MYLOG "C:\SAS_Files\Ex20_macro_case_study_log.TXT";
FILENAME MYPRINT "C:\SAS_Files\Ex20_macro_case_study_output.TXT";;
PROC PRINTTO LOG=MYLOG PRINT=MYPRINT NEW;
RUN;
%let vars_kept = totexp:  opfex: opdexp: obvexp: erfexp: erdexp: 
                 ipfexp: ipdexp:  rxexp: dvtexp: visexp: hhaexp: hhnexp: othexp: ;
%macro setmeps(yr,file) / mindelimiter=',' minoperator;
   data FY_&yr;
     set pufmeps.&file 
                (keep=
                        %if &file in (h12, h20, h28) %then %do;
				            wtdper:
		                %end;
						%else  %do;
                            perwt:
						%end;
                      
                        %if &file in (h12, h20, h28, h38, h50, h60) %then %do;
						      varstr&yr varpsu&yr
		                %end;
						%else %do;
						   varstr varpsu
		                %end;

						&vars_kept

                 rename=(
 				        %if &file in (h12, h20, h28) %then %do;
				            wtdper&yr=perwtf
		                %end;
						%else %do;
                            perwt&yr.f=perwtf
						%end;
						%if &file in (h12, h20, h28, h38, h50, h60) %then %do;
				           varpsu&yr=varpsu
		                   varstr&yr=varstr
                        %end;
                         totexp&yr=totexp
						 opfexp&yr=opfexp
						 opdexp&yr=opdexp
						 obvexp&yr=obvexp
						 erfexp&yr=erfexp
                         erdexp&yr=erdexp
						 ipfexp&yr=ipfexp
						 ipdexp&yr=ipdexp
						 rxexp&yr=rxexp
						 dvtexp&yr=dvtexp
						 visexp&yr=visexp
						 hhaexp&yr= hhaexp 
                         hhnexp&yr=hhnexp
						 othexp&yr=othexp
						  )
                   );
		   %if &yr in (96, 97, 98, 99) %then %do;
		     year=19&yr.;
           %end;
		   %else %do;
	        year=20&yr.;
		   %end;
          *** create new variables;
		   
		   ambu = sum(obvexp, opdexp, opfexp, erdexp, erfexp);
		   pmed = rxexp;
		   inpatient = sum(ipdexp, ipfexp);
		   other = sum(dvtexp, visexp, hhaexp, hhnexp, othexp);	

           array vars [5] totexp ambu pmed inpatient other;
           array x_vars [5] c_totexp_GT_zero 
                            c_ambu_GT_zero 
                            c_pmed_GT_zero 
                            c_inpatient_GT_Zero 
                            c_other_GT_Zero;
           do i = 1 to 5;
		      if vars[i] > 0 then x_vars[i]=1; 
			  else x_vars[i]=0;
		   end;     

		   if totexp >=0 then all=1;
         
     run;
  %mend setmeps;
%setmeps(96,h12) %setmeps(97, h20) %setmeps(98,h28)
%setmeps(99,h38) %setmeps(00, h50) %setmeps(01,h60)
%setmeps(02,h70) %setmeps(03, h79) %setmeps(04,h89)
%setmeps(05,h97) %setmeps(06, h105) %setmeps(07,h113)
%setmeps(08,h121) %setmeps(09, h129) %setmeps(10,h138)
%setmeps(11,h147) %setmeps(12, h155) %setmeps(13,h163) 
%setmeps(14, h171) %setmeps(15,h181)

*** Combine data for 1996 through 2015;
options varlenchk=nowarn;
data new.Yr_1996_2015 (drop=i);
  set FY_96 FY_97 FY_98 FY_99 
      FY_00 FY_01 FY_02 FY_03 FY_04
      FY_05 FY_06 FY_07 FY_08 FY_09
	  FY_10 FY_11 FY_12 FY_13 FY_14
	  FY_15;
  run;
options obs=max;
proc tabulate data=new.Yr_1996_2015; 
var c_:;
class year;
tables year, (C_:)*sum*F=6.; run;

proc means data=new.Yr_1996_2015 N NMISS MIN MAX;
var _numeric_;
class year;
run;
proc printto;
run;


