*Ex6_Conpilation_Execution.sas;
DATA work.HAVE;
PUT 'After Compilation, Before Execution:' _ALL_;
 INPUT Name $ quiz1 quiz2 quiz3;
   Ave_Score = ROUND(MEAN(OF quiz1-quiz3),.01);
 put 'At End of Execution:' _ALL_;
 DATALINES;
 Amy  78 84 82 
 Neil 90 85 86 
 John 82 79 89 
 Keya 78 86 78 
 ;
 run;
