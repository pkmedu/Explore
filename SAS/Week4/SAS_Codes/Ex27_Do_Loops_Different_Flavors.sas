*Ex27_Do_Loops_Different_Flavors.sas (Part 1);
* Assess the Effect of having no OUTPUT statement before the END statement;
options nocenter nodate nonumber;
data have1;
 do i=1 to 5;
 end;
run;
title1 'From a data set created with no OUTPUT statement before the END statement ';
proc print data=have1;
run;

*Ex27_Do_Loops_Different_Flavors.sas (Part 2);
* Assess the Effect of having  an OUTPUT statement before the END statement;
options nocenter nodate nonumber;
data have2;
 do i=1 to 5;
 output;
end;
run;
title1 'From a data set created with an OUTPUT statement before the END statement';
proc print data=have2 noobs;
run;

*Ex27_Do_Loops_Different_Flavors.sas (Part 3);
* Assess the Effect of having an nested do loop in an existing data table;
options nocenter nodate nonumber;
data class;
 set sashelp.class;
 do j=1 to 2;
  some_date=put('30Jan2018'd+ j, date9.);
  output;
 end;
run;
title1 'From a data set created with nested do loop in an existing data table';
proc print data=class (obs=10);
run;
title1;

*https://communities.sas.com;
* By mikezdeb;

data ci (keep=period principal);
retain initial 10000 rate 0.10;
do period=1 to 10;
  principal = compound(initial, . , rate, period);
  output;
end;
format principal dollar10.;
run;
proc print data=ci; run;

data ci_x (keep=period principal);
retain initial 10000 rate 0.10;
do period=1 to 10;
  initial+1000;
  principal = compound(initial, . , rate, period);
  output;
end;
format principal dollar10.;
run;
proc print data=ci_x; run;


DATA do_until;  
retain loan 50000 payment 0;  
do until (loan=0);  
  loan = loan - 2000;
  payment = payment + 1; 
end;  
run;  
proc print data=do_until;  
run;

Data do_while;  
retain loan 50000 payment 0;  
do while(loan > 0);  
loan = loan - 2000;  
payment = payment + 1;  
end;  
run;  
proc print data=do_while;  
run;  

