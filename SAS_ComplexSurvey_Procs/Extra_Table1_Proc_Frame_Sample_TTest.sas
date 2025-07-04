
%let path = C:\Users\Pradip.Muhuri\OneDrive - HHS Office of the Secretary\HomeDrive1;
%let xpath = C:\Users\Pradip.Muhuri\OneDrive - HHS Office of the Secretary\HomeDrive2;

FILENAME MYLOG "&xpath.\_SMIF\Output\Extra_Table1_Frame_Sample_TTEST_log.TXT";
FILENAME MYPRINT "&xpath.\_SMIF\Output\Extra_Table1_Frame_Sample_TTest_output.TXT";
PROC PRINTTO LOG=MYLOG PRINT=MYPRINT NEW;
RUN;
options nocenter nonumber nodate ls=132 ;
options formchar="|----|+|---+=|-/\<>*";
libname new "&Path\_SMIF\SDS";
proc format;

value  flag_fmt 1 = 'Frame'
                2 = 'Sample';
value  resp53_fmt 1 = 'Self respondent'
                2 = 'Proxy respondent';
value ps_var_fmt
	 1 = 'Received'
	 2 = 'Did not recieve'
     3 = 'Nonresponse';
 value CAPI_age_fmt
     1 = '35-49'
	 2 = '50-64'
	 3 = '65-74'
	 4 = '75+';
value med_fmt  1 = 'Below_median'
               2 = 'at_above_medain'; 

value d_mar_fmt
	    1 = 'Curr/Never Married'
		2 = 'Wid/Div/Separated';

value Mar_fmt
	    1 = 'Currently Married'
		2 = 'Never Married'
		3 = 'Widowed/Divorced/Separated';

value r_region_fmt 1 = 'Northeast'
                 2 = 'Midwest'
                 3 = 'South' 
                 4 = 'West';		
		
value emp_fmt 1 = 'Employed'
              2 = 'Not Employed';

value d_insu_fmt 2 = 'Any Private/Public'
                 1 = 'Uninsured';

value d_region_fmt 1 = 'West'
                 2 = 'Other regions';


value d_fmscat_fmt 1 = '1,2,3'
                 2 = '4,5';
value obv9_p_fmt 1 = '10+ Office-based visits'
          2 = '0-9 Office-based visits';

value obv3_p_fmt 1 = '3+ Office-based visits'
          2 = '1-2 Office-based visits';

value Four_fmt 1 = 'BPC CC FluVac CCS'
          2 = 'None of 4 services';
value hosp_fmt  1 = '1+ HOSP night stays'
                 2 = 'No HOSP nigt stays'; 


run;
proc freq data=new.Both; tables resp53; run;

data new.X_Both;
  set new.Both;
  ARRAY Age_dummys {*} 3.  Age_grp_1 - Age_grp_4;
   DO i=1 TO 4;			      
    Age_dummys(i) = 0;
  END;
  if Age_grp ne . then Age_dummys( Age_grp) = 100;

  ARRAY Marital_dummys {*} 3.  x_marital_s_1 - x_marital_s_4;
   DO i=1 TO 3;	      
    Marital_dummys(i) = 0;
  END;
  if  x_marital_s ne . then Marital_dummys(  x_marital_s) = 100;

ARRAY Region_dummys {*} 3.  r_region_1 - r_region_4;
   DO i=1 TO 4;			      
    Region_dummys(i) = 0;
  END;
  if r_region ne . then Region_dummys( r_region) = 100;

options nosymbolgen nomlogic nomprint nomerror;
%macro runit (v);
	ARRAY &v._d {*} 3. &v._1 - &v._2;
 	DO i=1 TO 2;			      
  	    if &v ne . then &v._d(i) = 0;
  	END;
  	if &v ne . then &v._d( &v ) = 100;
%mend runit;

