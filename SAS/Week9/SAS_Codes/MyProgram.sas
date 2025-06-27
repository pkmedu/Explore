*MyProgram.sas;
%LET Path= C:\SASCourse;
Libname New "&Path";
%macro Mymacro;
  %global xtract;
  %let xtract= %qsubstr(%sysget(SAS_EXECFILENAME),1,
               %length(%sysget(SAS_EXECFILENAME))-4);
%put %sysget(SAS_EXECFILENAME);
%put %length(%sysget(SAS_EXECFILENAME));
%mend Mymacro;
%Mymacro









 
