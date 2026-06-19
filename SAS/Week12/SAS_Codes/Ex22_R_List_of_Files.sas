*Ex22_R_List_of_Files.sas;
title; title1; title2;
PROC IML;
SUBMIT / R;
setwd ("C:/SASCourse/Week14")
list.files(pattern="SAS*", full.names = TRUE, ignore.case = TRUE) 
ENDSUBMIT;
QUIT;
