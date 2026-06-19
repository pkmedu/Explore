*Ex8_Global_Local.sas;
*Code Adapted from Carpenter (2016);
option symbolgen;
%LET Year_outside = 2005;

%macro one;
 %global Year_inside_one;
 %LET Year_inside_one = 2006;
 %PUT &Year_inside_one;
%mend one;

%macro two;
 %LET Year_inside_two = 2007;
 %PUT &Year_inside_two;
%mend two;

%macro last;
  %one
  %two
  %put &Year_outside &Year_inside_one; 
%mend last;
%last
