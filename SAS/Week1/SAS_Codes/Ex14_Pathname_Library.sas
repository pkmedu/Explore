* Ex14_Pathname_Library.sas;
/* HOW DO I  LOCATE THE SAS TEMPORARY WORK DIRECTORY?
https://stats.idre.ucla.edu/sas/faq/how-do-i-locate-the-sas-temporary-work-directory/
*/

* Method 1 - Point-and-click in Windows Environment;
ods exclude all;  /* This statement suspends all open destinations */
options nonumber nodate pagesize=100;

* Method 2;
proc options option = work;
run;

*Method 3;
%put WORK Library Folder Location -> %sysfunc(getoption(work));

* Method 4;
%let a = %sysfunc(getoption(work));
%put WORK Library Folder Location -> &a;

* Method 5 by Art Carpenter;
%put WORK Library Folder Location ->  %sysfunc(pathname(work));

/*
SASHELP - permanent library that contains sample data and 
          other files at your site. This is a read-only
          library.
SASUSER - permanent library that contains SAS files in
          the Profile catalog that stores your personal
          settings. This is also a convenient place to
          store your own files.
WORK    - a temporary library for files that do not need to
          be saved from session to session.
Source: SAS Certification Prep Guide, Base Programming
        for SAS(R)9 Third Edition (page 31). 

*/

* Retrive the folder names;

%put %sysfunc(pathname(sashelp));
%put %sysfunc(pathname(sasuser));
%put %sysfunc(pathname(work));


