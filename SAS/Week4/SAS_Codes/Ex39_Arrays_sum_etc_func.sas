/*
proc print data=sashelp.applianc;
run;
*/
data have;
  set sashelp.applianc;
  array units_[29] ;
  do i = 1 to 29;
    sum_value1 = sum(OF units_[i]);
    sum_value2 = sum(OF units_[*]);

	max_value1 = max(OF units_[i]);
	max_value2 = max(OF units_[*]);

	min_value1 = min(OF units_[i]);
	min_value2 = min(OF units_[*]);

	mean_value1 = mean(OF units_[i]);
	mean_value2 = mean(OF units_[*]);

  end;
 run;
 proc freq data=have;
     tables sum_value1*sum_value2 
            max_value1*max_value2
            min_value1*min_value2
            mean_value1*mean_value2/ list missing;
 run;
