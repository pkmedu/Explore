
libname mydata 'C:\Explore\BDMDataTables\SASData';
proc print data=mydata.EMB_2025;
where district in ('Unknown', 'UNKNOWN');
run;
