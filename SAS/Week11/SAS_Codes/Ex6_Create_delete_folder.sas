



**** Create a folder called Data using a DATA Step;
%LET RootPath=C:\; 
Data _Null_;
Folder='Data';
FolderName=DCREATE(Folder,"&RootPath");
Put FolderName=;
Run;

*** Delete an existing folder;
%let TargetFolder=c:\Data;
FILENAME FMyRep "&TargetFolder";
%LET rc=%SYSFUNC(FDELETE(FMyRep));
%PUT rc=&rc;
FILENAME FMyRep CLEAR;



**** Create a folder called Data using %SYSFUNC and the
     DCREATE function in open code;
%LET RootPath=C:\;
%LET Folder=%SYSFUNC(DCREATE(Data,&RootPath)); 
%PUT Folder=&Folder;

options symbolgen mprint;
%LET Folder=c:\Data;
%let sub_folders = zipfiles xptfiles cptfiles MySDS MEPS;
%put &=Folder;
%put &=Sub_folders;

%MACRO cf;
%DO i= 1 %to 5;
     %let rc=%SYSFUNC(DCREATE(%scan(&sub_folders, &i),&Folder));
 %END; 
%MEND cf;
%cf
