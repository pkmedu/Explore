* Ex29_Week_3_List_of_Files.sas;
PROC IML;
SUBMIT / R;
setwd ("C:/SASCourse/Week3")
list.files(pattern="SAS", 
           full.names = TRUE, 
           ignore.case = TRUE)
ENDSUBMIT;
QUIT;

