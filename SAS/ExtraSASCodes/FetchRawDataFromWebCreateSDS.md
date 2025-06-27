

```sas
dm "log; clear; output; clear; odsresults; clear;";
filename geodata 'c:\Data\geodata.txt';
proc http
 url="https://raw.githubusercontent.com/scpike/us-state-county-zip/master/geo-data.csv"
 method="GET"
 out=geodata;
run;

data WORK.GEODATA    ;
infile GEODATA delimiter = ',' MISSOVER DSD lrecl=32767 firstobs=2 ;
         informat state_fips best32. ;
         informat state $7. ;
         informat state_abbr $2. ;
         informat zipcode $char5. ;
         informat county $10. ;
         informat city $12. ;
         format state_fips best12. ;
         format state $7. ;
         format state_abbr $2. ;
         format zipcode $char5. ;
         format county $10. ;
         format city $12. ;
      input
                  state_fips
                  state  $
                  state_abbr  $
                  zipcode 
                  county  $
                  city;


proc print data=work.geodata (obs=10);
run;
```
