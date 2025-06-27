*Ex22_Percent_DoLoop_Macro.sas;
%macro runit (first=, last=);
      %local yr;
      %do yr=&first %to &last;
        data have_20%sysfunc(putn(&yr,z2.));
              exp=20%sysfunc(putn(&yr,z2.))/4;
       		year=20%sysfunc(putn(&yr,z2.));
	     run; 
	   %end ;
%mend runit;
%runit(first=08, last=15)

data all_yrs;
 retain year;
  set Have:;
run;
proc print data=all_yrs noobs split='*';
label year= 'Survey Year'
      exp= 'Mean expenses*for treatment*on influenza*per person per year';
run;
