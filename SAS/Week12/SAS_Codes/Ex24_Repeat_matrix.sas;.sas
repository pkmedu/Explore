*Ex24_Repeat_matrix.sas;
options nocenter nodate nonumber;
proc iml;
	X={1 2, 0 4}; 
   	repeat_x22= repeat(X, 3, 2);
print X repeat_x22;
quit;
