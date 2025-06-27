*Ex19_List_Files_Data_Step;
ods html close;
Filename filelist pipe "dir /b /s c:\SASCourse\Week1\SAS_Codes\*.sas";  
   Data Listfiles;         
    Length very_last_word $8;
     Infile filelist truncover;
     Input filename $100.;
     very_last_word=scan(filename, -1);
     
     * Last words from the reverse direction delimited by a slash;
     File_name=substr(scan(filename, -1, '\'),1);
     Run;

proc sort data=Listfiles; by File_name; run;
ods listing;
proc print data=Listfiles;
var  File_name;
where very_last_word eq 'sas';
run;
/*
proc contents data=Listfiles p;
ods select variables;
run;
*/
