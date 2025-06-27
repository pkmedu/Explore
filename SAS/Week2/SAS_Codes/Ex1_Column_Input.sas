*Ex1_Column_Input.sas;
options nocenter nonumber nodate;

* No INFILE statement; 

data work.HAVE1;
 input id $ 1-3 name $ 5-16 
   
  score1 18-19 score2 21-22;

datalines;

001 Tim Dyson 74 87 

002 Sam Larson  96 82 

003 Jane Miller  91 88 

004 Bikas Das    90 87 
; 

title 'Column input style, no infile statment';

proc print data=work.HAVE1 noobs; 

run;


* FISTOBS= option on the INFILE statement; 

data work.HAVE2;
 
infile datalines firstobs=2;

 input id $ 1-3 name $ 5-16 
       
score1 18-19 score2 21-22;

datalines;

1234567890123456789012
001 
Tim Dyson    74 87 
002 
Sam Larson   96 82 
003 
Jane Miller  91 88 
004
Bikas Das    90 87 
;
 
title 'Column input style, option on infile statment';

proc print data=work.HAVE2 noobs;
 
run;

