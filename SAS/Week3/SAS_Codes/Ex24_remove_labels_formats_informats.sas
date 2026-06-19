* Ex24_remove_labels_formats_informats.sas;
* sashelp.mdv - Sales Data and Forecast;
options nocenter nodate nonumber nosource;
title1 'Ex24_remove_labels_formats_informats.sas (Part 1)';
title2 'Metadata in sashelp.mdv';
proc contents data=sashelp.mdv varnum;
ods select position;
run;

data mdv;
  set sashelp.mdv;
 run;
title1 'Ex24_remove_labels_formats_informats.sas (Part 2)';
title2 'After label, format, and informat removed from sashelp.mdv';
title3 'Metata data in new dataset called MDV';

proc datasets lib=work memtype=data nolist;
     modify mdv;
     attrib _all_ label=' ';
     attrib _all_ format=;
	 attrib _all_ informat=;
run;
quit;
proc contents data=mdv varnum;
ods select position;
run;

title1; title2; title3;
