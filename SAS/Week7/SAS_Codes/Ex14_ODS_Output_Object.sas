*Ex14_Find_ODS_Output_Object.sas;
ods trace on / listing;
proc contents data=sashelp.class; 
run; 
ods trace off;
