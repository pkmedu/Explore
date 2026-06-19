*Ex22_array_count_specific_value.sas;
options nocenter nonumber nodate;
Data work.Have(drop=i);                                                                                                                     input var1 var2 var3 var4;                                                                                                            
  array test(*) var1--var4;                                                                                                             
/* initialize the counters to zero for 
  each observation */                                                                              
  counter1=0;                                                                                                                           
  counter2=0;                                                                                                                           
/* count the values of 1 and 2 */                                                                                                       
  do i = 1 to 4;                                                                                                                        
    if test(i) = 1 then counter1+1;                                                                                                     
    else if test(i) = 2 then counter2+1; 
    counter1x=sum(of test[*]); 
  end;                                                                                                                                  
  datalines;                                                                                                                            
1  0  1  2                                                                                                                              
2  2  2  1                                                                                                                              
0  2  1  0                                                                                                                              
1  1  1  1                                                                                                                              
2  2  2  2                                                                                                                              
;                                                                                                                                       
run;  
title1 'Count the instances of a certain value'; 
proc print data=work.Have noobs;
run;
title1;
