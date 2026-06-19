%put SAS Version: &SYSVLONG4;
%put Host Info:   &SYSHOSTINFOLONG;

%put Site ------> &SYSSITE;
%put Release ---> &SYSVER (&SYSVLONG);
%put System ----> &SYSSCP (&SYSSCPL);
%put Bitness ---> &SYSADDRBITS;
%put SAS Mode --> &SYSPROCESSNAME ;
%put Host ------> &SYSTCPIPHOSTNAME ;
%put Host Info ------> &SYSHOSTINFOLONG;

proc options option=SASUSER;
run;

proc options option=CONFIG value;
run;

proc options option=ENCODING value;
run;

proc options option=MEMSIZE value;
run;

%put _AUTOMATIC_;
