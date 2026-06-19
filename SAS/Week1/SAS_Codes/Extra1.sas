dm "log; clear;";

options noxwait noxsync;

%let RootPath = C:\Users\Public;

/* SAFE internal name (NO &) */
%let FolderName = Research_Development;

/* create folder */
%let rc = %sysfunc(dcreate(&FolderName, &RootPath));
%put NOTE: FolderCreated=&rc;

/* build path */
%let FilePath = &RootPath.\&FolderName.\Report(100%%).txt;
%put NOTE: FilePath=&FilePath;

/* write file */
filename myfile "&FilePath";

data _null_;
    file myfile;
    put "File written successfully";
run;
