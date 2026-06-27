dm "log; clear; output; clear; odsresults; clear;";

libname mydata "C:\Explore\BDMDataTables\SASData";

/*------------------------------------------------------------------
  Sort Data
------------------------------------------------------------------*/
proc sort data=mydata.EMB_2025
          out=emb_2025_s;
    by district i_date i_sn;
run;

/*------------------------------------------------------------------
  Summary Statistics
------------------------------------------------------------------*/
proc sql noprint;
    select count(*)
        into :n_cases trimmed
    from emb_2025_s;

    select count(distinct district)
        into :n_districts trimmed
    from emb_2025_s;
quit;

/*------------------------------------------------------------------
  Open HTML Destination
------------------------------------------------------------------*/
ods escapechar='^';

options nodate nonumber;
title;
footnote;
proc template;
define style styles.MyDashboard;
    parent = styles.journal;

    style Body from Body /
        background = white
        fontface = "Arial"
        fontsize = 14pt;

    style Table from Table /
        fontface = "Arial"
        fontsize = 13pt;

    style Header from Header /
        fontface = "Arial"
        fontsize = 18pt
        fontweight = bold
        fontstyle = roman
        background = white;

    style Data from Data /
        fontface = "Arial"
        fontsize = 16pt
        background =  cx87CEFA;
end;
run;

ods html
    path="C:\Explore\BDMDataTables\HTMLOutput"
    file="BD_Minority_Victims_2025_dashboard.html"
    style=styles.MyDashboard;

/*------------------------------------------------------------------
  Dashboard Banner
------------------------------------------------------------------*/
proc odstext;
p "
<div style='background:#1F4E78;
            padding:15px;
            text-align:center;
            color:white;
            font-family:Arial;
            border-radius:6px;'>

<div style='font-size:32pt;
            font-weight:bold;'>

Violence Against Religious Minorities in Bangladesh (2025)

</div>

<div style='font-size:22pt;
            font-weight:bold;
            margin-top:10px;'>

Killings |
Rape & Sexual Violence |
Blasphemy-Related Attacks |
Religious Violence |
Property Damage |
Land Grabbing

</div>

<div style='font-size:16pt;
            margin-top:10px;'>

January 1 - December 31, 2025

</div>

</div>

<br>
";
run;

/*------------------------------------------------------------------
  Main Report
------------------------------------------------------------------*/
proc report data=emb_2025_s nowd missing
    style(report)=[
        rules=all
        frame=box
        cellpadding=4
        cellspacing=0
        width=100%
    ]
    style(header)=[
        fontfamily='Arial'
        fontsize=18pt
        fontweight=bold
        fontstyle=roman
        background=cxD9EAF7
    ]
    style(column)=[
        fontfamily='Arial'
        fontsize=16pt
        background=cx87CEFA
    ];

    columns district
            i_sn
            i_loc
            i_date
            i_description
            i_info_s;

    define district
        / order
          "District of Incident"
          width=18;

    define i_sn
        / display
          center
          "Serial Number"
          width=6;

    define i_loc
        / display
          flow
          "Detailed Incident Location"
          width=24;

    define i_date
        / display
          center
          "Date of Incident"
          width=12;

    define i_description
        / display
          flow
          "Description of Incident"
          width=60;

    define i_info_s
        / display
          flow
          "Source of Information"
          width=30;

    compute i_description;
        length desc $1000;
        desc = upcase(i_description);

        if find(desc,'DEATH','i')      > 0 or
           find(desc,'DECOMPOSED','i') > 0 or
           find(desc,'DIED','i')       > 0 or
           find(desc,'ABDUCTED','i')    > 0 or
           find(desc,'MURDER','i')      > 0 or
           find(desc,'KILL','i')        > 0 or
           find(desc,'RAPE','i')        > 0 or
           find(desc,'BLASPHEMY','i')   > 0 then
            call define(_col_,
                        'style',
                        'style=[foreground=red fontweight=bold]');
    endcomp;

    break after district / skip;
run;

/*------------------------------------------------------------------
  Totals After Table
------------------------------------------------------------------*/
proc odstext;
p "
<br>

<table style='width:45%;
              margin-left:auto;
              margin-right:auto;
              border-collapse:collapse;
              font-family:Arial;
              font-size:12pt;'>

<tr>

<th style='border:1px solid #999999;
           padding:8px;
           background:#D9EAF7;'>

Total Incidents

</th>

<th style='border:1px solid #999999;
           padding:8px;
           background:#D9EAF7;'>

Districts Affected

</th>

</tr>

<tr>

<td style='border:1px solid #999999;
           padding:8px;
           text-align:center;
           font-weight:bold;'>

&n_cases

</td>

<td style='border:1px solid #999999;
           padding:8px;
           text-align:center;
           font-weight:bold;'>

&n_districts

</td>

</tr>

</table>

<br>
";
run;

/*------------------------------------------------------------------
  Footer
------------------------------------------------------------------*/
proc odstext;
p "
<hr>

<div style='font-family:Arial;
            font-size:14pt;'>

<b>Data Source:</b>
Bangladesh Hindu Buddhist Christian Unity Council

<br><br>

<b>Website:</b>
https://www.bhbcuc.org

<br><br>

<b>Data processed using SAS and Python</b>

<br><br>

Generated:
%sysfunc(datetime(),datetime20.)

</div>
";
run;

/*------------------------------------------------------------------
  Close HTML
------------------------------------------------------------------*/
ods html close;
