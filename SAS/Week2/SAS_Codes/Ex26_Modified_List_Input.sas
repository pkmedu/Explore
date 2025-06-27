*Ex26_Modified_List_Input;
Options ls=132;
data annual_exp2013;
infile datalines;
input Age  (Food Housing Clothing Transportation Healthcare	
      Entertainment	Pension_S Other)(:comma.);

FORMAT Food Housing Clothing Transportation Healthcare	
      Entertainment	Pension_S Other dollar10.;
datalines;
0  4,698    10,379  1,513	5,672     943	1,243	2,153	3,771
25 6,197	17,207	1,832	9,183	2,189	2,214	5,178	4,087
35 7,920	20,619	1,960	10,519	3,188	2,958	6,791	4,827
45 7,907	19,001	1,826	10,782	3,801	3,070	7,305	6,833
55 6,711	17,937	1,563	9,482	4,378	2,651	6,593	6,577
65 6,020	15,639	1,222	7,972	5,188	2,488	2,833	5,394
75 4,144	12,314	768	    5,149	4,910	1,422	  832	4,844
;
run;
proc print data=annual_exp2013 noobs; 
run;
