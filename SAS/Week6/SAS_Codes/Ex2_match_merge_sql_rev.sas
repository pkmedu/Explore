*Ex2_match_merge_sql_outer.sas (Part 1);
options nocenter nodate nonumber;
DATA BIRTH;
  INPUT id $ dob : mmddyy. @@ ;
  FORMAT dob  mmddyy10.;
  DATALINES;  
01 01/09/1954 02 09/12/1959 03 03/31/1944 
04 08/11/1950 05 07/18/1941
;
PROC SORT data=BIRTH; by id; 
title1 'BIRTH File - Listing'; footnote;
PROC PRINT data=BIRTH noobs;  run;
DATA DEATH;
input id $ dod : mmddyy. @@;
FORMAT dod mmddyy10.;
DATALINES;
04 12/31/2010 05 12/12/2012 06 12/29/2011 
07 12/31/2011 08 02/14/2012
; 
PROC SORT data=DEATH; by id; 
title1 'DEATH File - Listing'; footnote;
PROC PRINT data=DEATH noobs;  run;

*Ex2_match_merge_sql_outer.sas (Part 2);
options nocenter nodate nonumber;
** DATA Step Merge (match-merge) vs. PROC SQL Full Join;
data match_merge;
 merge  BIRTH DEATH ; 
 by id;
 run;
title1 'DATA Step Merge (Match-Merge)';
proc print data=match_merge noobs;
run;

*Ex2_match_merge_sql_outer.sas (Part 3);
options nocenter nodate nonumber;
proc sql;
title1 'Full Join/PROC SQL does not overlay same-name columns';
select * 
    from BIRTH b full join DEATH d
      on b.id = d.id;
quit;

*Ex2_match_merge_sql_outer.sas (Part 4);
options nocenter nodate nonumber;

** PROC SQL Full Outer Join compared with DATA Step Match-Merge;
** The COALESEC function returns the value of the first nonmissing
   argument; 
 options nocenter nodate nonumber;
proc sql;
title1 'Full Outer Join/PROC SQL overlays same-name columns when the COALESEC is used';
select coalesce(b.id, d.id) as id, b.dob, d.dod
       from BIRTH b full outer join DEATH d
      on b.id = d.id;
quit;

*Ex2_match_merge_sql_outer.sas (Part 5);
options nocenter nodate nonumber;
** DATA Step Merge (exact match) vs. PROC SQL Inner Join;
data Exact_Match;
 merge  BIRTH (in=b) DEATH (in=d);
   by id;
 if b=d;
 run;
title1 'DATA Step Merge - Exact Match';
proc print data=Exact_Match noobs;
run;

*Ex2_match_merge_sql_outer.sas (Part 6);
options nocenter nodate nonumber;
proc sql;
title1 'Inner Join/PROC SQL';
select coalesce(b.id, d.id) as id,
       b.dob, d.dod 
   from BIRTH as b
   inner join  DEATH as d
     on b.id = d.id;
quit;

*Ex2_match_merge_sql_outer.sas (Part 7);
options nocenter nodate nonumber;proc sql;
title1 'Inner Join 2 /PROC SQL';
select b.id, b.dob, d.dod 
   from BIRTH as b,
        DEATH as d
     where b.id = d.id;
quit;

*Ex2_match_merge_sql_outer.sas (Part 8);
options nocenter nodate nonumber;
*Exact match with subquery in PROC SQL; 
proc sql;
  select id, dob 
  from birth
  where id in (select id from death);
quit;

*Ex2_match_merge_sql_outer.sas (Part 9);
options nocenter nodate nonumber;
*Exact match with subquery in PROC SQL; 
proc sql;
  select id, dob 
  from birth
  where id in (select catx(' ', id, put(dod,mmddyy10.)) as id_dod
              from death);
quit;

*Ex2_match_merge_sql_outer.sas (Part 10);
options nocenter nodate nonumber;
** DATA Step Merge  vs. PROC SQL Left Join;
data left_merge;
 merge BIRTH(in=b) DEATH;
 by id;
 if b;
 run;
title1 'DATA Step Merge (Left Merge)';
proc print data=left_merge noobs;
run;

*Ex2_match_merge_sql_outer.sas (Part 11);
options nocenter nodate nonumber;
proc sql;
title1 'Left Join/PROC SQL';
select coalesce(b.id, d.id) as id,
       b.dob, d.dod 
   from BIRTH as b
   left join  DEATH as d
     on b.id = d.id;
quit;

*Ex2_match_merge_sql_outer.sas (Part 12);
options nocenter nodate nonumber;
** DATA Step Merge vs. PROC SQL Right Join;
data right_merge;
 merge  BIRTH DEATH (in=d); 
 by id;
 if d;
 run;
title1 'DATA Step Merge (Right Merge)';
proc print data=right_merge noobs;
run;

*Ex2_match_merge_sql_outer.sas (Part 13);
options nocenter nodate nonumber;
proc sql;
title1 'Right Join/PROC SQL';
select coalesce(b.id, d.id) as id,
       b.dob, d.dod 
       from BIRTH as b right join DEATH as d
      on b.id = d.id;
quit;
*Ex2_match_merge_sql_outer.sas (Part 14);
options nocenter nodate nonumber;
*** DATA Step Merge (nonmatch in the RIGHT data set) vs. PROC SQL subquery;
data Not_in_death;
 merge  BIRTH(in=b) DEATH (in=d); 
 by id;
 if b=1 & d ne 1;;
 run;
title1 'DATA Step Merge - Finding BIRTH IDs that are not in the DEATH file';
proc print data=Not_in_death noobs;
run;

*Ex2_match_merge_sql_outer.sas (Part 15);
options nocenter nodate nonumber;
*PROC SQL subquery finding BIRTH IDs that are not in the DEATH file; 
proc sql;
title1 'SQL subquery - Finding BIRTH IDs that are not in the DEATH file';
  select id, dob
  from birth
  where id not in(select id from death);
quit;

*Ex2_match_merge_sql_outer.sas (Part 16);
options nocenter nodate nonumber;
** DATA Step Merge (nonmatch in the RIGHT data set) vs. PROC SQL subquery;
data Not_in_birth;
 merge  BIRTH(in=b) DEATH (in=d); 
 by id;
 if d=1 & b ne 1;;
 run;
title1 'DATA Step Merge - Finding DEATH IDs that are not in the BIRTH file';
proc print data=Not_in_birth noobs;
run;

*Ex2_match_merge_sql_outer.sas (Part 17);
options nocenter nodate nonumber;
*PROC SQL subquery finding DEATH IDs that are not in the BIRTH file; ; 
proc sql;
title1 'SQL subquery - Finding DEATH IDs that are not in the BIRTH file';
  select id, dod 
  from death
  where id not in(select id from birth);
quit;
