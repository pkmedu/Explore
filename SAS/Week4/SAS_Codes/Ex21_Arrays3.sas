*Ex21_Arrays3.sas (Part 1);
*Convert inches to millimeters 
*Method 1 (Implicit Array);
data work.Implicit_array;
 infile datalines;
 input city  $10. inch_T1-inch_T4;
array  yinch  inch_T1-inch_T4;
array ymm	ymm_T1-ymm_T4;
do over  yinch;
  ymm = round((yinch/0.03937007874),.1);
end;
datalines;
Sacramento 	  3.73 	2.87 	2.57 	1.16
Miami 	      2.01 	2.08 	2.39 	2.85
Albany        2.36 	2.27 	2.93 	2.99
;
Title1 'Method 1 (Implicit Array)';
proc print data=Implicit_array noobs; 
 var city  ymm_T1-ymm_T4;
run;

*Ex21_Arrays3.sas (Part 2);
*Method 2 (Explicit Array);
data work.Explicit_array;
 infile datalines;
 input city  $10. inch_T1-inch_T4;
array inch {4} inch_T1-inch_T4;
array mm {4}	mm_T1-mm_T4;
do i = 1 to 4;
  mm{i} = round((inch{i}/0.03937007874),.1);
end;
datalines;
Sacramento 	  3.73 	2.87 	2.57 	1.16
Miami 	      2.01 	2.08 	2.39 	2.85
Albany        2.36 	2.27 	2.93 	2.99
;
title1 'Method 2 (Explicit Array)';
proc print data=work.Explicit_array noobs; 
 var  city mm_T1-mm_T4; 
run;

*Ex21_Arrays3.sas (Part 3);
*Method 3 - DIM FUNCTION;
data work.Dim_function;
 infile datalines;
 input city  $10. inch_T1-inch_T4;
array zinch {*} inch_T1-inch_T4;
array zmm  {*} zmm_T1-zmm_T4;
    do i = 1 to dim(zinch);
	zmm{i} = round((zinch{i}/0.03937007874),.1);
  end;
datalines;
Sacramento 	  3.73 	2.87 	2.57 	1.16
Miami 	      2.01 	2.08 	2.39 	2.85
Albany        2.36 	2.27 	2.93 	2.99
;
title1 'Method 3 - Explicit Arrays with the DIM Function';
proc print data=work.Dim_function noobs; 
 var  city zmm_T1-zmm_T4;
run;

*Ex21_Arrays3.sas (Part 4);
data work.score_to_grade;
 infile datalines;
 input id :$2. mtm1 mtm2 final ;
array exam {3} mtm1 mtm2 final ;
array c_exam {3} $2 c_mtm1 c_mtm2 c_final ;
do i = 1 to 3;
   if exam{i} >=3.80 then c_exam{i} = 'A';
   else if 3.50<=exam{i} <=3.80 then c_exam{i} = 'B+';
   else if 3.00<=exam{i} <=3.49 then c_exam{i} = 'B';
   else if exam{i} <3.00 then c_exam{i} = 'C';
end;
datalines;
G1	 3.73 	2.87 	4.00
G2	 3.80 	3.53 	2.73
G3 	 3.31 	3.93 	3.83
G4	 2.92 	3.08 	2.39
G5 	 2.36 	2.27 	1.93
;
title1 'Creating multiple new variables with ARRAY staements';
proc print data=work.score_to_grade noobs;
 var  mtm1 mtm2 final c_mtm1 c_mtm2 c_final; 
run;


