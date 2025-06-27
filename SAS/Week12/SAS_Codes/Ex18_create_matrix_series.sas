*Ex18_create_matrix_series.sas;
options nocenter nodate nonumber;
proc iml;
 /*... arithmetic series with some increment*/
series= do(5,50,10); 
print series;
quit;   
