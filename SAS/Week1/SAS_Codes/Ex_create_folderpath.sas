DM "log; clear;";

options nodate notes nosource;

/* --- Safe base path --- */
%let RootPath = C:\Users\Public;

/* --- SAFE folder name (no raw &) --- */
%let FolderName = Research_Development;

/* --- Create folder --- */
%let rc = %sysfunc(dcreate(&FolderName, &RootPath));
%put NOTE: FolderCreated=&rc;
%put NOTE: SYSMSG=%sysfunc(sysmsg());

/* --- Build full file path --- */
%let path = &RootPath.\&FolderName.\Report(100%%).txt;

%put NOTE: path=&path;

/* --- Write file --- */
filename myfile 
    put "File written successfully";
run;
