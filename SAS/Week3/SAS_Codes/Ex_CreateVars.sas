
data _null_;
 text = "202501_Fundamentals of SAS Programming for Data Management_STAT_4197_80 (24988_202501)";
 value_length = length(text);
 put value_length= ;
run;

options validvarname=any;
libname XL XLSX 'C:\Users\pmuhuri\SASCourse\Week3\SAS_Codes\CourseRosterData.xlsx';
data work.Enrollment;
  set XL.Sheet1;
run;
libname XL CLEAR; 
proc print data=work.Enrollment (obs=5); 
run;
