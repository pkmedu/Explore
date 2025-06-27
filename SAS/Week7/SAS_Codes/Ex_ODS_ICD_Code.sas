  
ods select all; 
options obs=max;;                                                                                                                       
data have(drop=proc);                                                                                                                   
  retain pat hosp  icd9 cnt . a b c b e f g  "12345678";                                                                                
  do pat=1 to 100000;                                                                                                                   
     hosp=mod(pat,3000) + 1;                                                                                                            
     do proc=1 to 6;                                                                                                                    
       icd9=int(6*uniform(1234)) + 1;                                                                                                   
       cnt=int(10*uniform(43221)) + 1;                                                                                                  
       output;                                                                                                                          
     end;                                                                                                                               
  end;                                                                                                                                  
run;quit;                                                                                                                               

ods exclude all;                                                                                                                        
ods output list=want;   
proc print data=want (obs=10);  
run;
proc freq data=have;                                                                                                                    
   table hosp*icd9 /  list;                                                                                                             
   weight cnt;                                                                                                                          
run;quit;   
ods exclude none;
proc print data=have (obs=10);
run;
