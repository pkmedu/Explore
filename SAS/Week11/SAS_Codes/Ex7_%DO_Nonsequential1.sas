*Ex7_%DO_Nonsequential1.sas;

options nonumber nocenter nodate symbolgen;

%let list = %str(sashelp.class| 
                 sashelp.iris| 
                 sashelp.retail);

%let count=%sysfunc(countw(&list, %str(|))); 

%macro loop;
 %local i dsname;

 %do i = 1 %to &count;

   %let dsname = %scan(&list, &i, %str(|));

   title "%left(&dsname)";

   proc print data=&dsname (obs=5) noobs;
   run;

 %end;

%mend loop;

%loop

/*

What your program is doing
&list holds a pipe-delimited list of datasets (with line breaks and spaces).
&count correctly counts how many items are in the list.
The macro %loop iterates from 1 → &count.
%SCAN() extracts each dataset name.
After the macro processor writing the SAS code, the generated SAS code, 
that is, PROC PRINT runs for each dataset.

Think of it like this
Macro processor → writes the program
SAS compiler/executor → runs the program

*/



