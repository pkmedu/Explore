*Ex4_Matrix_Elwise_Multi.sas;
options nocenter nodate nonumber;
proc iml;
	M1 = {1 2 3,4 5 6, 7 8 9} ;  *3 X 3 matrix; 
	M2 = {7 8 9, 4 5 6, 1 2 3} ;  *3 X 3 matrix ;
	M1_M2_E_Times= M1#M2; *Elemetwise multplication;
	print M1 M2 ;
    print M1_M2_E_Times;
quit;
