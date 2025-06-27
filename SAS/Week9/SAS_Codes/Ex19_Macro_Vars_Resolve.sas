*Ex19_Macro_Vars_Resolve.sas;
options nocenter nodate 
formchar= '|----|+|---+=|-/\<>*';
options symbolgen mprint;

%macro mac1;
%let Category1=Private; 
%let Category2=Medicaid; 
%let Category3=Uninsured;  
%let Category4=Other;  

%let Percent1=53.6; 
%let Percent2=23.4; 
%let Percent3=15.1;  
%let Percent4=7.9;  

%let SE1=1.0; 
%let SE2=0.8; 
%let SE3=0.7;  
%let SE4=0.5;
  
%let k=4;
 %do i=1 %to &k;
data work.have&i;
  category=put(resolve('&&category&i'),$10.); 
  percent=input(resolve('&&percent&i'), 8.);
  SE=input(resolve('&&SE&i'),8.);
  RSE=round(SE*100/percent, .01);
run;
%end;

%put _user_;
%mend mac1;
%mac1
%put _user_;
*Concatenate all four files;
data Want;
 set have:;
 run;
 title1 'Table 1: Distribution of emergency department visits within past 12 months';
 title2 'for adults aged 18-64, by type of insurance coverage, United States, 2014';
proc print data=want noobs split='*'; 
label category='Insurance Coverage'
	percent='Percentage* of Adults'
	SE='Standard* Error'
	RSE = 'Relative* Standard* Error (%)'; 
run;
%put _user_;
