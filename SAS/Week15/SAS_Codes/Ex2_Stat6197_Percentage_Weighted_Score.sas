*** Ex2_Stat6197_Percentage_Weighted_Score.sas;
data Have;
input id $ TEST1-TEST5 ASSIGNMENT1 ASSIGNMENT2  MIDTERM FINAL;
datalines;
A1 75 55 85 85 95 92 100 80 84
A2 55 45 45 60 30 68 70 48 56
;
data have2;
 set have;
     call sortN(test5, test4, test3, test2, test1); 
	 array raw[8] TEST1-TEST4 ASSIGNMENT1 ASSIGNMENT2
               MIDTERM FINAL; 
     array weight[8] _temporary_ (.05, .05, .05, .05 
				                   ,.10,.10,.30,.30);
	 array wp[8]  P_TEST1-P_TEST4 P_ASSIGNMENT1 P_ASSIGNMENT2
               P_MIDTERM P_FINAL; 
     do i = 1 to 8;
       wp[i] = raw[i]*weight[i];
     end;
      wpt=sum(OF P:);
 drop i;
 run;
proc print data=work.have2 noobs; 
var id P_: wpt; 
Format wpt 6.2;
run;
