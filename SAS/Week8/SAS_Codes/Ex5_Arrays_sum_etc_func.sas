
proc print data=sashelp.applianc;
run;

data have (drop=units:);
  set sashelp.applianc;
  array units_[24] ;
  do i = 1 to 24;
    F_sum_value = sum(OF units_[*]);
	F_max_value = max(OF units_[*]);
	F_min_value = min(OF units_[*]);
	F_mean_value = mean(OF units_[*]);

  end;
 run;
 proc freq data=have;
     tables F_:/missing;
 run;
