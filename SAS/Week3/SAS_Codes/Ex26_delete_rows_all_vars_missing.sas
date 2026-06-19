*Ex26_delete_rows_all_vars_missing (Part 1);
data have1;
  set sashelp.class(obs=7);
  if mod(_n_,3)=0 then call missing(of _all_);
run;
title1 'Data Set Have1'; 
proc print data=have1; run;

*Ex26_delete_rows_all_vars_missing (Part 2);
data have2;
set have1;
  if cmiss(of _all_) >0 then delete;
run;
title1 'Data Set Have2'; 
proc print data=have2; run;

*Ex26_delete_rows_all_vars_missing (Part 3);
*Posted by Quentin McMullen to SAS=L 9/25/2018;
data have3;
set have1;
if compress(cats(of _all_),'.')=' ' then delete;
run;
title1 'Data Set Have3'; 
proc print data=have3; run;

