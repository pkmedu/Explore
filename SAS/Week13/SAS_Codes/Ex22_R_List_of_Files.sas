*Ex22_R_List_of_Files.sas;
title; title1; title2;
PROC IML;
SUBMIT / R;
setwd ("C:/SASCourse/Week13/SAS_Codes")
list.files(pattern="SAS*", full.names = TRUE, ignore.case = TRUE) 
ENDSUBMIT;
QUIT;

options nodate nonumber nonotes nosource;
 ods html close;
 Filename filelist pipe "dir /b /s c:\Data\*.SAS7bdat";
 Data _null_;                                        
     Infile filelist truncover;
     Input filename $100.;
     Put filename=;
   Run; 
