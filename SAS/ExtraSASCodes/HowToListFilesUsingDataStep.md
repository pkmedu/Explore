
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
