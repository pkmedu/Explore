*Ex23_Macro_Generates_Code.sas;
Options nocenter nodate nonumber nosymbolgen;
%Let Path = c:\SASCourse\Week9;
Libname mylib "&Path";
%macro readraw (first=, last=);
Filename ZIPFILE SASZIPAM "&Path\names.zip";
   %do year=&first %to &last;
	 DATA mylib.DSN&Year;
 	    INFILE ZIPFILE(yob&year..txt) DLM=',';
  	    INPUT name $ gender $ number;
	 RUN;
	 title "Listing from Data Set (Newborns' Names) for &Year";
	    proc print data=mylib.DSN&Year(obs=5) noobs; 
		format number comma7.;
        run;
    %end ;
%mend readraw;
filename mprint "&Path\Ex23_Generated_Code.sas";
options mprint mfile;
%readraw(first=2000, last=2005)

