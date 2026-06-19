
data test;
set sashelp.class;
if mod(_n_,3) eq 0 then pay_amt = 10444555666.25;
else if mod(_n_,3) eq 1 then pay_amt = 10222333444.26;
else pay_amt = 10111222333.26;
run;

data _null_;
set test;
format pay_amt 16.2;
if _n_ = 1 then put "name|age|sex|pay_amt";
put name +(-1) '|' age +(-1) '|' sex +(-1) '|' pay_amt;
run;


data _null_;
input pay_amt;
if _n_ = 1 then put "Pay_amt";
put _infile_;
datalines;
10444555666.25
10222333444.26
10111222333.26
;


