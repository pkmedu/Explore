dm "log; clear; output; clear; odsresults; clear;";
libname mydata 'C:\Explore\BDMDataTables\SASData';

proc sort data=mydata.EMB_2025 out=emb_2025_s;
    by district i_date i_sn;
run;

ods html file="EMB_2025_data_table.html" style=journal;

title1 j=c font="Arial" height=14pt color=white
       "Violence Against Religious Minorities in Bangladesh (2025)";

title2 j=c font="Arial" height=10pt color=white
       "Killings | Rape & Sexual Violence | Blasphemy-Related Attacks | Religious Violence | Property Damage | Land Grabbing";

title3 j=c font="Arial" height=9pt color=white
       "January 1 - December 31, 2025";
     

footnote1 j=l font="Arial" height=8pt color=black
          "Data Source: Bangladesh Hindu Buddhist Christian Unity Council";
footnote2 j=l font="Arial" height=8pt color=black
          "Data processed using SAS and Python.";

proc report data=emb_2025_s nowd split='|' headline headskip missing
    style(report)=[rules=all frame=box cellpadding=4 cellspacing=0 background=white]
    style(header)=[fontfamily="Arial" fontsize=9pt fontweight=bold
                   background=cxD9EAF7 foreground=black]
    style(column)=[fontfamily="Arial" fontsize=9pt background=white foreground=black];

    columns district i_sn i_loc i_date i_description i_info_s;

    define district      / order   "District of Incident" width=18;
    define i_sn          / display  "Serial Number" center width=8;
    define i_loc         / display  "Detailed Incident Location" flow width=25;
    define i_date        / display  "Date of Incident" center width=12;
    define i_description / display  "Description of Incident" flow width=60;
    define i_info_s      / display  "Source of Information" flow width=30;

    break after district / skip;
run;
