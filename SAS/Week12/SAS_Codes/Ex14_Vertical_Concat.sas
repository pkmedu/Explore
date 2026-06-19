*Ex14_Vertical_Concat.sas;
ods graphics off; 
options nodate nonumber;
proc iml;
	M1 = {1 2 3,4 5 6, 7 8 9} ;  
	M2 = {7 8 9, 4 5 6, 1 2 3};  
	V_concat= M1 // M2;  
	print M1 M2 V_concat;	
quit;
