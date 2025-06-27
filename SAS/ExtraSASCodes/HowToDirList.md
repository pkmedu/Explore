
Topic: How to create folders dynamically (Various)
Written by Pradip Muhuri
Acknowledgements: Online Sources
Use the program at your own risk (no warranties).

```SAS
%LET RootPath=c:\mydata;
%LET Folder=%SYSFUNC(DCREATE(MyNewFolder,&RootPath)); * separator unnecessary;
%PUT Folder=&Folder;
%LET RootPath=C:\; 
Data _Null_;
SubDIR='TeachingSAS';
FolderName=DCREATE(SubDIR,"&RootPath");
Put FolderName=;
Run;
%LET Folder=%SYSFUNC(DCREATE(MacroFolder,&RootPath)); 
%PUT Folder=&Folder;

%LET RootPath=c:\SASCourse;
%MACRO CF (start, stop);
  %DO num= &start %to &stop;
     %LET Folder1=%SYSFUNC(DCREATE(Week&num,&RootPath));
  %END; 
%MEND CF;
%CF(1,15)
%let TargetPath=c:\data\temp\Folder;
FILENAME FMyRep "&TargetPath";
%LET rc=%SYSFUNC(FDELETE(FMyRep));
%PUT rc=&rc;
FILENAME FMyRep CLEAR;
```
 [Turning external files into SAS® data sets: common problems and their solutions](https://blogs.sas.com/content/sgf/2021/02/18/turning-text-files-into-sas-data-sets-6-common-problems-and-their-solutions/)
 
The TRUNCOVER option indicates that the program should not flow over to the next line to look for missing values that are not found on the current line being read.
 
```sas
Filename filelist pipe "dir /b /s c:\SASCourse\Week1\*.sas";  
   Data Listfiles;         
    Length very_last_word $8;
     Infile filelist truncover;
     Input filename $100.;
     very_last_word=scan(filename, -1);
     
     * Last words from the reverse direction delimited by a slash;
     File_name=substr(scan(filename, -1, '\'),1);
     Run; 
proc sort data=Listfiles; by File_name; run;
proc print data=Listfiles;
var  File_name;
where very_last_word eq 'sas';
run;
```
[Sample 45805: List all files within a directory including sub-directories](https://support.sas.com/kb/45/805.html)

The following SAS program uses the PIPE device-type keyword to send the ps (process) command output to an SAS DATA step. The resulting SAS data set contains data about every process currently running SAS:
```sas
Filename filelist pipe "dir /b /s c:\temp\*.sas"; 
                                                                                 
   Data _null_;                                        
     Infile filelist truncover;
     Input filename $100.;
     Put filename=;
   Run; 
```
```sas
* List file names from a folder - Variant 1;
PROC IML;
SUBMIT / R;
setwd ("C:/SASCourse/Week4")
list.files(pattern="^", full.names = TRUE, ignore.case = TRUE) 
ENDSUBMIT;
QUIT;
```
```sas
* List file names from a folder - Variant 2;
PROC IML;
SUBMIT / R;
setwd ("C:/SASCourse/Week4")
list.files(pattern="SAS", full.names = TRUE, ignore.case = TRUE) 
list.files(pattern="txt", full.names = TRUE, ignore.case = TRUE) 
ENDSUBMIT;
QUIT;
```
```sas
* List file names from a folder - Variant 3;
PROC IML;
SUBMIT / R;
list.files (path = "C:/SASCourse/Week4")
ENDSUBMIT;
QUIT;
```

* Topic: How to list file names (Various) 
* Written by Pradip Muhuri
* Acknowledgements: Online Sources, 
* Use the program at your own risk (no warranties).

```sas
filename DIRLIST pipe 'dir /b /s c:\Data\*.sas';
data dirlist;
length filename $200;
infile dirlist length=reclen;
input filename $varying200. reclen;
run;

proc print data=dirlist; 
var file_name;
where scan(filename, -1, '.')='sas';
run;
```
```python
import glob
path = 'C:\\Misc'
files = (f for f in glob.glob(path + '**/*.sas', recursive=True))
for f in files:
    print(f)

```
The "raw" string treats the backslash as a regular character, not an escape character. (An escape character introduces an escape sequence, like \n for the newline character.

When using a regular Python string, it's necessary to use two backslashes in the file path because the first backslash is the escape character, but backslash + backslash effectively "unescapes" the character, producing a single backslash when you print it. (per email communication with Dolsy Smith, GW Library)

There's some useful explanation in this [stackoverflow post.](https://stackoverflow.com/questions/11924706/how-to-get-rid-of-double-backslash-in-python-windows-file-path-string)

```python
import os
path = r'C:\Misc'
files = []
for r, d, f in os.walk(path):
    for file in f:
        if '.sas' in file:
            files.append(os.path.join(r, file))
            
for f in files:
    print(f)
```

#### Find the total number of observations from a SAS data set (SAS macro statements)

```sas
%let dsn=sashelp.class;
%let dsid    = %sysfunc(open(&dsn,i)) ;
%let nobs    = %sysfunc(attrn(&dsid,nlobs));
%let dsclose = %sysfunc(close(&dsid));
%put &=nobs;
```

