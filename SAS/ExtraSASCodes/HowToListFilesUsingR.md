
* Topic: How to file names  
* Written by Pradip Muhuri
* Use the program at your own risk (no warranties).

```sas
PROC IML;
   SUBMIT / R;
   setwd ("C:/Data/zipfiles")
   list.files (path = "C:/Data/zipfiles")
   list.files (path = "C:/Data/xptfiles")
   list.files (path = "C:/Data/cptfiles")
   list.files (path = "C:/Data/MySDS")
ENDSUBMIT;
QUIT;
```
```sas
title; 
PROC IML;
   SUBMIT / R;
   setwd ("C:/SASCourse/Week10")
   list.files(pattern="SAS*", full.names = TRUE, ignore.case = TRUE) 
ENDSUBMIT;
QUIT;
```
