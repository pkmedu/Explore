dm "log; clear;";

%let RootPath = C:\Users\Public;
%let FolderName = %nrstr(Research&Development);

%let FolderCreated = %sysfunc(dcreate(&FolderName, &RootPath));
%put FolderCreated=&FolderCreated;

%let FolderPath = &RootPath.\%superq(FolderName);
%let FilePath = &FolderPath.\Report(100%%).txt;

filename myfile "&FilePath";

data _null_;
    file myfile;
    put "File written successfully";
run;
