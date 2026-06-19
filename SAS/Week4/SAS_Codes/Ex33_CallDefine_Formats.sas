* Ex33_CallDefine_Formats;
/* Contributed to SAS-L by Tom Superstar - 1/29/2018 */ 
data have ;
  input TYPE $ TOTALS ;
cards;
A 39442499
B 828727452.170335
B 519125592.249982
B 1491576104.14236
B 31241133938.0128
C 2026005
C 2949321.99999995
;

%let path=U:\A_ExampleSASCode;
ods excel file="&path/test.xlsx";

proc report data=have nowd;
  column TYPE TOTALS;
  define TYPE/ display style(column)={just=l} width=4;
  define TOTALS/ display style(column)={just=l} width=19;
  compute TOTALS;
    if type='B' then do;
       call define(_col_,'format','dollar19.2');
       call define(_col_,'style','style={tagattr="Format:$#,##0.00"}');
    end;
    else do;
       call define(_col_,'format','comma12.');
       call define(_col_,'style','style={tagattr="Format:#,###"}');
    end;
  endcomp;
run;

ods excel close;

/* %put %sysfunc(pathname(work));  */
