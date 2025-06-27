*Ex21_create_variable_in_SQL.sas (Part 1);
options nocenter nodate nonumber;
title1 'Ex21_create_variable_in_SQL.sas (Part 1)';
PROC SQL;
SELECT 
  CASE
  WHEN weight <100 THEN '<100 lbs'
  WHEN weight GE 100 AND weight LT 120 THEN '100-<120 lbs'
  WHEN weight GE 120 AND weight LE 150 THEN '120-150 lbs'
  ELSE '120-150 lbs'
  END AS Weight_Cat label= 'Weight Category',
  count(*) as freq_count
FROM sashelp.class
group by Weight_Cat
order by  freq_count desc;
quit;



