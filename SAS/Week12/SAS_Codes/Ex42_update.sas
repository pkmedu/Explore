*Ex42_update.sas;
data master;
 input id quiz1 @@;
 datalines;
 1 12 2 18 3 13 4 9 5 7
 ;
data transact;
 input id quiz1  @@;
 datalines;
 3 17 4 12 5 13
;
data updated; 
  UPDATE master transact; 
   by ID;
run;
proc print data=updated noobs; 
run;

