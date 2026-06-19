*** Ex1_Stat4197_Percentage_Weighted_Score.sas;
DM "log; clear; output; clear; odsresults; clear;";
data Have;
input id $ TEST1-TEST5 ASSIGNMENT1 MIDTERM FINAL;
infile datalines missover;
datalines;
X1 55	55	100	80 100	100	80 52
;
proc print data=have; run;
data have2;
 set have;
     call sortN(test5, test4, test3, test2, test1); 
	 array raw[7] TEST1-TEST4 ASSIGNMENT1  MIDTERM FINAL; 
     array weight[7] _temporary_ (.05, .05, .05, .05 
				                   ,.10,.35,.35);
	 array wp[7]  P_TEST1-P_TEST4 P_ASSIGNMENT1 
               P_MIDTERM P_FINAL; 
     do i = 1 to 7;
       wp[i] = raw[i]*weight[i];
     end;
      wpt=sum(OF P:);
 drop i;
 run;
proc print data=work.have2 noobs; 
var id test: P_: wpt; 
Format wpt 6.2;
run;
