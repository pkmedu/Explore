
/*The DATASETS function returns the names of all SAS data sets 
in a specified libref*/

*Ex36_DATASETS Func.sas (Part 1);
libname new 'D:\';
proc iml;
lib = "new";
A = datasets(lib);
First3 = A[1:3];
print First3;
quit;

/*CONTENTS Function in PROC IML
The CONTENTS function returns the names of all variables
in a specified data set.
Find data sets that contain the same variable name

*/
*Ex36_DATASETS Func.sas (Part 2);
proc iml;
lib = "SASHELP";          
ds = datasets(lib);      
 

do i = 1 to nrow(ds);
   varnames = upcase( contents(lib, ds[i]) ); 
   if any(varnames = "WEIGHT") then 
      print (ds[i]);
end;
quit;
 
