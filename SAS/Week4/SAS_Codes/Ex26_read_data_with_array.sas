*Ex26_read_data_with_array.sas;
/*
Contributed by Haikuo (SAS-L)- 04/04/2012;
'input @@' will let you keep reading until the end of 
the file, which can be considered as just one line 
if number of your variables are equal or more than 
the number of the data elements in your raw flat file.
*/
data work.grid (drop=i j);
infile "C:\SASCourse\Week4\grid.txt";
file "C:\SASCourse\Week4\xgrid.txt";
array a{20,20};
do i = 1 to 20;
   do j=1 to 20;
     input a[i,j] @@;
  end;
end;
put @10 (a1-a400) (+1);
run;
*** This part has been added ;
proc transpose data=work.grid 
   out=work.t_grid;
run;
proc print data=work.t_grid;
run;
