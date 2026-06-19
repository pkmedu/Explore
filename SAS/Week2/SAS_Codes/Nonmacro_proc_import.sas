
proc import datafile="C:\Data\Original_EMB_rev.xlsx"
    out=_tmp2
    dbms=xlsx
    replace
    guessingrows=max;  /* correct: part of PROC IMPORT */
    sheet="Table 2";
    getnames=yes;
run;


libname XL XLSX "C:\Data\Original_EMB_rev.xlsx" 
              dbsastype=(i_date="CHAR(200)");
data work.EMB;
    set XL."Table 2"n;
    i_date = translate(strip(i_date), ' ', '0A0D'x); /* fix multi-line */
run;
