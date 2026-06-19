*** Ex23_array_call_sortn.sas (Part 1);
*** Simulating Students' Scores;
options nocenter nonumber nodate;
data have(drop= i j);
retain id;
call streaminit(123);
array x[*] TEST1-TEST5 ASSIGNMENT1 ASSIGNMENT2
               MIDTERM FINAL;
do i = 1 to 12;
   do j = 1 to dim(x);
      id = cats('GW',substr(compress(uuidgen(),'-'),1,6));
      x[j] = rand("Integer", 40, 100); 
   end;   
  output;
 end;
run;
title1 'Listing from a simulated Data Set';
proc print data=HAVE noobs; run;

*** Ex23_array_call_sortn.sas (Part 2);
*** Horizon Sorting of 5 Test Variables in Descending order 
and Dropping the Testing Variable with Lowest Test Score;

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
proc sort data=work.Have2; by descending wpt; run;
options nocenter nodate nonumber;
title1 'Calculations of weighted scores';
proc print data=work.have2 noobs; 
var id P_: wpt; 
Format wpt 5.0;
run;
title1;
