
[5 digit zip code - by Haikuo Onyx](https://communities.sas.com/t5/SAS-Data-Management/5-digit-zip-code/td-p/228911)

```sas
data test;
   infile cards truncover;
   input zip $10.;
   zip=ifc(prxmatch('/^\d{5}$/',strip(zip))>0, zip, '');
datalines;
asdhg
78659
0987689
89ui
26543
u
.
;
proc print;
run;
```

[5 digit zip code by Patrick OPAL](https://communities.sas.com/t5/SAS-Data-Management/5-digit-zip-code/td-p/228911)

```sas
data test;
   infile cards truncover;
   input zip $10.;
   length new_zip1 new_zip2 $5;
   new_zip=ifc(prxmatch('/^\d{5}$/',strip(zip))>0, zip, '');
   if lengthn(zip)=5 and notdigit(strip(zip))=0 then new_zip1=zip;
   if prxmatch('/^\d{5} *$/',zip)>0 then new_zip2=zip;
datalines;
asdhg
78659
0987689
89ui
26543
u
.
;
proc print;
run;
```
