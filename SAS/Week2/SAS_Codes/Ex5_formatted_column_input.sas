*Ex5_formatted_column_input.sas;

* Use of absolute pointer control;
data work.apc;
infile datalines firstobs=2;
input id $1.        @3 x1 5. 
      @9 x2 dollar7.   @9 a_x2 comma7.
      @17 x3 dollarx7. @17 a_x3 commax7. 
      @25 x4 6.        @32 x5 percent7.;
format x2 dollar7.  a_x2 comma7. 
       x3 dollarx7. a_x3 commax7. 
       x5 percent7.;
;	
datalines;
1234567890123456789012345678901234
A 12909 $12,909 $12.909 12.909 12%
;
title 'Use of absolute pointer control';
proc print data=work.apc noobs; run;

data work.rpc;
infile datalines firstobs=2;
input id $1.           +1 x1 5. 
      +1 x2 dollar7.   +(-7) a_x2 comma7.
      +1 x3 dollarx7.  +(-7) a_x3 commax7. 
      +1 x4 6.         +1 x5 percent7. 
;
format x2 dollar7.  a_x2 comma7. 
       x3 dollarx7. a_x3 commax7. 
       x5 percent7.;
;	
datalines;
1234567890123456789012345678901234
A 12909 $12,909 $12.909 12.909 12%
;
title 'Use of relative pointer control';
proc print data=work.rpc noobs; run;

/* The +n (relative pointer control) moves the input pointer
forward to a column number that is relative to the current
position. (SAS Documentation)
Use +(-n) to move pointer control backwards */
