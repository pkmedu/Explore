
/* dm "clear log; clear output; clear odsresults"; */
options validvarname=any linesize=80;
libname XL XLSX 'C:\Data\Original_EMB_rev.xlsx';
%macro make_sheet_list;
%macro import_all_sheets(file=, out=, start=2, end=72, date_len=150);
    /* 
    file    = full path to Excel file
    out     = final output dataset
    start   = first sheet number
    end     = last sheet number
    date_len = length for i_date to avoid truncation
    */

    %local i sheet_name;

    /* Create an empty dataset with proper lengths */
    data &out;
        length i_sn 8 i_loc $80 i_date $&date_len i_description $500 i_info_s $80;
        stop; /* empty */
    run;

    /* Loop over sheets and import individually */
    %do i = &start %to &end;
        %let sheet_name = Table &i;

        proc import datafile="&file"
            out=_tmp&i
            dbms=xlsx
            replace;
            sheet="&sheet_name";
            getnames=yes;
        run;

        /* Ensure i_date is long enough */
        data _tmp&i;
            length i_date $&date_len;
            set _tmp&i;

            /* Normalize multi-line Excel cells: replace LF/CR with space */
            i_date = translate(strip(i_date), ' ', '0A0D'x);
        run;

        /* Append to final dataset */
        proc append base=&out data=_tmp&i force; run;

        /* Delete temporary dataset to save memory */
        proc datasets library=work nolist;
            delete _tmp&i;
        quit;
    %end;

%mend import_all_sheets;

%import_all_sheets(
    file=C:\Data\Original_EMB_rev.xlsx,
    out=work.EMB,
    start=2,
    end=72,
    date_len=150
);

libname XL CLEAR;

ods listing close;
ods html path="C:\Explore\PythonScriptsBDM"
         file="BD_Minority_Victims_2025.html"
         style=htmlblue;
 title 'Religiously Motivated Violence Against Minorities in Bangladesh (Killings; Rape and Other Sexual Violence; Alleged Blasphemy- and Religion-Based Attacks; Religious Site and Property Damage; Land Grabbing), January 1–December 31, 2025';
proc sort data=work.EMB; by i_sn; run;

PROC REPORT DATA=work.EMB /*(where = (i_sn ne .))*/ NOWINDOWS ;
COLUMNS i_:;
DEFINE i_sn / DISPLAY 'Serial number' style(column)=[cellwidth=0.8in] ;
*DEFINE i_district / DISPLAY 'District' style(column)=[cellwidth=1in] ;
DEFINE i_loc / DISPLAY 'Incident location' style(column)=[cellwidth=3in] ;
DEFINE i_date / DISPLAY 'Date of incident' style(column)=[cellwidth=2.5in];
DEFINE i_description / DISPLAY 'Description of incidene' style(column)=[cellwidth=4.5in];
DEFINE i_info_s / DISPLAY 'Source of information' style(column)=[cellwidth=2in];
run;;
ods html close;
title;
ods listing;


proc contents data= work.EMB varnum;
ods select position;
run;
