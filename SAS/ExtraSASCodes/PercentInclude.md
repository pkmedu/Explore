[%INCLUDE instead of repetative code](https://communities.sas.com/t5/SAS-Programming/Using-a-Macro-instead-of-repetitive-If-then-statements/m-p/897080#M354497)

```sas
filename snippet temp;
data _null_;
  file snippet;
  input;
  put _infile_;
  datalines4;
if name='Alfred' then found=1;
else found=0;
;;;;

data demo;
  set sashelp.class;
  %include snippet/source2;
run;
```
