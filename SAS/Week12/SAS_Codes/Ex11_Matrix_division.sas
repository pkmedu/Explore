*Ex11_Matrix_division;
options nocenter nodate nonumber;
proc iml;
	M1 = {18 28 38, 40 50 60, 70 80 90}; 
    M2 = {3 2 4, 4 5 6, 7 1 5}; 
    M1_M2_Div=M1/M2;
	print M1 M2 M1_M2_Div;
quit;


