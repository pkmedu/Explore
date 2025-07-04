
%let path = C:\Users\Pradip.Muhuri\OneDrive - HHS Office of the Secretary\HomeDrive1;
%let xpath = C:\Users\Pradip.Muhuri\OneDrive - HHS Office of the Secretary\HomeDrive2;

FILENAME MYLOG "&xpath.\_SMIF\Output\Conclusion_Chisquare_log.TXT";
FILENAME MYPRINT "&xpath.\_SMIF\Output\Conclusion_Chisquare_Output.TXT";
PROC PRINTTO LOG=MYLOG PRINT=MYPRINT NEW;
RUN;

libname new "&path\_SMIF\SDS";

proc format;
value  resp_fmt 1 = 'Respondent'
                2 = 'Nonrespondent'
                3 = ' Other';
value Capi_age_fmt
     1 = '35-49'
	 2 = '50-64'
	 3 = '65-74'
	 4 = '75+';

value sex_fmt 1 = 'Male'
              2 = 'Female';
VALUE Racethx2_fmt
  1 = 'NH White Only'
  2 = 'Race/Ethnic Minority' ;
value edu2_fmt 
	       1 = 'Up to High School'
		   2 = 'At least some College';

value povcat2_fmt
   1 = 'P/NPR/LOW INCOME' 
   2 = 'MIDDLE/HIGH INCOME';

VALUE HEALTH2_fmt
      1='EXCELLENT/VGOOD/Good' 
      2='FAIR/POOR' ;

value resp53_fmt 1 = 'Self Respondent'
                 2 = 'Proxy Respondent';

value med_fmt  1 = 'Below_median'
               2 = 'at_above_medain'; 

value Marital_fmt
	    1 = 'Currently Married'
		2 = 'Never Married'
		3 = 'Widowed/Divorced/Separated';
		
value emp_fmt 1 = 'Employed'
              2 = 'Not Employed';

value d_insu_fmt 1 = 'Uninsured'
                 2 = 'Any Private/Public';

value d_region_fmt 1 = 'West'
                 2 = 'Other regions';

value r_region_fmt 1 = 'Northeast'
                 2 = 'Midwest'
                 3 = 'South' 
                 4 = 'West';

value d_fmscat_fmt 1 = '1,2,3'
                 2 = '4,5';
value obv9_p_fmt 1 = '10+ Office-based visits'
          2 = '0-9 Office-based visits';

value obv3_p_fmt 1 = '3+ Office-based visits'
          2 = '1-2 Office-based visits';

value hosp_fmt  1 = '1+ HOSP night stays'
                 2 = 'No HOSP nigt stays'; 

run;
proc sort data=new.Resp_Nonresp_rev13; by varstr varpsu; run;
%macro runit (var, value, fmt);
 PROC CROSSTAB DATA=new.Resp_Nonresp_rev13 FILETYPE=SAS DESIGN=WR;
 NEST varstr varpsu /missunit;
 WEIGHT basewgt;
 subpopn age_35plus=1 & resp12=1;
 SUBGROUP psaqresp &var;
 LEVELS  2   &value;
 tables psaqresp*&var;
 test CHISQ llchisq cmh ; 
 SETENV DECWIDTH=4 COLWIDTH=15; 
 PRINT NSUM WSUM  rowper serow STESTVAL SPVAL SDF/
  REPLACE STYLE=NCHS;
    rformat psaqresp resp_fmt.;
    rformat &var &fmt..;
 run;
%mend runit;
%runit(resp53, 2, resp53_fmt)
%runit(CAPI_AGE_GRP, 4, CAPI_age_fmt)
%runit(sex, 2, sex_fmt)
%runit(r_racethx2, 2, racethx2_fmt)
%runit(r_edrecode2,2, edu2_fmt)
%runit(r_povcat2, 2, povcat2_fmt)
%runit(below_median_exp, 2, med_fmt)
%runit(health2, 2, health2_fmt)
%runit(d_inscov13, 2, d_insu_fmt)
%runit(x_marital_s,3, marital_fmt)
%runit(empstat13,2, emp_fmt)
%runit(r_region, 4, r_region_fmt)
%runit(d_famscat, 2, d_fmscat_fmt)
%runit(obv9_plus, 2, obv9_p_fmt)
%runit(hospn1_plus, 2, hosp_fmt)
proc printto;
run;

