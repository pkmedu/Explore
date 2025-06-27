*Ex7_%DO_Nonsequential1.sas;
options nonumber nocenter nodate symbolgen;
%LET list = %str(sashelp.class| 
                 sashelp.iris| 
                 sashelp.retail);
/* Count # of values in the string */
%LET count=%sysfunc(countw(&list, %STR(|))); 
%macro loop;
 /* Loop through the total # of data sets */ 
 %local i;
 %do i = 1 %to &count;
   title  "%left(%unquote(%SCAN(&list, &i, %STR(|))))";
   proc print data=%scan(&list,&i, %str(|)) 
             (obs=5) noobs;  
	run;
 %end;
%mend loop;
%loop



