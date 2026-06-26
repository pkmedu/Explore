dm "log; clear; output; clear; odsresults; clear;";

libname mydata 'C:\Explore\BDMDataTables\SASData';

proc sort data=mydata.EMB_2025 out=emb_2025_s;
    by district i_date i_sn;
run;

/* Open ODS HTML */
ods html file="EMB_2025_data_table.html" style=journal;

ods escapechar='^';

/* Title block (consistent styling) */
title1 justify=center color=white
  "Violence Against Religious Minorities in Bangladesh (2025)";

title2 justify=center color=white
  "Killings | Rape & Sexual Violence | Blasphemy-Related Attacks | Religious Violence | Property Damage | Land Grabbing";

title3 justify=center color=white
  "January 1 - December 31, 2025";

footnote1 font="Arial" height=8pt
          "Data Source: Bangladesh Hindu Buddhist Christian Unity Council";
footnote2 font="Arial" height=8pt
          "Data processed using SAS and Python";

/* Optional styled banner */
proc odstext;
    p "<div style='background:#1F4E78;padding:10px;text-align:center;color:white;font-family:roman;'>
         <div style='font-size:20pt;font-weight:bold;'>
           Violence Against Religious Minorities in Bangladesh (2025)
         </div>
         <div style='font-size:14pt;font-weight:bold;'>
           Killings | Rape & Sexual Violence | Blasphemy-Related Attacks | Religious Violence | Property Damage | Land Grabbing
         </div>
         <div style='font-size:12pt;'>
           January 1 - December 31, 2025
         </div>
       </div>";
run;

/* Core report */
proc report data=emb_2025_s nowd missing
    style(report)=[rules=all frame=box cellpadding=4]
    style(header)=[fontfamily="Arial" fontsize=12pt fontweight=bold background=cxD9EAF7]
    style(column)=[fontfamily="Arial" fontsize=12pt];

    columns district i_sn i_loc i_date i_description i_info_s;

    define district      / order "District of Incident" width=18;
    define i_sn          / display "Serial Number (From Source Data)" center width=6;
    define i_loc         / display "Detailed Incident Location" flow width=24;
    define i_date        / display "Date of Incident" center width=12;
    define i_description / display "Description of Incident" flow width=60;
    define i_info_s      / display "Source of Information" flow width=30;

    break after district / skip;
run;

/* Clear titles */
title;
footnote;

ods html close;
