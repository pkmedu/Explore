

/*Storing a Matrix into the Default Library
 The STORE statement saves the matrix MYMAT to storage 
 in the defaults library work.
*/
*Ex34_store_load_save_mat.sas (Part 1);
PROC IML;
  USE sashelp.class;
  READ all var _num_ INTO Mymat; 
  store Mymat;                        
  CLOSE sashelp.class;
QUIT;
/*
Loading and Printing the Matrix from the Default Library
The LOAD statement recalls entry from back into IML workplace
from storage.
The PRINT statement prints the matrix MYMAT.
*/
*Ex34_store_load_save_mat.sas (Part 2);
PROC IML;
 LOAD Mymat;
 PRINT Mymat;
 QUIT;

/*
Saving Matrices (or Modules) Permanently
The RESET statement with DEFLIB = operand is used to 
specify the library name.
The RESET STORAGE statement is used to specify both 
 library reference and catalog.
The STORE statement saves the matrix MYMAT2 in the 
 catalog named CAT1 in the IMLIN library.
*/
*Ex34_store_load_save_mat.sas (Part 3);
libname imlin "C:/SASCourse/Week12";
PROC IML;
reset deflib=imlin;
  USE sashelp.class;
  READ all var _num_ INTO Mymat2; 
  reset storage=imlin.cat1;
  store Mymat2;
  show storage;
  CLOSE sashelp.class;
QUIT;


/*RESET and LOAD statements -
The RESET statement with DEFLIB = operand is used to 
specify the library name.

The RESET STORAGE statement is used to specify both
  library reference and catalog.

The LOAD statement recalls the matrix MYMAT2 that was 
earlier saved permanently in the catalog named CAT1 
in the IMLIN library.
*/
*Ex34_store_load_save_mat.sas (Part 4);
libname xmlin "C:/SASCourse/Week12";
PROC IML;
 RESET deflib=imlin;
 RESET STORAGE=imlin.cat1;
 LOAD Mymat2;
 PRINT Mymat2;
 QUIT;
