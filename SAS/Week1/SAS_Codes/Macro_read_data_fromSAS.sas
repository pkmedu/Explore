options nosymbolgen nomprint;
/* Source:https://documentation.sas.com/doc/en/pgmsascdc/9.4_3.5/mcrolref/n0ctmldxf23ixtn1kqsoh5bsgmg8.htm */
%macro drive(dir,ext); 
   %local cnt filrf rc did memcnt name;

   %let cnt=0;
   %let filrf=mydir;

   %let rc=%sysfunc(filename(filrf,&dir));
   %let did=%sysfunc(dopen(&filrf));

   %if &did ne 0 %then %do;
      %let memcnt=%sysfunc(dnum(&did));
      %do i=1 %to &memcnt;
         %let name=%qscan(%qsysfunc(dread(&did,&i)),-1,.);
         %if %qupcase(%qsysfunc(dread(&did,&i))) ne %qupcase(&name) %then %do;
            %if %superq(ext) = %superq(name) %then %do;
               %let cnt=%eval(&cnt+1);
               %put %qsysfunc(dread(&did,&i));
               proc import datafile="&dir\%qsysfunc(dread(&did,&i))" out=_dsn&cnt  /*modified by Pradip Muhuri */
                  dbms=csv replace;
                  guessingrows=max;
               run;
            %end;
         %end;
       %end;
	   proc contents data=_dsn&cnt position;
       ods select variables;
       run;
    %end;
  %else %put &dir cannot be opened.;

  
  %let rc=%sysfunc(dclose(&did));
%mend drive;
%drive(c:\Links,csv)

libname new 'C:\Links';
data new.all_hashtags;
 set work._:;
run;
