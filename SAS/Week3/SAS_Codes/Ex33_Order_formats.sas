
proc format;
value $G_sexfmt 'M' = '1'
              'F' = '2';

value $N_sexfmt '1' = 'Male'
              '2' = 'Female';

value $x_sexfmt 'M' = 'Male'
              'F' = 'Female';
run;
data class;
 set sashelp.class;
 r_sex = put(put(sex, $G_sexfmt.) $N_sexfmt.);
 run;
proc freq data=class;
tables r_sex;
run; 
proc freq data=sashelp.class order=data;
tables sex ;
format sex $x_sexfmt.;
run; 
