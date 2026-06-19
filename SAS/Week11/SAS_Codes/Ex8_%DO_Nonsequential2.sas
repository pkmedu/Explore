*Ex8_%DO_Nonsequential2.sas;
options nocenter nodate nonumber symbolgen;

%macro loop(dslist);    
     %local xcount i dsname; 

     %let xcount=%sysfunc(countw(&dslist, %str(|))); 

     %do i = 1 %to &xcount; 

        %let dsname = %scan(&dslist,&i,%str(|));

        title "%left(&dsname)"; 

        proc print data=&dsname (obs=5) noobs;
        run;

     %end;                                                                                            
%mend loop;                                            

%loop(%str(sashelp.class|sashelp.iris|sashelp.retail))
/*
The macro generates SAS code (including PROC PRINT).
The generated code is then compiled and executed by SAS.
It dynamically sets a title, and prints the first 5 observations of each dataset.

*/
%STR(...) in the call
Protects the | delimiter so it’s passed correctly into the macro.
countw(&dslist, %STR(|))
Counts how many dataset names are in the list.
%scan(&dslist,&i,%str(|))
Extracts each dataset name one at a time.
%left(...) in the TITLE
Removes leading blanks from the dataset name before displaying it.
PROC PRINT loop
Prints first 5 observations of each dataset.