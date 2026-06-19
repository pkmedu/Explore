*Ex2_matrix_addition.sas;
ods graphics off; 
options nodate nonumber;
proc iml;
M1 = {1 2 3,4 5 6, 7 8 9};  *3 X 3 matrix ;
	M2 = {7 8 9, 4 5 6, 1 2 3};  *3 X 3 matrix;
    M1_M2_Addition = M1+M2; *Matrix addition;
	print M1 M2; print M1_M2_Addition;
quit;
