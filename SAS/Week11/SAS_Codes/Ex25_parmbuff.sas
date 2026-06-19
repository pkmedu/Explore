

/*You can use the SYSPBUFF automatic macro variable, 
which contains the parameter values you supplied to 
the macro, including the parentheses and commas. 
The PARMBUFF option allows one to build a macro 
to deal with a varying number of parameters. */

%macro data_pull / parmbuff;
    proc sql;
        select *
            from sashelp.class
                where name in &syspbuff.;
    quit;
%mend data_pull;

%data_pull('Alfred','Alice','ben','adam')

/*
Trying to put commas in the value of the macro variable is the issue
since comma is used to mark the transition between parameter 
values in the macro call.
*/
%macro data_pull (name=);
proc sql;
select * from sashelp.class where name in &name;
quit;
%mend data_pull;

%DATA_PULL (Name = %str(('Alfred', 'Alice', 'Barbara')))

%DATA_PULL (Name = %quote(('Alfred', 'Alice', 'Barbara')))

