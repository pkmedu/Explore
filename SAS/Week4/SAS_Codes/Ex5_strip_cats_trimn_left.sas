*Ex5_strip_cats_trimn_left.sas;
*SAS Code Adapted from SAS Documentation;
data work.HAVE1;
   input string $char20.;
   original = '*' || string || '*';
   stripped = '*' || strip(string) || '*';
   cats_ed = '*' || cats(string) || '*';
   timn_left_ed = '*' || trimn(left(string)) || '*';

   datalines;
Statistics
  Statistics
    Statistics
Statistics
 Stat 4197
;
proc print data=work.HAVE1 noobs; 
run;

