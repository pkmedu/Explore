*Ex30_create_indicator_vars.sas;
/*The goal is to make indicator variables if the 
  second and the third digits of the character variable (nit)
  are of a particular set.
  https://communities.sas.com/t5/SAS-Programming/If-in-do-loop-or-macro-in-data-step/m-p/477584/highlight/true#M123024
  Author: novinosrin
*/
data have;
input id	nit $;
cards;
234	a019
453	b033
457	c101
;

data want;
set have;
array t(*) _01-_10;
do _n_=1 to dim(t);
t(_n_)= substr(vname(t(_n_)),2,2)=substr(nit,2,2) ;
end;
run;
proc print data=want; run;
