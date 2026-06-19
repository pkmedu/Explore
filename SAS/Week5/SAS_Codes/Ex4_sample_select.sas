*Ex4_sample_select.sas (Part 1);
options nocenter nodate nonumber;
proc surveyselect data=SASHELP.HEART
  method=srs n=100 out=WORK.HEART;
run;


*Ex4_sample_select.sas (Part 2);
options nocenter nodate nonumber nosource;
data MaleSamples FemaleSamples;
  drop  i SampleSize;
   SampleSize=100;
  do i = 1 to SampleSize;
      SelectSamples=ceil(ranuni(0) * TotObs);
	SET SASHELP.HEART point=SelectSamples nobs=TotObs;
	   if sex='Male' then output MaleSamples;
	   else output FemaleSamples;
  END;
  STOP; 
run;
