*Ex17_Advance_Dates_INTNX.sas;
options nocenter nonumber nodate;
data work.Have;
some_date='31Aug2018'D;
next_default_fw=intnx('month',some_date,2);
next_default_bw=intnx('month',some_date, -2);
next_b=intnx('month',some_date,2, 'beginning');
next_m=intnx('month',some_date,2, 'middle');
next_e=intnx('month',some_date,2, 'end');
next_s=intnx('month',some_date,2, 'same');
format some_date next: date9.;
run;
title1' Advancing Dates';
proc print data=work.Have noobs; run;
title1;

