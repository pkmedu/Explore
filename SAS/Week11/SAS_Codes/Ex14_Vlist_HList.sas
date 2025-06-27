*Ex14_VList_HList.sas (Part 1);
options nodate nonumber symbolgen;
%macro VList;
%local ds1 ds2 ds3 j;
%let ds1 = class;
%let ds2 = revhub2;
%let ds3 = iris;
%let dscount = 3;
%do j = 1 %to &dscount;
  title1 "%upcase(sashelp.&&ds&j)";
  proc print data=sashelp.&&ds&j (obs=3) noobs;
  run;
%end;
%mend VList;
%VList

*Ex14_VList_HList.sas (Part 2);
options nodate nonumber symbolgen;
%macro HList;
  %local dslist j;
  %let dslist = class revhub2 iris;
  %do j =1 %to %sysfunc(countw(&dslist));
	 title1 "sashelp.%scan(&dslist,&j)";
	 proc print data= sashelp.%scan(&dslist, &j)(obs=3) noobs;
	 run;
  %end;
%mend HList;
%HList


