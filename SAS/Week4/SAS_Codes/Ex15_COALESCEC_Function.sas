*Ex15_COALESCEC_Function.sas (Part 1);
options nocenter nonumber nodate nosource;

data have;
 infile datalines DSD;
 input var1:$10. var2 :$6. var3  :$8.;
datalines;
 Ages 18-49,,
 Ages 50-64,,
 Ages 65+,,
 ,Male,
 ,Female,
 ,,Hispanic
 ,,Black
 ,,White
;
 data want;
   set have;
   array var[3] $;
   Final_var = coalescec(of var[*]);
  run;
proc print data=want; run;

/* See Messinio, Martha. 2017. Practical Guide and Efficient SAS(R) Programming: The Insider's Guide. 
Cary, NC: SAS Institute Inc.
The following is the exact quote from the above source.
Page 11: "If you are coalescing character values in a DATA step, you must use the 
COALESCEC() function; the COALESCE() function is only for numeric values.
However, you can use COALESCE() for either numeric or character values."
*/

/*Create a data set for COALESCE() with PROC SQL below.*/
*Ex15_COALESCEC_Function.sas (Part 2);
data Have;
input score1 score2;
datalines;
 . 15  
 .  . 
 17 13
 14  . 
 .  20
 14 19
;
run; 


proc sql; 
title 'Coalesce() replaces column values';
select Monotonic() as obs, 
      score1, 
      coalesce(score1, 0) as _score1,
	  case when score1=. then 0 else score1 end as score1x
      from Have;
title 'Coalesce() combines column values';
 select	  Monotonic() as obs,  score1, score2,
	      coalesce(score1, score2) as combined_score
          from Have;
quit;


