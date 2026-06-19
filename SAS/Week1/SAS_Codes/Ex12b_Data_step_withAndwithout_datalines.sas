* Ex12b_Data_step_withAndwithout_datalines.sas;
dm "clear log; clear output; clear odsresults;";
data work.have1;
 name='Kirk'; quiz1=78; quiz2=84; quiz3=82;
 ave_score = round(mean(of quiz1-quiz3),.01);
 output;

 name='Neil'; quiz1=90; quiz2=85; quiz3=86;
 ave_score = round(mean(of quiz1-quiz3),.01);
 output;

 name='John'; quiz1=82; quiz2=79; quiz3=89;
 ave_score = round(mean(of quiz1-quiz3),.01);
 output;

 name='Keya'; quiz1=78; quiz2=86; quiz3=78;
 ave_score = round(mean(of quiz1-quiz3),.01);
 output;
 run;
 title "Listing from HAVE1 sas data set";
 proc print data=work.have1 noobs label;
 label quiz1 = 'Quiz 1 score'
       quiz2 = 'Quiz 2 score'
       quiz3 = 'Quiz 3 score'
       ave_score = 'Average score';
run;

*********;
 data work.have2;
   do i = 1 to 4;
       if i = 1 then do;
         name = 'Kirk'; quiz1 = 78; quiz2=84; quiz3= 82;
       end;

       if i = 2 then do;
         name = 'Neil'; quiz1 = 90; quiz2=85; quiz3= 86;
       end;

       if i = 3 then do;
         name = 'John'; quiz1 = 82; quiz2=79; quiz3= 89;
       end;

       if i = 4 then do;
         name = 'Keya'; quiz1 = 78; quiz2=86; quiz3= 78;
       end;
       ave_score = round(mean(of quiz1-quiz3),.01);
       output;
   end;
  run;
title "Listing from HAVE2 sas data set";
proc print data=work.have2 noobs label;
label quiz1 = 'Quiz 1 score'
      quiz2 = 'Quiz 2 score'
      quiz3 = 'Quiz 3 score'
      ave_score = 'Average score';
run;
