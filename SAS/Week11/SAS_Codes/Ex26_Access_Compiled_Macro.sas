*Ex26_Access_Compiled_Macro;
libname Mylib  'C:\SASCourse\Week9';
options mstored sasmstore=Mylib;
proc format;
value $s_group
     'E' = 'Experimental Group'
	 'C' = 'Comparison Group';
value score
      0-9 = 'Low'
	  10-99 = 'Medium'
	  100-999='High';
run;
%put %format(E, $s_Group.);
%put %format(50, score.);
