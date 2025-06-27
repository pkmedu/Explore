
*Ex3_proc_tabulate.sas (Part 1);
options nonumber nodate ls=132 ps=58 ;
PROC TABULATE data=sashelp.heart format=comma7. ;
  TITLE1 'Two Dimensional TABLE';
  TITLE2 'N and Row Percentage';
  CLASS weight_status BP_status;
  TABLE weight_status all, (BP_Status all)*(N rowpctn*f=6.1);
run;

*Ex3_proc_tabulate.sas (Part 2);
PROC TABULATE data=sashelp.heart format=comma7. ;
TITLE1 'Two Dimensional TABLE';
  TITLE2 'Variable Labels Changed and KEYLABEL Statement Added';
  CLASS weight_status BP_Status;
  KEYLABEL N='Total' rowpctn = 'Row %';
  TABLE weight_status='Body Mass Index Category' all, 
        (BP_Status='Blood Pressure Category' all)*(N rowpctn*f=6.1);
run;

*Ex3_proc_tabulate.sas (Part 3);
PROC TABULATE data=sashelp.heart format=comma7. ;
TITLE1 'Three Dimensional TABLE';
  TITLE2 'Mean Weight';
  CLASS weight_status BP_Status sex;
  VAR  weight;
  KEYLABEL N='Total'  mean = 'Mean (lbs)';
  TABLE (sex all), weight_status='Body Mass Index Category' all, 
        (BP_Status='Blood Pressure Category' all)
        *(N weight*mean);
run;

*Ex3_proc_tabulate.sas (Part 4);
PROC TABULATE data=sashelp.heart format=comma7.;
TITLE1 'Concatenated Rows - Two Dimensional TABLES';
  TITLE2 'Mean Weight';
  CLASS weight_status sex bp_status;
  VAR  weight;
  KEYLABEL N='Total'  mean = 'Mean (lbs)';
  TABLE (sex all)*weight_status='Body Mass Index Category' all, 
         (bp_status='Blood Pressure Category' all)
             *(N weight*mean);
  run;
