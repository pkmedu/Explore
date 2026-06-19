
dm "log; clear;";
options symbolgen mprint mlogic;

* This program works;
%let cond = %str(age > 14 and sex = 'M');
data _null_;
    set sashelp.class;
    length group $10;
    group = %sysfunc(ifc(%unquote(&cond), "SeniorMale", "Other"));
    put name= group=;
run;

* This program works;
dm "log; clear;";
options symbolgen mprint mlogic;

%let cond = %str(age > 14 and sex = 'M');
%put &=cond;

data _null_;
    set sashelp.class;
    length group $10;
    group = %sysfunc(ifc (&cond), "SeniorMale", "Other");
    put name= group=;
run;

* This program works;
dm "log; clear;";
options symbolgen mprint mlogic;

%let cond = %str(age > 14 and sex = 'M');
%put &=cond;

data want;
    set sashelp.class;
    length group $10;

    if &cond then group = "SeniorMale";
    else group = "Other";

    put name= group=;
run;




