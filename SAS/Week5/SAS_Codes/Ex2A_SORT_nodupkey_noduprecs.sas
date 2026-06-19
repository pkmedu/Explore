*Ex2A_SORT_nodupkey_noduprecs.sas (Part 1);
options nocenter nonumber nodate;
data work.HAVE;
  input ID $ visit_date :mmddyy. 
        visit_type :& $25.;
  format visit_date mmddyy10. ;
datalines;
A01 01152015 Emergency Room Visit
A01 07252015 Physician Office Visit
A01 07252015 Physician Office Visit
A02 02202015 Physician Office Visit
A02 02202015 Emergency Room Visit
A05 01122015 Outpatient Visit
;
Title1 "Ex2A_SORT_nodupkey_noduprecs.sas";
Title2 "Sort the data in ascending order by visit_date";
proc sort data=work.Have
     out=work.visit_date_A; 
by visit_date; 
run;
proc print data=work.visit_date_A; 
run;
*Ex2A_SORT_nodupkey_noduprecs.sas (Part 2);
Title2 "Sort the data in descending order by visit date";
proc sort data=work.Have
     out=work.visit_date_D; 
by descending visit_date; 
run;
proc print data=work.visit_date_D; 
run;
*Ex2A_SORT_nodupkey_noduprecs.sas (Part 3);
title2 "NODUPKEY Option with PROC SORT - One BY-variable (ID)";
proc sort data = work.HAVE nodupkey 
   out=work.nodupkey_1BY; 
by ID ;
proc print data=work.nodupkey_1By noobs; 
run;

*Ex2A_SORT_nodupkey_noduprecs.sas (Part 4);
Title2 "Sort with NODUPKEY Option with PROC SORT - Two By_variables";
proc sort data = work.HAVE nodupkey 
   out=work.nodupkey_2Bys; 
by ID Visit_date;
proc print data=work.nodupkey_2Bys noobs; 
run;

*Ex2A_SORT_nodupkey_noduprecs.sas (Part 5);
proc sort data = work.HAVE nodupkey
  out=work.nodupkey_ALL_ 
  DUPOUT=work.dupoutobs ;
 BY _ALL_ ;
run;
Title2 "Listing of duplicate observations";
proc print data=work.dupoutobs noobs; 
run;

Title2 "Listing of nonduplicate observations (nodupkey _ALL_)";
proc print data=work.nodupkey_all_ noobs; 
run;


*Ex2A_SORT_nodupkey_noduprecs.sas (Part 6);
** New options with PROC SORT;
proc sort data = have nouniquekeys
          out = duplicates
          uniqueout = singles;
by ID Visit_date visit_type;
Title2 "NOUNIQUEKEYS and UNIQUEOUT OptionS with PROC SORT (Duplicates)";
proc print data=duplicates noobs; run;
Title2 "NOUNIQUEKEYS and UNIQUEOUT Options with PROC SORT (Singles)";
proc print data=singles noobs; run;
title1; title2;
