```sas
proc means data=sashelp.class mean maxdec=1 noprint;
 var weight;
 output out=stats (drop = _TYPE_ _FREQ_) mean=average_wgt;
run;

data _null_;
  set stats;
  call symputx('average_wgt', average_wgt);
 run;

Data test;
 set SASHELP.class;
  weight_ratio=weight/&average_wgt;  
run;
proc print data=test;
run;
```
```ascii
Obs	Name	Sex	Age	Height	Weight	weight_ratio
1	Alfred	M	14	69.0	112.5	1.12470
2	Alice	F	13	56.5	84.0	0.83978
3	Barbara	F	13	65.3	98.0	0.97974
4	Carol	F	14	62.8	102.5	1.02473
5	Henry	M	14	63.5	102.5	1.02473
6	James	M	12	57.3	83.0	0.82978
7	Jane	F	12	59.8	84.5	0.84478
8	Janet	F	15	62.5	112.5	1.12470
9	Jeffrey	M	13	62.5	84.0	0.83978
10	John	M	12	59.0	99.5	0.99474
11	Joyce	F	11	51.3	50.5	0.50487
12	Judy	F	14	64.3	90.0	0.89976
13	Louise	F	12	56.3	77.0	0.76980
14	Mary	F	15	66.5	112.0	1.11971
15	Philip	M	16	72.0	150.0	1.49961
16	Robert	M	12	64.8	128.0	1.27966
17	Ronald	M	15	67.0	133.0	1.32965
18	Thomas	M	11	57.5	85.0	0.84978
19	William	M	15	66.5	112.0	1.11971
```
