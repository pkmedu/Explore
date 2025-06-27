*** Ex28_List_File_Names.sas (Part 1);
* List file names from a folder - Variant 1;
PROC IML;
SUBMIT / R;
setwd ("C:/SASCourse/Week4")
list.files(pattern="^", full.names = TRUE, ignore.case = TRUE) 
ENDSUBMIT;
QUIT;

*** Ex28_List_File_Names.sas (Part 2);
* List file names from a folder - Variant 2;
PROC IML;
SUBMIT / R;
setwd ("C:/SASCourse/Week4")
list.files(pattern="SAS", full.names = TRUE, ignore.case = TRUE) 
list.files(pattern="txt", full.names = TRUE, ignore.case = TRUE) 
ENDSUBMIT;
QUIT;

*** Ex28_List_File_Names.sas (Part 3);
* List file names from a folder - Variant 3;
PROC IML;
SUBMIT / R;
list.files (path = "C:/SASCourse/Week4")
ENDSUBMIT;
QUIT;
