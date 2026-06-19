/*
proc options option=rlang;
run;
%put %sysget(R_HOME);
*/
*Ex15_Week_1_List_of_Files.sas - Updated;
PROC IML;
SUBMIT / R;
setwd ("C:/SASCourse/Week1/SAS_Codes")
list.files(pattern="SAS", 
           full.names = TRUE, 
           ignore.case = TRUE)
ENDSUBMIT;
QUIT;

