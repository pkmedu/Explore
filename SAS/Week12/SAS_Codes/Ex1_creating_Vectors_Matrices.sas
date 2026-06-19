* Ex1_creating_Vectors.sas (Part 1);
* Ex1_creating_Vectors.sas (Part 1);
proc IML;
Col_vector1 = {2, 4, 6, 8};   /** 4 X 1 matrix, column vector,
                                        evenly spaced values **/
Col_vector2 = j(4, 1, 5);     /** 4 X 1 matrix, 
                                  column vector of 5's  **/
Row_vector1 = 1:3;        /** 1 X c matrix, row vector, 
                                  increasing seq. of numbers **/
Row_vector2 = 1:-1;           /** 1 X c matrix, row vector, 
                                  decreasing seq. of numbers **/
print Col_vector1 Col_vector2 Row_vector1 Row_vector2;
quit;

* Ex1_creating_Vectors.sas (Part 2);
proc IML;
Row_vector3 = do(10, 70, 20); /** 1 X c matrix, row vector,
                                  positive increment **/
Row_vector4 = do(15, -10, -5);/** 1 X c matrix, row vector,
                                  negative increment **/
x_scalar = 5;                 /** 1 X 1 matrix, scalar **/

mat_A = {1 2 3, 4 5 6};           

print Row_vector3 Row_vector4 x_scalar  mat_A;
quit;

* Ex1_creating_Vectors.sas (Part 3);
proc iml;
      s= 2; /*scalar matrix - just one element*/
	rv = {1 2 3};  /* 1 x 3 row vector */
	cv = {1,2,3};  /* 3 X 1 column vector */
	mat = {1 2 3,4 5 6, 7 8 9} ;  /*3 X 3 matrix */
	print  s rv; print cv mat;
 quit;

