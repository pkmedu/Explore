
*https://www.theguardian.com/world/ng-interactive/2020/mar/31/coronavirus-map-us-latest-cases-state-by-state;
options nocenter nodate nonumber;
data March_31;
input state & $char15. conf_cases :comma9. death :comma9.;
death_rate_IC = death*100/conf_cases;
datalines;
New York	67,384	1,342
New Jersey	16,636	198
California	7,429	149
Michigan	6,498	185
Massachusetts	5,752	56
Florida  5,704	71
Washington 	5,212	220
Illinois 	5,058	74
Pennsylvania 	4,194	50
Louisiana 	4,025	185
Texas 	3,339	48
Georgia	 3,031	102
Colorado	2,627	51
Connecticut 	2,571	36
Tennessee	1,937	14
Ohio	1,933	40
Indiana 	1,786	35
Maryland	1,413	15
North Carolina 	1,379	8
Wisconsin	1,285	24
Arizona 	1,158	20
Missouri	1,110	14
Nevada	 1,044	18
Virginia	1,020	15
Alabama	  947	11
South Carolina 	925	18
Mississippi 	847	16
Utah	 805	4
Oregon	 606	16
Minnesota	576	10
Arkansas	508	7
District of Columbia	495	9
Oklahoma	481	17
Kentucky	480	11
Idaho	431	8
Iowa	424	6
Rhode Island	408	4
Kansas	374	8
New Hampshire	314	3
New Mexico 	281	4
Maine	275	3
Delaware	264	7
Vermont  256	12
Puerto Rico 	 239	8
Hawaii  	204	0
Montana  177	5
Nebraska	153	3
West Virginia	145	1
Alaska	119	3
North Dakota	109	3
South Dakota	101	1
Wyoming	 95	0
Guam	 69	2
;
proc  sort data=March_31; by descending conf_cases descending death;
title 'Coronavirus Maps of the United States:';
title2 'Confirmed Cases and Deaths - published on March 31, 2020';
proc print split='*';
label state = 'State/Teritorry'
      conf_cases = 'Number of*Confirmed Cases'
      death ='Number of Deaths'
      death_rate_IC ="Death Rate* per 1,000*Confirmed Cases";
sum conf_cases death ;
format conf_cases death comma12. death_rate_IC 5.1;
run;
