
### Remove all labels and formats using the MODIFY statement and the ATTRIB option within PROC DATASETS

```SAS
proc datasets lib=work memtype=data;
     modify a;
     attrib _all_ format=;
contents data=a;
run;
quit;
```

### Delete all SAS data sets from multiple libraries using the KILL option with PROC DATASETS

```SAS
libname new ('C:\Data\Zip_folder' 'C:\Data\Xpt_folder' 
             'C:\Data\Cpt_folder' 'C:\Data\SDS_folder');
proc datasets nolist library=new kill;
quit;
```
### Delete selected SAS data sets from the WORK library
```SAS
proc datasets nolist lib=work;
 delete a1 a2 a3 ;
quit;
```
