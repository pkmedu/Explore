*Ex16_Create_matrices_op_func.sas;
options nocenter nodate nonumber;
proc iml;
    rv=1:3; *create a row vector;
	cv=t(1:3); *create a column vector;
	reverse_rv= 3:1; *create a row vector;
	Char_vec  = 'Day1': 'Day7';   *character vector;
	print rv cv reverse_rv Char_vec;
quit;
