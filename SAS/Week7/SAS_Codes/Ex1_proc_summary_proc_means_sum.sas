*Ex1_proc_summary_proc_means_sum.sas (Part 1);

proc means data=sashelp.heart sum maxdec=0; 
class BP_status;
var weight;
run;


*Ex1_proc_summary_proc_means_sum.sas (Part 2);
proc summary data=sashelp.heart;
     class BP_Status;
     var weight;
     output out=stats 
     sum=/autoname;
run;
proc print data=stats.heart;
run;

*Ex1_proc_summary_proc_means_sum.sas (Part 3);
 proc summary data=sashelp.prdsale;
     var _numeric_;
     output out=want_summary(drop=_type_ _freq_) 
     sum=/autoname;
   run;
proc print data=want_summary noobs;
format _numeric_ dollar12.;
run;

*Ex1_proc_summary_proc_means_sum.sas (Part 4);
proc transpose data=want_summary 
      out=t_ws (rename=(col1=Amount))
      name=Var_Sum;
run;
proc print data=t_ws noobs;
format amount dollar12.;
run;

