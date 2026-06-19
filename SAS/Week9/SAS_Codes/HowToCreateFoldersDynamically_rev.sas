

/*https://www.lexjansen.com/phuse/2013/cs/CS02_ppt.pdf*/
/* The Great Outdoors */
/*** Code Chunk 1 - DATA Step: Creating a folder, 
if not already created; */
%LET RootPath=C:\; 
Data _Null_;
SubDIR='LearnPython';
FolderName=DCREATE(SubDIR,"&RootPath");
Put FolderName=;
Run;

/*** Code Chunk 2 - %SYSFUNC Macro Function: Creating a folder, 
if not already created */

%LET RootPath=c:\;
*Macro Function;
%LET Folder=%SYSFUNC(DCREATE(TeachingSAS,&RootPath)); 
%PUT Folder=&Folder;

/* Code Chunk 3 - %SYSFUNC Macro Function in a Macro: 
Creating multiple folders, if not already created*/

options nosymbolgen nomlogic nomprint;
%LET RootPath=c:\;
%MACRO CF (start, stop);
  %DO num= &start %to &stop;
     %LET Folder1=%SYSFUNC(DCREATE(Task&num,&RootPath));
  %END; 
%MEND CF;
%CF(1,15)

/*** Code Chunk 4 - %SYSFUNC Macro Function Deleting a folder, 
if existing;*/

%let TargetPath=c:\TeachingSAS;
FILENAME FMyRep "&TargetPath";
%LET rc=%SYSFUNC(FDELETE(FMyRep));
%PUT rc=&rc;
FILENAME FMyRep CLEAR;

%let TargetPath=c:\LearnPython;
FILENAME FMyRep "&TargetPath";
%LET rc=%SYSFUNC(FDELETE(FMyRep));
%PUT rc=&rc;
FILENAME FMyRep CLEAR;

/*** Code Chunk 5 %SYSFUNC Macro Function in a Macro: 
Deleting multiple folders, if existing */
options nosymbolgen nomlogic nomprint;
%LET RootPath=c:\;
%MACRO CF (start, stop);
  %DO num= &start %to &stop;
    %let TargetPath=c:\Task&num;
     FILENAME FMyRep "&TargetPath";
     %LET rc=%SYSFUNC(FDELETE(FMyRep));
     %PUT rc=&rc;
     FILENAME FMyRep CLEAR;
  %END; 
%MEND CF;
%CF(1,15)

