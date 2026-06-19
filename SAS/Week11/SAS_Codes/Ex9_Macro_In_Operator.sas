*Ex9_Macro_In_Operator.sas;
proc sql ;                                                                                                                              
      select quote(strip(Name))                                                                                                         
      INTO  :Starts_withC separated by ','                                                                                              
    from sashelp.demographics                                                                                                           
      where Name LIKE 'C%';                                                                                                             
quit;                                                                                                                                   
%PUT &Starts_withC;   
   
*Ex9_Macro_In_Operator.sas; 
  proc print data=sashelp.demographics;                                                                                                 
  var Name pop;                                                                                                                         
  where Name in  (&Starts_withC);                                                                                                       
  run;                                                                                                                                  
   
*Ex9_Macro_In_Operator.sas; 
%macro cn / minoperator mindelimiter=',';                                                                                               
  proc print data=sashelp.demographics;                                                                                                 
  var Name pop;                                                                                                                         
  where Name in  (&Starts_withC);                                                                                                       
  run;                                                                                                                                  
%mend cn;                                                                                                                               
%cn  
 
