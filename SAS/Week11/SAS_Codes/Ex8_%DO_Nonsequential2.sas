*Ex8_%DO_Nonsequential2.sas;
options nocenter nodate nonumber symbolgen;
%macro loop(dslist);    
     %local xcount i; 
     /* Count the # of values in the string */                                                                                                                                   
     %let xcount=%sysfunc(countw(&dslist, %STR(|))); 
     /* Loop through the total # of data sets */                                                                                         
     %do i = 1 %to &xcount; 
        title  "%left(%scan(&dslist,&i,%str(|)))"; 
        proc print data=%scan(&dslist,&i,%str(|))
                 (obs=5) noobs;
	  run;
	  %end;                                                                                            
%mend loop;                                            
%loop(%str(sashelp.class|sashelp.iris|sashelp.retail))

