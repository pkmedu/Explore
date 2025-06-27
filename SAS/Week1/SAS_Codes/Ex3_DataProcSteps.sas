* EX3_DataProcSteps.sas;
OPTIONS nocenter nodate nonumber;
%LET DateRun=%sysfunc(today(), worddate);
DATA work.HAVE;
 INPUT Name $ quiz1-quiz3;
   Ave_Score = ROUND(MEAN(OF quiz1-quiz3),.01);
   LABEL quiz1 = 'Quiz 1 Score' 
         quiz2 = 'Quiz 2 Score' 
         quiz3 = 'Quiz 3 Score'
         Ave_Score = 'Average Score';
 DATALINES;
 Kirk  78 84 82 
 Neil 90 85 86 
 John 82 79 89 
 Keya 78 86 78 
 ;
title "Listing from HAVE SAS Data File - &DateRun";
PROC PRINT data=work.HAVE noobs label; 
run;
