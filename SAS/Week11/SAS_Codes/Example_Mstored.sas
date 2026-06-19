*Example_Mstored.sas;
%LET Path= C:\SASCourse;
Libname New "&Path";
options mstored sasmstore=New;
%macro Create_logfile / store source
         des='Create Log File';
  %global xtract;
  %let xtract= %qsubstr(%sysget(SAS_EXECFILENAME),1,
               %length(%sysget(SAS_EXECFILENAME))-4);
%mend Create_logfile;
%sysmstoreclear;








 
