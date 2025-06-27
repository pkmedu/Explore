data _null_;
infile 'C:\Users\pmuhuri\SASCourse\Week4\SAS_Codes\Ex4_CATX_IFC.sas';
file 'C:\Data\CATX_IFC.sas';
input;
put _infile_;
run;
