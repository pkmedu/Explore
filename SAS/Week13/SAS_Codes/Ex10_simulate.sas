
*Getting Your Random Sample in Proc SQL Richard Severino;
*Ex10_simulate.sas;
data pop_dataset;
format rec_no 7.0 age 4.0 sex $6. icd9_code $13. ;
  label rec_no = "Record Number / ID"
        age = "Age in Years"
        sex = "Gender"
        norm01_rv = "RV N(0,1)"
        uni01_rv = "RV U(0,1)" ;
do i=1 to 1000 ; /* one thousand records */
       rec_no = i ; /* unique record identifier */
       norm01_rv = rannor(2736); /* Random Variable/Number: Normal(0,1) */
       uni01_rv = ranuni(3627); /* Random Variable/Number: Uniform(0,1) */
        if i le 300 then do ; /* first 30% will be in "Male" group */
           sex = "Male" ;
           age = ROUND( 4*RANNOR(36) + 50 ) ; /* Normal(50,4) */
		   icd9_code = '250.00-250.90'; /*diabetes*/
		   
 end;

 else if 301<=i<=400 then do ;
  icd9_code= '295.00-295.99'; /*schizophrenia*/
  sex = "Female" ;
  age = ROUND( 4*RANNOR(36) + 70) ; /* Normal(70,4) */
 end;

 else do ; /* the rest (70%) will be in this group */
 sex = "Female" ;
 age = ROUND( 4*RANNOR(36) + 40 ) ; /* Normal(40,4) */
   icd9_code= '401.00-405.99'; /*hypertension*/
 end;
 output;
end;
drop i;
run;

proc freq data=pop_dataset;
tables age sex icd9_code;
run;


