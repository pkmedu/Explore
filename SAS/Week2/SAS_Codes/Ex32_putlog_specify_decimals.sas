*Ex32_putlog_specify_decimals.sas;
data _null_;
set sashelp.class;
putlog name 1-8 sex 9 age 10-15 weight 16-22 1 height 23-30 2;
run;


