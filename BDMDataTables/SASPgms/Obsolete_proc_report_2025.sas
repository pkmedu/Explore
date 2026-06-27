dm "log; clear; output; clear; odsresults; clear;";
libname mydata 'C:\Explore\BDMDataTables\SASData';

proc sort data=mydata.EMB_2025 out=emb_2025_s;
    by district i_date i_sn;
run;

ods html file="EMB_2025_data_table.html" style=journal;

title1 font="Arial" "EMB 2025 Dashboard";
title2 font="Arial" "Minority Victims Listing";

proc report data=emb_2025_s nowd split='|' headline headskip missing
    style(report)=[rules=all frame=box cellpadding=3 cellspacing=0]
    style(header)=[font_weight=bold background=cxD9EAF7]
    style(column)=[font="Arial" fontsize=9pt];

    columns district i_sn i_date i_loc i_description i_info_s;

    define district      / group   "District" order=data style(column)=[cellwidth=1.2in];
    define i_sn          / display "No." style(column)=[cellwidth=0.5in just=c];
    define i_date        / display "Date" format=date9. style(column)=[cellwidth=0.9in just=c];
    define i_loc         / display "Location" flow style(column)=[cellwidth=1.5in];
    define i_description / display "Description" flow style(column)=[cellwidth=3.8in];
    define i_info_s      / display "Source / Info" flow style(column)=[cellwidth=2.2in];

    break after district / skip;
run;

ods html close;
title;
