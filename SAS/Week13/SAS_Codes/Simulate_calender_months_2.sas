
*** Contributed by Roger DeAngelis to SAS-L 11/1/2020;
%let months = JAN FEB MAR APR MAY JUN JUL AUG SEP OCT NOV DEC;                                                             

data have ;                                                                                                                 
  array mths[12] $4 &months ;                                                                                               
  do rec=1 to 5;                                                                                                           
     do idx=1 to 12;                                                                                                       
        mths[idx] = put(int(900*uniform(567)) + 100,4.);                                                                   
     end;                                                                                                                   
     output;                                                                                                               
  end;                                                                                                                     
  drop rec idx;                                                                                                             
run;
proc print data=have; run; 
filename packages "%sysfunc(pathname(work))"; /* setup temporary directory for packages in the WORK */
filename SPFinit url "https://raw.githubusercontent.com/yabwon/SAS_PACKAGES/master/SPF/SPFinit.sas";
%include SPFinit; /* enable the framework */

%installPackage(macroArray basePlus) /* install packages */
  %loadPackageS(macroArray,basePlus) /* load packages content into the SAS session */

%array(Mth[*] %getVars(have), macarray=Y, vnames=Y)

%put *%do_over(Mth)*;

proc sql;                                                                                                                  
  create                                                                                                                  
      table want as                                                                                                        
  select                                                                                                                  
      %do_over(Mth
              ,phrase=%nrstr(input(%Mth(&_I_.), best.) as %Mth(&_I_.))
              ,between=%str(,)
              )                                                              
  from                                                                                                                    
      have                                                                                                                
;
quit;    

%deleteMacArray(Mth, macarray=Y)

proc print data=want; run;
