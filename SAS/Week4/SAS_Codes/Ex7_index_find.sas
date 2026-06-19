* Ex7_index_find.sas;
* Contributed by Nat Wooding and data_null to SAS-L;

 Data Conditions;
input @1 Condition $22.;
datalines;
heart failure 
early heart failure
failure of the heart
;
data Have;
	set Conditions;	

	if index(UPCASE(Condition), "HEART FAILURE") gt 0 then HF1 = 1; 
       else HF1 =0;

	HF2 = ( INDEX(UPCASE(Condition), "HEART FAILURE") gt 0 ) ;

	HF3 = find(Condition,'heart failure','I') gt 0; 
run;
proc print data=Have noobs; run;

