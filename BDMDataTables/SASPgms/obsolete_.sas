dm "log; clear; output; clear; odsresults; clear;";
libname mydata 'C:\Explore\BDMDataTables\SASData';

proc sort data=mydata.EMB_2025 out=emb_2025_s;
    by district i_date i_sn;
run;

ods html file="EMB_2025_data_table.html" style=journal;

title1 "Violence Against Religious Minorities in Bangladesh (2025)";
title2 "Killings | Rape & Sexual Violence | Blasphemy-Related Attacks | Religious Violence | Property Damage | Land Grabbing";
title3 "January 1 – December 31, 2025";

footnote1 "Data Source: Bangladesh Hindu Buddhist Christian Unity Council";
footnote2 "Data processed using SAS and Python.";

proc report data=emb_2025_s nowd split='|' headline headskip missing
    style(report)=[rules=all frame=box cellpadding=3 cellspacing=0]
    style(header)=[font_weight=bold background=cxD9EAF7]
    style(column)=[fontfamily="Arial" fontsize=9pt];

    columns district i_sn i_loc i_date i_description i_info_s;

    define district      / order   "District of Incident" width=18;
    define i_sn          / display  "Serial Number (From Source Data)" center width=8;
    define i_loc         / display  "Detailed Incident Location" flow width=25;
    define i_date        / display  "Date of Incident" center width=12;
    define i_description / display  "Description of Incident" flow width=60;
    define i_info_s      / display  "Source of Information" flow width=30;

    break after district / skip;
run;

ods html close;
title;
footnote;
