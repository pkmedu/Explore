*Ex9_Create_vars_Different_Ways.sas (part 1);
data Have1;
 length age_group $11;
 input age @@ ;
datalines;
  0 5 10 17 40 48 50 59 62 81 99 100
  ; 
title1 'Frquency Table for a Variable with Discrete (Ungrouped) Data Values (Part 1)';
title2;
proc freq data=Have1;   
 table age; 
run;

*Ex9_Create_vars_Different_Ways.sas (part 2);
proc format ;
 value agefmt low-17 = '0-17 Years'
              18-49 = '18-49 Years'
			  50-64 = '50-64 Years'
			  65-High = '65+ Years'
			  ;
data Have2;
 input age @@ ;
 datalines;
  0 5 10 17 40 48 50 59 62 81 99 100
  ; 
title1 'Frequency Table by Grouping Data Values Using Formats in PROC FREQ (Part 2)';
title2;
proc freq data=Have2; 
 table age; format age agefmt.;
run;

*Ex9_Create_vars_Different_Ways.sas (part 3);
 data Have3;
 length age_group $11;
  input age @@ ; 

  /*Character-type categorical variables using an assignment statement;
  IF-THEN/Else Statements are used to conditionally assign values to variables.*/

  if age <=17 then age_group='0-17 Years';
  else if 18<=age<=49 then age_group= '18-49 Years';
  else if 50<=age<=64 then age_group= '50-64 Years';
  else if age>=65 then age_group= '65+ Years';
  datalines;
  0 5 10 17 40 48 50 59 62 81 99 100
  ; 
 options center;
 title1 'Frequency Table for a Variable Created with an Assignment Statement';
 title2 '(IF-THEN/ELSE-IF-THEN in DATA Step - Part 3)';

proc freq data=Have3; 
 table age_group ; 
run;

 *Ex9_Create_vars_Different_Ways.sas (part 4);
 proc format ;
 value agefmt low-17 = '0-17 Years'
              18-49 = '18-49 Years'
			  50-64 = '50-64 Years'
			  65-High = '65+ Years'
			  ;
  data Have4;
  	input age @@ ; 
  	*Character-type categorical variables using a PUT function;
  	age_group_x=put(age, agefmt.);
  datalines;
  0 5 10 17 40 48 50 59 62 81 99 100
  ; 
 title1 'Frequency Table for a Variable Created with an Assignment Statement';
 title2 'and the PUT Function in DATA Step (Part 4)';
 proc freq data=Have4; 
 table age_group_x ; 
run;

 
