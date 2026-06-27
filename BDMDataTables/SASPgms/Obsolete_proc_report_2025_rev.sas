dm "log; clear; output; clear; odsresults; clear;";
libname mydata 'C:\Explore\BDMDataTables\SASData';

proc sort data=mydata.EMB_2025 out=emb_2025_s;
    by district i_date i_sn;
run;

ods html file="EMB_2025_data_table.html" style=journal;

title1 font="Arial" "Violence Against Religious Minorities in Bangladesh (2025)";
title2 font="Arial" "Killings | Rape & Sexual Violence | Blasphemy-Related Attacks | Religious Violence | Property Damage | Land Grabbing";
title3 font="Arial" "January 1 – December 31, 2025";

footnote1 font="Arial" "Data Source: Bangladesh Hindu Buddhist Christian Unity Council";
footnote2 font="Arial" "Data processed using SAS® and Python.";

proc report data=emb_2025_s nowd split='|' headline headskip missing
    style(report)=[rules=all frame=box cellpadding=3 cellspacing=0]
    style(header)=[font_weight=bold background=cxD9EAF7]
    style(column)=[font="Arial" fontsize=9pt];

    columns district i_sn i_loc i_date i_description i_info_s;

    define district      / group   "District of Incident" order=data;
    define i_sn          / display "Serial Number (From Source Data)" center;
    define i_loc         / display "Detailed Incident Location" flow;
	define i_date        / display "Date of Incident" center;
    define i_description / display "Description of Incident" flow;
    define i_info_s      / display "Source of Information" flow;

    compute district;
        call define(_col_,'style','style=[cellwidth=1.2in]');
    endcomp;

    compute i_sn;
        call define(_col_,'style','style=[cellwidth=0.5in]');
    endcomp;

    compute i_date;
        call define(_col_,'style','style=[cellwidth=0.9in]');
    endcomp;

    compute i_loc;
        call define(_col_,'style','style=[cellwidth=1.5in]');
    endcomp;

    compute i_description;
        call define(_col_,'style','style=[cellwidth=3.8in]');
    endcomp;

    compute i_info_s;
        call define(_col_,'style','style=[cellwidth=2.2in]');
    endcomp;

    break after district / skip;
run;

ods html close;
title;
