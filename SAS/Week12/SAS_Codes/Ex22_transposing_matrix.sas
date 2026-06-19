*Ex22_transposing_matrix.sas;
options nocenter nodate nonumber;
proc iml;	
  m = {1 2, 3 4, 5 6};
	T_m = t(m) ;  
print m T_m;
quit;
