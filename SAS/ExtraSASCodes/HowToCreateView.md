
```sas
data Class_BMI / view=Class_BMI;                 
   set Sashelp.Class;
   BMI = weight / height**2 * 703;   
run;
 
proc means data=Class_BMI;
   var BMI;
run;
```
```sas
proc sql;
  create view Clas_BMI_V as 
  select *, 
         weight / height**2 * 703 as BMI 
  from sashelp.class;
quit;
```



