

* Topic: How to locate a folder (SAS Library) 
* Written by Pradip Muhuri
* Use the program at your own risk (no warranties).

```sas
 %put %sysfunc(pathname(SASUSER));
 %put %sysfunc(pathname(OneDrive));
 %put %sysfunc(pathname(OneDrive\HomeDrive));
 %put %sysfunc(pathname(HomeDrive));
 %put %sysfunc(pathname(HomeDrive2));
```
