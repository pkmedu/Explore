*Ex5_create_mvars_from_list.sas;
dm "log; clear; output; clear; odsresults; clear;";
%Let Path = C:\Users\pmuhuri\SASCourse\Week11\SAS_Codes;
Data h50 h60 h70 h79 h89 h97 h105 h113 h121 h129 h138 h147 h155 h163 h171 h181;
 some_date = '18May1990'd;
run;

%macro loops(list) ;
     %local count i;                                             
     %let count=%sysfunc(countw(&list, %STR(|))); /* Count the number of data sets */
         %do i = 1 %to &count; /* Loop through the total # of the list */   
	     %let ds = %scan(&list,&i,%str(|)); /* You can use %BQUOTE() instead of %STR() */
          title "Data set: &ds";
          proc print data=&ds;
		    format some_date worddate.;
		  run;
%end;
%mend loops;
filename mprint "&Path\Ex5_Generated_Code.sas";
options mprint mfile;
%loops(h50|h60|h70|h79|h89|h97|h105|h113|h121|h129|h138|h147|h155|h163|h171|h181)
