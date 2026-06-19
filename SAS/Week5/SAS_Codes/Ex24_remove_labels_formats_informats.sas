* Ex24_remove_formats_informats.sas;
* sashelp.mdv - Sales Data and Forecast;

dm "clear log; clear output; clear odsresults;";
options nocenter nodate nonumber nosource;
title 'Metadata in sashelp.mdv';
proc contents data=sashelp.mdv varnum;
ods select position;
run;

data mdv;
  set sashelp.mdv;
 run;

proc datasets lib=work memtype=data nolist;
     modify mdv;
     attrib _all_ format=;
     attrib _all_ informat=;
run;
quit;
title 'Metata data in new dataset called MDV';
title2 'After formats and informats removed from sashelp.mdv';


proc contents data=mdv varnum;
ods select position;
run;

title; title2;
