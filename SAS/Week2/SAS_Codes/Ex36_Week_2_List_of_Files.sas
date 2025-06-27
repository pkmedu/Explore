** Ex36_Week_2_List_of_Files.sas;
PROC IML;
SUBMIT / R;
setwd ("C:/SASCourse/Week2/SAS_Codes")
list.files(pattern="SAS", 
           full.names = TRUE, 
           ignore.case = TRUE)
ENDSUBMIT;
QUIT;

