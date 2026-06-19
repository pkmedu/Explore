*Ex8_Invalue_statement.sas (Part 1);
options nocenter nonumber nodate nosource;
proc format ;
    invalue scorefmt (upcase just)
            'A'=95  'B'=84  
            'C'=79  'D'=60;
run;
data Grade_data1;
  input @1 id $4.  @6 grade scorefmt2. ;
  rename grade = score;
datalines;
S001 A 
S002 D 
S003 B 
S004 B
S005  D 
S006 C 
S007 c 
;
title 'PROC FORMAT INVALUE Invalue Statement with UPCASE and JUST Options (Part 1)';
proc print data=Grade_data1 noobs ; run;
title;
