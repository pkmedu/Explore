* Code obtained from https://support.sas.com/kb/45/626.html;
/************************************************************************
Use a colon (:) operator to tell SAS to use the informat supplied 
but to stop reading the value for this field when a delimiter 
(space in this case) is encountered.
*************************************************************************/
data teams;  
* input color $15. @16 team_name $15. @32 game1 game2 game3;  /* Code from SAS Documentation workds */
* input color $ team_name & $10. game1 game2 game3; /* This Input style also works fine; */
  input color :$8. team_name :$10. (game1-game3) (:8.);  /* SAS issues notes - invalida data. */                        
datalines;                                                                          
Green          Crickets        10 7 8                                               
Blue           Sea Otters      10 6 7                                               
Yellow         Stingers        9 10 9                                               
Red            Hot Ants        8 9 9                                                
Purple         Cats            9 9 9                                                
;                                                                                   
proc print data=teams; 
run;  

