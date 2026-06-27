dm "log; clear; output; clear; odsresults; clear;";

libname mydata "C:\Explore\BDMDataTables\SASData";

/*------------------------------------------------------------------
  Sort Data
------------------------------------------------------------------*/
proc sort data=mydata.emb_aug21_Dec31_2024
          out=emb_2024_s;
    by district i_date i_sn;
run;

/*------------------------------------------------------------------
  Summary Statistics
------------------------------------------------------------------*/
proc sql noprint;
    select count(*)
        into :n_cases trimmed
    from emb_2024_s;

    select count(distinct district)
        into :n_districts trimmed
    from emb_2024_s;
quit;

/*------------------------------------------------------------------
  Style Template
------------------------------------------------------------------*/

proc template;
define style styles.MyDashboard;
    parent=styles.htmlblue;

    style Data from Data /
        background=cxEFEFEF
        foreground=black
        fontfamily="Arial"
        fontsize=16px;

    style DataEmphasis from DataEmphasis /
        background=cxEFEFEF;

    style DataStrong from DataStrong /
        background=cxEFEFEF;
end;
run;

/*------------------------------------------------------------------
  Open HTML Destination
------------------------------------------------------------------*/
ods escapechar='^';

options nodate nonumber;
title;
footnote;

ods html
    path="C:\Explore\BDMDataTables\HTMLOutput"
    file="BD_MVictims_Aug21_Dec31_2024db.html"
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

Violence Against Religious Minorities in Bangladesh (2024 Partial)

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

August 21 - December 31, 2024

</div>

</div>

<br>
";
run;

/*------------------------------------------------------------------
  Main Report
------------------------------------------------------------------*/
proc report data=emb_2024_s nowd missing
    style(report)=[rules=all frame=box cellpadding=4 cellspacing=0 width=100%]
    style(header)=[fontfamily='Arial' fontsize=18pt fontweight=bold fontstyle=roman background=white]
    style(column)=[fontfamily='Arial' fontsize=16pt];

    columns district
            i_sn
            i_loc
            i_date
            i_description
            i_info_s;

    define district / order "District of Incident" width=18;
    define i_sn / display center "Serial Number" width=6;
    define i_loc / display flow "Detailed Incident Location" width=24;
    define i_date / display center "Date of Incident" width=12;
    define i_description / display flow "Description of Incident" width=60;
    define i_info_s / display flow "Source of Information" width=30;

    compute i_description;
        length desc $1000;
        desc = upcase(i_description);

        if find(desc,'DEATH','i')      > 0 or
           find(desc,'DECOMPOSED','i') > 0 or
           find(desc,'DIED','i')       > 0 or
           find(desc,'ABDUCTED','i')   > 0 or
           find(desc,'MURDER','i')     > 0 or
           find(desc,'KILL','i')       > 0 or
           find(desc,'RAPE','i')       > 0 or
           find(desc,'BLASPHEMY','i')  > 0 then
            call define(_col_,'style','style=[foreground=red fontweight=bold]');
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
              font-size:14pt;'>

<tr>
<th style='border:1px solid #999999;
           padding:8px;
           background:white;'>
Total Incidents
</th>

<th style='border:1px solid #999999;
           padding:8px;
           background:white;'>
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
<table style='width:100%;
              border-collapse:collapse;
              font-family:Arial;
              font-size:14pt;'>
<tr>
<td style='width:100%;
           white-space:nowrap;
           line-height:1.6;'>
<b>Data Source:</b> Bangladesh Hindu Buddhist Christian Unity Council<br>
<b>Website:</b> <a href='https://www.bhbcuc.org' target='_blank'>https://www.bhbcuc.org</a><br>
<b>Data processed using SAS and Python</b><br>
Generated: %sysfunc(datetime(),datetime20.)
</td>
</tr>
</table>
";
run;

/*------------------------------------------------------------------
  Close HTML
------------------------------------------------------------------*/
ods html close;
