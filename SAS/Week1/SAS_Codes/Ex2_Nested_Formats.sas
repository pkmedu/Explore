
Ex2_Nested_Formats.sas (The SAME program is also in Week 3 folder);
proc format;
value date_grp_fmt
  low-'03jul1995'd          = 'Pre July 4th 1995'
  '04jul1995'd-'31jul1995'd = [mmddyy8.]
  '01aug1995'd-high         = 'Aug 1-Dec 31, 1995';
  
value sales_fmt
  low-<5000 = 'Less than $5,000'
  5000-9999 = '$5,000-<$10,000'
  10000-high = [dollar12.2];
  run;
  title 'Nested formats';
  proc freq data=sashelp.mdv;
  tables shipdate sales93;
  format shipdate date_grp_fmt.
    sales93 sales_fmt.;
  run;
 
