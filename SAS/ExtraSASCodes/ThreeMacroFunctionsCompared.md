
```sas
data _null_; 
 dt='20may13'd; 
call symputx("dt",dt);
run;

%let ann10=%sysfunc(intnx(YEAR, &dt, 2, S)); 
%let ann10f=%sysfunc(intnx(YEAR, &dt, 2, S),mmddyy10.);
%let vars=My 10th anniversary is %nrstr(&ann10f);
%let varb=My 10th anniversary is %nrbquote(&ann10f); 

%put &=dt &=ann10 &=ann10f;
%put &=dt &=ann10 &=ann10f;
%put &vars; %put &varb;
%put %nrstr(&vars); 
%put %nrbquote(&varb);
%put %superq(varb);
```

