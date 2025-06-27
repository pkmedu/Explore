*Ex3_merge_update_BY.sas (Part 1);
options nocenter nodate nonumber;
proc datasets kill nolist nodetails; quit;
data work.MASTER; 
infile datalines firstobs=2 truncover;
input pt_id $ 1-4 Name $ 6-13 @16 visit_date mmddyy10.;
FORMAT visit_date mmddyy10.;
datalines;
1234567890123456789012345
P001 Mary      07/23/2016
;
proc sort data=work.MASTER; by  pt_id; run;

data work.TRANS; 
infile datalines firstobs=2 truncover;
input pt_id $ 1-4 Name $ 6-13 @16 visit_date mmddyy10.;
FORMAT visit_date mmddyy10.;
datalines;
1234567890123456789012345
P001           09/24/2016
P001 Ann-Mary  11/30/2016
P001 Ann-Mary   
;

proc sort data=work.TRANS; by  pt_id; run;

title1 'LISTNG - WORK.MASTER';
proc print data=work.MASTER; 
run;

title1 'LISTNG - WORK.TRANS';
proc print data=work.TRANS; 
run;
title1;
*Ex3_merge_update_BY.sas (Part 2);
options nocenter nodate nonumber;
data work.Merged_NEW;
 MERGE work.MASTER 
       work.TRANS; 
   by  pt_id;
run;
title1 'WORK.MERGED_NEW';
proc print data=
     work.Merged_NEW; 
run;

*Ex3_merge_update_BY.sas (Part 3);
options nocenter nodate nonumber;
data work.Updated_NEW;
 UPDATE work.MASTER (IN=O) 
        work.TRANS (IN=T);
  by  pt_id;
run;
title1 'WORK.Updated_NEW '; 
proc print data=
     work.Updated_NEW; 
run;

*Ex3_merge_update_BY.sas (Part 4) - Subway Master File;
DATA master;
INFILE DATALINES DLM=',';
INPUT Id item & $14.  sub_6_inch footlong;
DATALINES;
1,Cold Cut Combo,3.50, 5.00
2,Pizza Sub,3.50, 5.00
3,Spicy Italian,3.50, 5.00
4,Veggie Delite, 3.50, 5.00
5,Turkey Breast, 4.00, 6.00
6,Tuna,             4.00, 6.00
7,Veggie Patty,     4.00, 6.00
8,Subway Club,     4.50, 7.00
9,Subway Melt,     4.50, 7.00
10,Steak & Cheese, 4.50, 7.25
11,Roast Beef,     4.50, 7.25
;
PROC SORT DATA=master; 
  BY id; 
run;
title1 'Master File - Subway Menu';
Proc print data=master noobs; run;

*Ex3_merge_update_BY.sas (Part 5) - Subway Transaction File;
DATA Transact;
INFILE DATALINES DLM=',';
INPUT Id item & $14.  sub_6_inch footlong;
DATALINES;
9,Subway Melt,     5.50, 8.00
10,Steak & Cheese, 5.50, 9.25
11,Roast Beef,     5.50, 8.25
;
PROC SORT DATA=Transact; 
  BY id; 
run;
title1 'Transaction File - Subway Menu';
Proc print data=Transact noobs; run;

*Ex3_merge_update_BY.sas (Part 6) - Subway Updated File;
DATA updated; 
 UPDATE master Transact; BY id;
run;
PROC PRINT DATA=updated noobs; 
run;

DATA master_x; 
 SET master;
run;
DATA master_x; 
 MODIFY master_x Transact; 
BY id;
run;
title1 'Updated File - Subway Menu';
PROC PRINT DATA=Master_x noobs; 
run;
