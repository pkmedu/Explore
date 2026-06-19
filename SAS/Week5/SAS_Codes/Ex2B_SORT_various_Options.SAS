*Ex2B_SORT_various_Options.SAS (Part 1);
*** WHERE= Option, OUT= Keyword with PROC SORT;
Proc sort data=sashelp.class (where=(age>=15))
    out=work.students_aged_GE15;
by name;
run;
proc print data=work.students_aged_GE15;
run;

*Ex2B_SORT_various_Options.SAS (Part 2);
*** WHERE Statement in PROC SORT;
proc sort data=sashelp.class 
    out=work.students_aged_GE15_x;
where age>=15;
by name;
run;
title1 'WHERE Statement in PROC SORT';
proc print data=work.students_aged_GE15_x;
run;


*Ex2B_SORT_various_Options.SAS (Part 3);
**  KEY statement in PROC STEP;
proc sort data=sashelp.iris 
    out=work.sorted_iris;
  key PetalLength / ascending;
  key PetalWidth / descending;
run;
title1 'KEY statement in PROC STEP';
proc print data=sorted_iris 
             (obs=10) noobs;
  var species Petal: ;
run;


*Ex2B_SORT_various_Options.SAS (Part 4);
***LABEL Statement with PROC STEP;
proc sort data=sashelp.class
    out=work.class_new;
label name = "Student's*Name"
      sex  = 'Gender'
	  age  = 'Age on the Day of Interiew'
	  height = 'Height on the Day of Interiew'
      weight = 'Weight on the Day of Interiew';
by name;
run;
title1 'LABEL Statement with PROC STEP';
proc print data=work.class_new (obs=3) split='*';
run;


*Ex2B_SORT_various_Options.SAS (Part 5);
*** FORMAT Statement in PROC STEP;
proc format;
value $sex_fmt 
  'F' = 'Female'
  'M' = 'Male';
          
proc sort data=sashelp.class 
        out=work.class_rev;
FORMAT sex $sex_fmt.;
by name;
run;
title1 'FORMAT Statement in PROC STEP';
proc print data=work.class_rev (obs=3);
var name sex;
run;


*Ex2B_SORT_various_Options.SAS (Part 6);
***Keep and Rename Options in PROC SORT;
title;       
proc sort data=sashelp.class 
        out=work.class_rev2 
         (keep=name sex
	  rename=(name=Student_Name sex=Gender)
          );
by name sex;
run;
title 'Keep and Rename Options in PROC SORT';
proc print data=work.class_rev2 (obs=3);
run;
title1;






