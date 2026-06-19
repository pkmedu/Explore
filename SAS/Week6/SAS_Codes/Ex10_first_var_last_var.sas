*Ex10_first_var_last_var.sas (Part 1);
options nodate nocenter nonumber; 
DATA work.Have;
INPUT ID $ calorie_intake;
 DATALINES;
 A 200
 A 800
 A 500
 C 250
 C 850
 C 550
 B 300
 B 900
 B 600
 D 260
 D 900
 D 800
;
PROC SORT data=work.Have 
   out=work.Sorted_have; 
 BY ID; 
run;

*Ex10_first_var_last_var.sas (Part 2);
DATA _NULL_;
 SET work.sorted_have; BY ID; 
 PUTLOG ID= First.ID=  LAST.ID= calorie_intake=;
run;

*Ex10_first_var_last_var.sas (Part 3);
options nodate nocenter nonumber; 
Data _Null_;
 SET work.sorted_have; 
  BY ID;
  file 'C:\SASCourse\Week6\BY_VAR.txt'; 
  if _n_=1 then  put @10 "ID" +3 "Total_intake";
  if first.id=1 then total_intake=0; 
    total_intake+calorie_intake;
  if last.id then do;
     put @11 id +6 total_intake;
     putlog @11 id +6 total_intake;
  end;
run;

