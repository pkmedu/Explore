DM "Log; clear;";
%macro test_ok;

    /* Masked expression */
    %let cond = %str(5 > 3);

    %if %unquote(&cond) %then %do;
        %put TRUE branch;
    %end;
    %else %do;
        %put FALSE branch;
    %end;

%mend;

%test_ok;

ods html close;
options nonumber nodate note nosource;

data new_class;
    set sashelp.class end=last;
    output;
    if last then do;
        name = "O'Connor";
        sex = 'M';
        age = 12;
        height = 59;
        weight = 99.9;
        output;
    end;
run;
proc print data
