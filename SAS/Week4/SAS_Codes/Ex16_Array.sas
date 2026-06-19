*Ex16_Array1.sas;
options nocenter nonumber nodate;
DATA testdata;
 INPUT id $ test1-test5;
DATALINES;
A	 67 78 89 67 72
B	 77 78 89 91 89
C 	 87 88 89 91 89
D	 87 88 89 90 80
;
DATA testdata_y (DROP=i);
 SET testdata;
  ARRAY test [5] test1-test5;
  ARRAY fweight [5] _temporary_ (.18, .22, .25, .30, .05);
     DO i = 1 to 5;
     test[i] = test[i]*fweight[i];
     END;
  sum_test1_5= SUM(OF test1-test5);
title1 'Ex16_Array1.sas';
proc print data=testdata_y noobs;
run;
title1;

