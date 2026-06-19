
*Ex10_creating_folders.sas;

*Creating folders using DATA step Code;
%LET RootPath=C:\; 
Data _Null_;
SubDIR='TeachingSAS';
FolderName=DCREATE(SubDIR,"&RootPath");
Put FolderName=;
Run;



*** Creating folders using %LET and %SYSFUNC functions;
%LET RootPath=C:\TeachingSAS; 
%LET Folder1=%SYSFUNC(DCREATE(Lecture1,&RootPath)); 
%LET Folder2=%SYSFUNC(DCREATE(Lecture2,&RootPath));
%PUT &=Folder1; 
%PUT &=Folder2;
