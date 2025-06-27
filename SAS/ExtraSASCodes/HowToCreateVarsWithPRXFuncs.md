
```sas
dm "log; clear; output; clear; odsresults; clear;";
data test;
  input _name_ :$13. @@ ;
datalines;
PERWT21F_N PERWT21F_Mean PERWT21F_Sum PERWT21F_CV PERWT21F_Min PERWT21F_Max
SAQWT21F_N SAQWT21F_Mean SAQWT21F_Sum SAQWT21F_CV SAQWT21F_Min SAQWT21F_Max
FAMWT21C_N FAMWT21C_Mean FAMWT21C_Sum FAMWT21C_CV FAMWT21C_Min FAMWT21C_Max
FAMWT21F_N FAMWT21F_Mean FAMWT21F_Sum FAMWT21F_CV FAMWT21F_Min FAMWT21F_Max
;
```
```sas
data final;
 set test;
 length stat $4;
 if prxmatch('/N$/', strip(_name_)) then stat='N';
  if prxmatch('/Mean$/', strip(_name_)) then stat='Mean';
  if prxmatch('/Sum$/', strip(_name_)) then stat='Sum';
  if prxmatch('/CV$/', strip(_name_)) then stat='CV';
  if prxmatch('/Min$/', strip(_name_)) then stat='Min';
  if prxmatch('/Max$/', strip(_name_)) then stat='Max';

retain r;
  if _N_ = 1 then r = prxparse('/.+(\d{2})[A-Z]\_[a-zA-Z]/');
  if prxmatch(r,_NAME_) then yr = prxposn(r,1,_NAME_);
  year = '20'||yr;

  retain r2;
  if _N_ = 1 then r2 = prxparse('/(.+)\d{2}([A-Z])\_[a-zA-Z]/');
  if prxmatch(r2,_NAME_) then 
     do;
       first = prxposn(r2,1,_NAME_);
	   last = prxposn(r2,2,_NAME_);
     end;
  keyvar = cats(first, last);
drop yr r: first last ;
run;
proc print;
run;
```
SAS Output
```
Obs       _name_        stat    year    keyvar

  1    PERWT21F_N       N       2021    PERWTF
  2    PERWT21F_Mean    Mean    2021    PERWTF
  3    PERWT21F_Sum     Sum     2021    PERWTF
  4    PERWT21F_CV      CV      2021    PERWTF
  5    PERWT21F_Min     Min     2021    PERWTF
  6    PERWT21F_Max     Max     2021    PERWTF
  7    SAQWT21F_N       N       2021    SAQWTF
  8    SAQWT21F_Mean    Mean    2021    SAQWTF
  9    SAQWT21F_Sum     Sum     2021    SAQWTF
 10    SAQWT21F_CV      CV      2021    SAQWTF
 11    SAQWT21F_Min     Min     2021    SAQWTF
 12    SAQWT21F_Max     Max     2021    SAQWTF
 13    FAMWT21C_N       N       2021    FAMWTC
 14    FAMWT21C_Mean    Mean    2021    FAMWTC
 15    FAMWT21C_Sum     Sum     2021    FAMWTC
 16    FAMWT21C_CV      CV      2021    FAMWTC
 17    FAMWT21C_Min     Min     2021    FAMWTC
 18    FAMWT21C_Max     Max     2021    FAMWTC
 19    FAMWT21F_N       N       2021    FAMWTF
 20    FAMWT21F_Mean    Mean    2021    FAMWTF
 21    FAMWT21F_Sum     Sum     2021    FAMWTF
 22    FAMWT21F_CV      CV      2021    FAMWTF
 23    FAMWT21F_Min     Min     2021    FAMWTF
 24    FAMWT21F_Max     Max     2021    FAMWTF
```
