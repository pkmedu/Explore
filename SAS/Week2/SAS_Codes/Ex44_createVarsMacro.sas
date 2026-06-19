data teams;                                                                         
  input color $15. @16 team_name $15. @32 game1 game2 game3;                          
datalines;                                                                          
Green          Crickets        10 7 8                                               
Blue           Sea Otters      10 6 7                                               
Yellow         Stingers        9 10 9                                               
Red            Hot Ants        8 9 9                                                
Purple         Cats            9 9 9                                                
;                                                                                   
                                                                                    
data _null_;                                                                        
  set teams end=end;                                                                  
  count+1;                                                                            
  call symputx('macvar'||left(count),compress(color)||compress(team_name)||"Total");  
  if end then call symputx('max',count);                                              
run;

%put &max;
%put _user_;

options mprint;                                                                     
                                                                                    
%macro newvars;                                                                     
                                                                                    
data teamscores;                                                                    
  set teams end=end;                                                                  
                                                                                    
%do i = 1 %to &max;                                                                 
  if _n_=&i then do;                                                                
    &&macvar&i=sum(of game1-game3);                                                 
    retain &&macvar&i;                                                              
    keep &&macvar&i;                                                                
  end;                                                                              
%end;                                                                               
if end then output;                                                                 
                                                                                    
%mend;                                                                              
                                                                                    
%newvars                                                                            
                                                                                    
proc print noobs;                                                                   
  title "League Team Game Totals";                                                    
run;            
