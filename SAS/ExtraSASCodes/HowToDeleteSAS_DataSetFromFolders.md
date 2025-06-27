
Delete all SAS data sets from multiple libraries using the KILL option
with PROC DATASETS

```sas
libname new ('C:\Data\Zip_folder' 'C:\Data\Xpt_folder' 
             'C:\Data\Cpt_folder' 'C:\Data\SDS_folder');
proc datasets nolist library=new kill;
quit;
```

Delete selected SAS data sets from the WORK library
```sas
proc datasets nolist lib=work;
 delete a1 a2 a3 ;
quit;
```