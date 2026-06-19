*Ex17_calling_R_from_SAS.sas;
PROC IML;
SUBMIT / R;
setwd ("C:/Users/Pradip Muhuri/SASResources")
list.files(pattern="^", full.names = TRUE, ignore.case = TRUE) 
ENDSUBMIT;
QUIT;
