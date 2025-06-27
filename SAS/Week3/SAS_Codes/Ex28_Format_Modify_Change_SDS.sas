proc format;
  value xfmt 1='STAT' 2='ECON' 3='MATH';
run;
data a;
  *format x xfmt.;
  do i=1 to 25;
    x=1+int(3*ranuni(23409));
	x2 = put(x, xfmt.);
    output;
  end;
  drop i;
run;
proc print data=a;run;
proc freq data=a;
run;
proc contents data=a ;
ods select variables;
run;


/*Within PROC DATASETS, remove all the labels and formats using the MODIFY statement
 and the ATTRIB option. 
Use the CONTENTS statement within PROC DATASETS to view the contents of the data set 
without the labels and format.
*/
proc datasets lib=work memtype=data;
     modify a;
     attrib _all_ format=;
contents data=a;
run;
quit;

proc datasets lib=work memtype=data;
     change a = b ;
  contents data=b;
run;
quit;





