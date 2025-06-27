*Ex17_Create_identity_matrix.sas;
options nocenter nodate nonumber;
proc iml;
    I_mat=I(5);   *5x5 identity matrix;
	print i_mat;
quit;
