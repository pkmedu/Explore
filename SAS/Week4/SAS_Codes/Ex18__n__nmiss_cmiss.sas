*Ex18_n_nmiss_cmiss.sas;
options nodate nonumber;
data work.HAVE;
infile datalines TRUNCOVER;
input A 1 B 3 C 5 D $ 7-11 E $ 13-16;
datalines;
7 1 1 SAS   Stat
8     SPSS  Econ
6 3 1 R     Math
  6 1       Soc 
  1   Stata Epi 
5 4 2       Stat
;
 
data work.WANT;
set work.HAVE;
Is_Missing_A= missing(A);
Is_Missing_D= missing(D);
Count_Missing_Num = nmiss(OF A--C);
Count_Missing_Both_Num_Char = cmiss(A,B,C,D,E);
Count_Nonmissing_Num = n(OF A--C);
run;
title1 'Handling missing values';
proc print data=WANT noobs split='*';
label Is_Missing_A ='Whether*Variable A *Missing'
      Is_Missing_D ='Whether*Variable D*Missing'
Count_Missing_Num='Missing*Values*for*Numeric*Variables'
Count_Missing_Both_Num_Char='Missing*Values*for*Num/Char*Variables'
Count_Nonmissing_Num= 'Nonmissing*Values*for*Numeric*Variables'
; 
run;
title;

