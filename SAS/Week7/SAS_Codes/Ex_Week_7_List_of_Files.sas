
*** Ex_Week_7_List_of_Files.sas;
PROC IML;
SUBMIT / R;
setwd ("C:/SASCourse/Week7")
list.files(pattern="SAS", full.names = TRUE, ignore.case = TRUE) 
ENDSUBMIT;
QUIT;
