*Ex13_length_lengthc.sas;
options nocenter nonumber nodate;
data HAVE;
blank= ' ';
lengthc_of_dot=LENGTHC(dot);
length_of_dot=LENGTH(dot);

dot=.;
lengthc_of_blank=LENGTHC(blank);
length_of_blank=LENGTH(blank);
run;
title1 'Ex13_length_lengthc.sas';
proc print data=have; run;

proc contents data=have varnum;
ods select position;
run;
title1;

