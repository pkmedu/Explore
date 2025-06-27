*Ex1_%str_%nrstr1.sas;

%LET mvar1 = Beth%STR(%'s) Assignment Report;
%PUT &=mvar1;

%LET mvar2 = %STR(Beth%'s Assignment Report);
%PUT &=mvar2;

%let Course=%str(   Stat 4197);
%put &=Course;

%let step=%str(proc print; run;);
%PUT &=step;

%let mvar3 =  %NRSTR(AT&T)
%PUT &=mvar3;

%let mvar4 =  %NRSTR(%of defective bulbs);
%PUT &=mvar4;

***************************;

options symbolgen;
data test;
  store="Kids'Corner";
  call symput('s',store);
run;
%MACRO BQ;
  %IF %BQUOTE(&s) NE %THEN %PUT *** valid ***;
  %ELSE %PUT *** null value ***;
%MEND BQ;
%BQ   

%MACRO BQ_x;
  %LOCAL state;
  data _null_;
    State_Name='NE';
	CALL SYMPUT('State', State_Name);
  run;
  %IF %BQUOTE(&State)=%STR(NE) %THEN
      %PUT Nebraska Dept. of Health;
%put &State;
%MEND BQ_x;
%BQ_x 
options nosymbolgen;

******************************;
data _null_; 
 dt='20may13'd; 
 call symputx("dt",dt);
run;
%let ann10=%sysfunc(intnx(YEAR, &dt, 2, S)); 

* SAME (S): Specifies that the returned date has the same alignment as the start date;
%let ann10f=%sysfunc(intnx(YEAR, &dt, 2, S),mmddyy10.);

%put &=dt &=ann10 &=ann10f;

%let vars=My 10th anniversary is %nrstr(&ann10f);
%let varb=My 10th anniversary is %nrbquote(&ann10f); 
%put &vars; 
%put &varb;
%put %nrstr(&vars); 
%put %nrbquote(&varb);
%put %superq(varb);

******;
*%Superq;
data _Null_;
Call symputx('xmvar1', 'AT&T % of Employees Aged 25-49');
run;
%let xmvar2=%superq(xmvar1);
%put &=xmvar2;

