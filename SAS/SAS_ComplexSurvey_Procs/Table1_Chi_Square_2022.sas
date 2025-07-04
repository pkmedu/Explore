
%let path = C:\Users\Pradip.Muhuri\OneDrive - HHS Office of the Secretary\HomeDrive1;
%let xpath = C:\Users\Pradip.Muhuri\OneDrive - HHS Office of the Secretary\HomeDrive2;
libname SDS "&path\_SMIF\SDS";
options formchar="|----|+|---+=|-/\<>*";

FILENAME MYLOG "&xpath.\_SMIF\Output\Table1_Frame_Sample_Chi_2022_log.TXT";
FILENAME MYPRINT "&xpath.\_SMIF\Output\Table1_Frame_Sample_chi_2022_output.TXT";
PROC PRINTTO LOG=MYLOG PRINT=MYPRINT NEW;
RUN;

proc format;
	  value age_fmt
     1 = '35-49'
	 2 = '50-64'
	 3 = '65-74'
	 4 = '75+';
VALUE sex_fmt 1 = 'Male'
               2 = 'Female';

value resp53_fmt 1 = 'Self Respondent'
                 2 = 'Proxy Respondent';
value med_fmt  1 = 'Below_median'
               2 = 'at_above_medain'; 

value Marital_fmt
	    1 = 'Currently Married'
		2 = 'Never Married'
		3 = 'Widowed/Divorced/Separated';

 value povcat2_fmt
   1 = 'P/NPR/LOW INCOME' 
   2 = 'MIDDLE/HIGH INCOME';
value edu2_fmt 
	       1 = 'Up to High School'
		   2 = 'At least some College';		
VALUE HEALTH2_fmt
      1='EXCELLENT/VGOOD/Good' 
      2='FAIR/POOR' ;

value emp_fmt 1 = 'Employed'
              2 = 'Not Employed';

value d_insu_fmt 2 = 'Any Private/Public'
                 1 = 'Uninsured';

value d_region_fmt 1 = 'West'
                 2 = 'Other regions';

value r_region_fmt 1 = 'Northeast'
                 2 = 'Midwest'
                 3 = 'South' 
                 4 = 'West';
value fmscat_fmt 1 = '1 person'
                 2 = '2 persons'
                 3 = '3 persons'
                 4 = ' 4 persons'
                 5 = ' 5+ persons';
				  
value d_fmscat_fmt 1 = '1-4'
                 2 = '5+';
value obv9_p_fmt 1 = '10+ Office-based visits'
          2 = '0-9 Office-based visits';

value obv3_p_fmt 1 = '3+ Office-based visits'
          2 = '1-2 Office-based visits';

value hosp_fmt  1 = '1+ HOSP night stays'
                 2 = 'No HOSP nigt stays'; 

VALUE flag_fmt 1 = 'Frame'
               2 = 'Sample';

value racethx2_fmt 1 = 'Hispanic'
          2 = 'NH White only'
		  3 = 'NH Black only'
		  4 = 'NH Asian only'
          5 = 'NH other/multi-race';

value ob_ori4_fmt 1 = '0 visit'
                 2 = '1 visit'
                 3 = '2-4 visits' 
                 4 = '5+ visits';

value ob_ori2_fmt 1 = '0-4 visits'
                 2 = '5+ visits';
value edu_fmt 1 = 'No degree'
      2 = 'High School'
      3 = 'Some college'
	  4 = "Bachelor's or higher";
	  
value rthx2_fmt  1 = 'Minorities'
                2 = 'NH Whites';

run;

options nocenter nodate nonumber ls=132 varlenchk=nowarn;
 %macro runit (var, value, fmt);
 PROC CROSSTAB DATA=SDS.Final_BOTH_REV FILETYPE=SAS DESIGN=WR notsorted;
 NEST flag varstr varpsu /missunit;
 WEIGHT PERWTF;
 subpopn new_subpop=1;
  SUBGROUP  flag &var;
 LEVELS    2  &value;
 tables FLAG*&var;
  test CHISQ llchisq cmh ; 
 SETENV DECWIDTH=4 COLWIDTH=15; 
 PRINT NSUM WSUM  rowper serow STESTVAL SPVAL SDF/
 REPLACE STYLE=NCHS;
 rformat &var &fmt..;
 rformat flag flag_fmt.;
 run;
%mend runit;

%runit(edu_cat, 4, edu_fmt)
%runit(racethx, 5, racethx2_fmt)
%runit(Minority, 2, rthx2_fmt)
%runit(ob_4cats, 4, ob_ori4_fmt)

%runit(resp53, 2, resp53_fmt)
%runit(AGE_GRP, 4, age_fmt)
%runit(sex, 2, sex_fmt)

%runit(r_edrecode2,2, edu2_fmt)
%runit(r_povcat2, 2, povcat2_fmt)
%runit(below_median_exp, 2, med_fmt)
%runit(health2, 2, health2_fmt)
%runit(d_inscov13, 2, d_insu_fmt)
%runit(x_marital_s,3, marital_fmt)
%runit(empstat13,2, emp_fmt)
%runit(r_region, 4, r_region_fmt)
%runit(famscat, 5, fmscat_fmt)
%runit(d_famscat, 2, d_fmscat_fmt)
%runit(obv9_plus, 2, obv9_p_fmt)
%runit(hospn1_plus, 2, hosp_fmt)



proc printto;
run;
