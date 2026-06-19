
options validvarname=any linesize=80;

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

        /* Ensure i_date is long enough and normalize multi-line cells */
        data _tmp&i;
            length i_date $&date_len;
            set _tmp&i;
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

/* Call the macro */
%import_all_sheets(
    file=C:\Data\Original_EMB_rev.xlsx,
    out=work.EMB,
    start=2,
    end=72,
    date_len=150
);
