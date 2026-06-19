/*
https://communities.sas.com/t5/SAS-Data-Management/Splitting-variables-based-on-variable-values/m-p/511956#M15903
Splitting data based on the values of the variables:  Author: novinosrin
*/
*Ex33_Split_data_based_on_values.sas;
data work.have;
format date date9.;
infile cards;
if mod(_n_,2) ne 0 then input Information $;
else input date;
cards;
X1
13005
G8
15006
;
proc print data=work.have noobs;
run;
