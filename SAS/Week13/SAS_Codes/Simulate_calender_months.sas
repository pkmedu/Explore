
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
%sysmstoreclear;
libname Mylib 'C:\SASCourse\DO_Over_Compiled';
options mstored sasmstore=Mylib;
proc sql;                                                                                                                   
  create table want as                                                                                                         
  select
   %do_over(vs,phrase=input(?,best.) as ?, between=comma) 
  from have;                                                                                                                 
quit;   

