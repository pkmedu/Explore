data have(drop= i j);
call streaminit(123);
array x[*] TEST1-TEST5 ASSIGNMENT1 ASSIGNMENT2
               MIDTERM FINAL;
do i = 1 to 24;
   do j = 1 to dim(x);
      id = cats('GW',substr(compress(uuidgen(),'-'),1,6));
      x[j] = rand("Integer", 40, 100); 
   end;   
  output;
 end;
run;
title1 'Listing from HAVE Data Set';
proc print data=HAVE; run;
