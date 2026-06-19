DM "log; clear;";

%let dsn=class;
%let mvar1 = %str(proc print data=sashelp.&dsn; run;);
%let mvar2 = %bquote(proc print data=sashelp.&dsn; run;);
%let mvar3 = %nrbquote(proc print data=sashelp.&dsn; run;);


%put &=mvar1;
%put &=mvar2;
%put &=mvar3;

