*Ex14_in_whichn_whichc.sas;
* Adapted from Joe Matise's code  (SAS-L) - 5/16/2016;
 data have1;
    set sashelp.class (obs=3);
    Age_13_dummy = whichn(13,age);
	Gender_male_dummy= whichc('M',sex);
  run;
 title1 'Ex14_in_whichn_whichc.sas';
 proc print data=have1 noobs;  run;
 title1;




