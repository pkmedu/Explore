*Ex29_Multiple_Input_Statements.sas;

data work.HAVE(drop=i);
 input date: Anydtdte9. @;
 do i = 1 to 4;
 input name $ hours_studied @;
 label date= 'Date'
       name = "Student's name"
       hours_studied = 'Hours studied*for STAT 4197/6197';
 output;
 end;
datalines;
27Aug2018 Doris 5.5 Alice 4.0 Mike 2.0 James 1.0
28Jun2018 Doris 3.0 Alice 3.0 Mike 3.0 James 1.0
;
proc sort data=work.HAVE; by name; run;
proc print data=work.HAVE noobs split='*';
by name;
Format date worddate.;
run;

