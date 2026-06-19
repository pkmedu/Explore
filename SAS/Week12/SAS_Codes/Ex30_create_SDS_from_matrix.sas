*Ex30_create_SDS_from_matrix.sas;
proc iml;
a = {11 22 33,
     44 55 66,
     77 88 99,
     33 22 21 }; 
create data_from_matrix 
   from a[colname={"Test1" "Test2" "Test3"}];
append from a;
print a; 
list all;
close data_from_matrix; 
quit;

