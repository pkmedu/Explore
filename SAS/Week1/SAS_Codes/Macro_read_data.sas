
options symbolgen mprint;
%macro import_csvs(dir=C:/Links);

  /* 1. Get directory listing */
  filename dirlist pipe %sysfunc(quote(dir "&dir.\*.csv" /b));
   
   
/* 2. Create dataset of filenames */
  data _file_list;
    length filepath $256 filename $100 dataset_name $32;
    infile dirlist truncover;
    input filename $256.;
    filepath = cats("&dir.\", filename);
    
    /* Create valid dataset name */
    dataset_name = scan(filename, 1, '.');
    dataset_name = tranwrd(compress(dataset_name), ' ', '_');
    dataset_name = tranwrd(dataset_name, '-', '_');
    
    /* Ensure dataset name starts with a letter */
    if anydigit(substr(dataset_name, 1, 1)) then dataset_name = cats('csv_', dataset_name);
    
    /* Truncate to 32 characters */
    if length(dataset_name) > 32 then dataset_name = substr(dataset_name, 1, 32);
  run;

  /* Optional: Show file list */
  proc print data=_file_list;
    title "CSV Files Found in &dir";
  run;

  /* 3. Import files using PROC IMPORT via CALL EXECUTE */
  data _null_;
    set _file_list;
    call execute(cats(
      'proc import datafile=', quote(strip(filepath)),
      ' out=work.', dataset_name,
      ' dbms=csv replace; getnames=yes; guessingrows=max; run;'
    ));
  run;

  /* 4. Create summary of imported datasets */
  proc sql;
    create table _import_summary as
    select memname as Dataset_Name,
           nvar as Number_of_Variables,
           nobs as Number_of_Observations,
           "WORK" as Library
    from dictionary.tables
    where libname = "WORK" and
          memtype = "DATA" and
          memname not in ("_FILE_LIST", "_IMPORT_SUMMARY");
  quit;

  proc print data=_import_summary noobs;
    title "Summary of Imported CSV Files";
  run;
  title;

  /* Optional: Clean up temporary datasets */
  proc datasets lib=work nolist;
    delete _file_list _import_summary;
  quit;

%mend import_csvs;

%import_csvs(dir=C:/Links)
