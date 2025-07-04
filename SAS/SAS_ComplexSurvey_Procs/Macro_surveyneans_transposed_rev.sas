DM 'output' clear;
DM 'log' clear;
proc datasets kill nolist nodetails; quit;

OPTIONS nocenter obs=max ps=58 ls=132 nodate nonumber ;
libname out "U:\A_DataRequest";
libname library "U:\A_DataRequest";
proc datasets kill nolist nodetails; quit;
%macro svyrun;
   %DO yr = 12 %to 14;
  		 ods graphics off;
		 ods trace on /listing;
 		 proc surveymeans data=out.FYC&yr nobs nmiss mean clm ;
  			stratum varstr;
  			cluster varpsu;
  			weight perwt&yr.f ;
  			var OBTEXP%sysfunc(putn(&yr, z2.)) ;
  			domain age_grp sex r_RTHLTH r_CSHCN insurcov;
			ods output Statistics=out.ALL_FYC&yr  domain=out.Stat_FYC&yr ;
			run;
			ods trace off;
	%end;
%mend svyrun;
%svyrun   

* For sorting transposed data sets - get the listing in the desired output;
proc format;
invalue sortfmt
    '  '=1
	'0-17' = 2
	'18-64' = 3
	'65+' = 4 
	'Male' = 5            
	'Female' = 6
	'Poor-FAIR' = 7           
	'Good-Excellent' = 8   
	'Yes'  = 9        
	'No'  = 10
    'Any Private' = 11
    'Public only' = 12
    'Medicaid only' = 13
	'Medicare & Private'  = 14
	'Medicare & other Public' =15
	'Uninsured' = 16
	'Missing' = 17 ;

 * For relabeling purposes;

value $newfmt
    ' '   ='Overall'
	'0-17' = 'Ages 0-17 Yrs'
	'18-64' = 'Ages 18-64 Yrs'
	'65+' = 'Ages 65+ Yrs' 
	'Male' = 'Male'            
	'Female' = 'Female'
	'Poor-FAIR' = 'Health Cond: Poor-FAIR'           
	'Good-Excellent' = 'Health Cond: Good-Excellent'   
	'Yes'  =  'Children with Sp HC Needs'        
	'No'  = 'Children with No Sp HC Needs' 
	'Any Private' = 'Insurance: Any Private'
    'Public only' = 'Insurance: Public only'
    'Medicaid only' =  'Insurance: Medicaid only'
	'Medicare & Private'  =  'Insurance: Medicare & Private'
	'Medicare & other Public' = 'Insurance: Medicare & other Public'
	'Uninsured' = 'Insurance: Uninsured'
	'Missing' =  'Insurance: Missing';
;
run;

* Concatenate the PROC SURVEYMEANS ODS TABLES; 
  data comb (rename=(_N =N));
  set out.ALL_FYC12
      out.ALL_FYC13
      out.ALL_FYC14
      out.Stat_FYC12  
      out.Stat_FYC13 
      out.Stat_FYC14  indsname=source;

  * concatenate the COLUMNs for mean and SE for total expenses;
  length  year $4 Mean_SE_TOTEXP  $19   CH_comp_col2 $35;

  _N= put(N, comma9.);
  *cattdvar= catx(' ', put(mean, dollar7.), cats( '(',put(StdErr, 7.1),')' ) );
  cattdvar= catx(' ', put(mean, dollar5.), cats( '(',put(StdErr, 6.1),')' ) );
  *Mean_SE_TOTEXP= put(cattdvar,$17. -r);
  Mean_SE_OBTEXP= put(cattdvar,$17. -r);
  
  * create the YEAR variable INDXNAME= source;
  year = CAT(20, substr(source, length(source)-1));
	  
  * create formatted character variables for the classification variables;
  * using the formats the created/associated in a another program that prepared the data file;

  x_age_grp=put(age_grp, agefmt.);
  x_sex=put(sex, sexfmt.);
  x_r_RTHLTH=put(r_RTHLTH, RTHLTHfmt.);
  x_r_CSHCN=put(r_CSHCN, CSHCNfmt.);
  x_insurcov=put(insurcov, insurcovF.);

  * create a formatted composite DOMAIN variable with first non-missing values;
   CH_comp_col2 = (COALESCEC(OF x_:));  

   * drop unwanted variables;       
   DROP DomainLabel VarName VarLabel nmiss 
   age_grp sex r_RTHLTH r_CSHCN N cattdvar ;
run;

proc print data=comb; var CH_comp_col2 ; run;
proc sort data=comb; by year CH_comp_col2; run;

* perform double transposition;

proc transpose data=comb name=stat out=t_comb ;
 by year CH_comp_col2;
 var N Mean_SE_OBTEXP;
 run;

proc sort data=t_comb; by CH_comp_col2; run;
proc transpose data=t_comb  name=Stat out=tt_comb;
 by CH_comp_col2;
 var col1;
 id stat year;
 run;
proc print data=tt_comb; run;
* Sort the transposed data by composite classification categories;
data x_tt_comb;
 set tt_comb;
 sorted_var=INPUT(CH_comp_col2, sortfmt.); 
 Format CH_comp_col2 $newfmt.;
run;

proc sort data=x_tt_comb; by sorted_var; run;
proc print data= x_tt_comb (drop=stat sorted_var) split ='*'; 
label CH_comp_col2= 'Demographics & Health Cond'
      N2012 = 'N' 
      /*Mean_SE_TOTEXP2012 = '2012* Mean Total Exp (SE)'*/
      Mean_SE_OBTEXP2012 = '2012* Mean Office-Based*Total Exp (SE)'
	  N2013 = 'N' 
      Mean_SE_OBTEXP2013 = '2013* Mean Office-Based*Total Exp (SE)'

	  N2014 = 'N' 
      Mean_SE_OBTEXP2014 = '2014* Mean Office-Based*Total Exp (SE)';
                    
run;




