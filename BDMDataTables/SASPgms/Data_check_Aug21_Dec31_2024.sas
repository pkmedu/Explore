
libname mydata 'C:\Explore\BDMDataTables\SASData';
proc print data=mydata.EMB_Aug21_Dec31_2024;
where district in ('Unknown', 'UNKNOWN');
run;
