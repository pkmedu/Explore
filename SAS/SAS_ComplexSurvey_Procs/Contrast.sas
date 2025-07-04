



CONTRAST sex   = (1 -1) /name="Male vs. Female";
CONTRAST r_racethx2 = (1 -1) /name="NH white vs. Minorities"; 

CONTRAST x_marital_s = (1 -1 0) /name="Currently married vs. Never married"  ;
CONTRAST x_marital_s = (0 -1 1) /Widow/Divorced/Separated vs. Never married"  ;


CONTRAST r_edrecode2 = (1 -1) /name="Up to school vs. Some college or higher" ;
CONTRAST empstat13 = (1 -1) /name="Employed vs. Not employed";


CONTRAST d_inscov13 = (1 -1) /name="Uninsured vs. Insured";
CONTRAST d_famscat  = (1 -1) /name="1-3 persons vs. 4+ persons"
CONTRAST health2 = (1 -1) /name="Uninsured vs. Insured"
 
CONTRAST obv9_plus = (1 -1) /name="10+ visits vs. 9 or fewer visits";
CONTRAST hospn1_plus = (1 -1) /name="None vs. 1+ stays"

CONTRAST r_region = ( 1 -1 0 0) /name="Northeast vs. Midwest";
CONTRAST r_region = ( 0 -1 1 0) /name="South vs. Midwest";
CONTRAST r_region = ( 0 -1 0 1) /name="West vs. Midwest";

CONTRAST below_median_exp = (1 -1) /name="<$1,800 vs. >=$1,800";


CONTRAST r_region = ( 1 -1 0 0) /name="Northeast vs. Midwest";
CONTRAST r_region = ( 0 -1 1 0) /name="South vs. Midwest";
CONTRAST r_region = ( 0 -1 0 1) /name="West vs. Midwest";

CONTRAST  resp53  = (1 -1) /name="Self-respondent vs. Proxy Respondent"; 

CONTRAST  msa53_13r  = (1 -1) /name="Metro vs. Nonmetro"; 
CONTRAST  relresp13_x = (1 -1) /name="Initial refusal to round 1 interview vs. other"; 
			
			

