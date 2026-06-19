*Ex13_Horizontal_Concat.sas;
options nodate nonumber;
proc iml;
	M1 = {1 2 3,4 5 6, 7 8 9} ;  
	M2 = {7 8 9, 4 5 6, 1 2 3} ;  
	H_concat= M1 || M2;  
	print M1 M2 H_concat;	
quit;