%runit(sex)
%runit(r_racethx2)
%runit(empstat13)
%runit(r_edrecode2)
%runit(r_povcat2)
%runit(health2)
%runit(d_inscov13)
%runit(d_famscat)
%runit(obv9_plus)
%runit(hospn1_plus)
%runit(below_median_exp)
run;
proc freq data=new.x_both;
tables empstat13_1 empstat13_2 /list missing;
run;
/*
sex_1 sex_2 
r_racethx2_1 r_racethx2_2 
empstat13_1 empstat13_2 
r_edrecode2_1  r_edrecode2_2
r_povcat2_1 r_povcat2_2
health2_1 health2_2
d_inscov13_1 d_inscov13_2
d_famscat_1 d_famscat_2
obv9_plus_1 obv9_plus_2
hospn1_plus_1 hospn1_plus_2
below_median_exp_1 below_median_exp_2
*/

options ls=132;
proc descript data=new.X_Both filetype=sas DESIGN=WR NOTSORTED;
       		nest  flag varstr  varpsu/ missunit;
			weight perwtf;
       		subpopn new_subpop=1;
       		class flag ;
			table flag;
			var 
			
			sex_1 sex_2 
			r_racethx2_1 r_racethx2_2 
			empstat13_1 empstat13_2 
			r_edrecode2_1  r_edrecode2_2
			r_povcat2_1 r_povcat2_2
			health2_1 health2_2
			d_inscov13_1 d_inscov13_2
			d_famscat_1 d_famscat_2
			obv9_plus_1 obv9_plus_2
			hospn1_plus_1 hospn1_plus_2
			below_median_exp_1 below_median_exp_2


            Age_grp_1  Age_grp_1 Age_grp_1 Age_grp_1
			x_marital_s_1 x_marital_s_2 x_marital_s_3
            r_region_1 r_region_2  r_region_3 r_region_4 ;

			catlevel 
			    100 100 100 100 100 100 100 100 100 100 100
                100 100 100 100 100 100 100 100 100 100 100
                100 100 100 100 100 100 100 100 100 100 100;
       		rformat  flag flag_fmt.;
			setenv colwidth=18 decwidth=0;
			print nsum percent sepercent/style=nchs nohead notime nodate 
            percentfmt=f8.2 sepercentfmt=f10.3;
		    
RUN;

proc descript data=new.X_Both filetype=sas DESIGN=WR NOTSORTED;
       		nest  flag varstr varpsu / missunit;
			weight perwtf;
       		subpopn new_subpop=1;
			subgroup flag;
			levels 2;
			rformat  flag flag_fmt.;
       		var 
			
            sex_1 sex_2 
			r_racethx2_1 r_racethx2_2 
			empstat13_1 empstat13_2 
			r_edrecode2_1  r_edrecode2_2
			r_povcat2_1 r_povcat2_2
			health2_1 health2_2
			d_inscov13_1 d_inscov13_2
			d_famscat_1 d_famscat_2
			obv9_plus_1 obv9_plus_2
			hospn1_plus_1 hospn1_plus_2
			below_median_exp_1 below_median_exp_2 

			Age_grp_1  Age_grp_2 Age_grp_3 Age_grp_4
			x_marital_s_1 x_marital_s_2 x_marital_s_3
            r_region_1 r_region_2 r_region_3 r_region_4 ;
			pairwise flag / Name= "Pairwise";
			setenv colwidth=18 decwidth=0;
			PRINT MEAN="Difference" SEMEAN="SE" LOWMEAN="Lower 95% Limit"
                  UPMEAN="Upper 95% Limit" T_MEAN="T-Stat" P_MEAN="P-Value" /
                  style=nchs 
                  meanfmt=f10.2 p_meanfmt=f7.4 
				  semeanfmt=F9.5 t_meanfmt=f7.5
                  LOWMEANfmt=f8.2 UPMEANfmt=f8.2 ;
	       
RUN;


proc printto;
run;
