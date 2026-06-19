*https://stackoverflow.com/questions/42478220/transpose-multiple-columns-to-rows-in-sas;
/*
ID  Var1    Var2    Jul-09  Aug-09  Sep-09      
1   10        15       200     300     
2    5        17      -150     200
*/

options validvarname=any;

data a;
    infile datalines missover;
    input ID Var1 Var2 "Jul-09"n "Aug-09"n "Sep-09"n;
datalines;
1 10 15 200 300
2 5 17 -150 200
;
run;

proc print data=a;
run;

data a;
input ID Var1 Var2 Jul_09 Aug_09;
CARDS;
1 10 15 200 300
2 5 17 -150 200
;

DATA b(drop=i jul_09 aug_09);
array dates_{*} jul_09 aug_09;
set a;
do i=1 to dim(dates_);
    this_value=dates_{i};
    this_date=input(compress(vname(dates_{i}),'_'),MONYY5.);
    output;
end;
format this_date monyy5.;
run;

proc print data=b; run;
