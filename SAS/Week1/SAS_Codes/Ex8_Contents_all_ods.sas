*** SAS/STAT® 13.1 User’s Guide Sashelp Data Sets
*** This program lists all the data sets 
that are available in Sashelp library;
ods select none;
proc contents data=sashelp._all_;
ods output members=m;
run;
ods select all;
proc print data=m noobs;
where memtype = 'DATA';
run;
