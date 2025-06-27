```sas
LIBNAME pufmeps  'C:\Data' access=readonly;
proc print data=sashelp.vcolumn label;
 var memname name type length label;
 where libname='PUFMEPS' and memname='H197G'
 and name in ('DUPERSID', 'MAMMOG' 'XRAYS', 'MRI');
run;
```

                Member    Column      Column    Column
         Obs     Name     Name         Type     Length    Column Label

           1    H197G     DUPERSID     char        8      PERSON ID (DUID + PID)
           2    H197G     XRAYS        num         8      THIS VISIT DID P HAVE X-RAYS
           3    H197G     MAMMOG       num         8      THIS VISIT DID P HAVE A MAMMOGRAM
           4    H197G     MRI          num         8      THIS VISIT DID P HAVE AN MRI/CATSCAN

```sas
LIBNAME pufmeps  'C:\Data' access=readonly;
proc print data=pufmeps.h197g (obs= 10);
 var DUPERSID XRAYS MAMMOG XRAYS;
run;

proc means data=pufmeps.h197g (obs= 10);
 var MRI MAMMOG XRAYS;
run;
```           
