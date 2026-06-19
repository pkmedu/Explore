/*Simulation in SAS: The slow way or the BY way - Rick Wicklin */
*Ex8_simulate.sas;
%let N = 10;
%let NumSamples = 5;
data Uniform(keep=SampleID x); 
do SampleID = 1 to &NumSamples;  /* 1. create many samples */
   do i = 1 to &N;               /* sample of size &N */
     id=&N; /*Pradip's addition*/
      x = rand("Uniform");
      output;
   end;
end;
run;
 proc print data=uniform ;
 run;
proc means data=Uniform noprint; 
   by SampleID;                  /* 2. compute many statistics */
   var x;
   output out=OutStats mean=SampleMean;
run;
 
/* 3. analyze the sampling distribution of the statistic */
proc univariate data=OutStats;
   histogram SampleMean;
run;
