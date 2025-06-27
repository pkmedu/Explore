*Ex18_Week_9_List_of_Files.sas;
PROC IML;
SUBMIT / R;
setwd ("C:/SASCourse/Week9")
list.files(pattern="SAS", full.names = TRUE, ignore.case = TRUE) 
ENDSUBMIT;
QUIT;
