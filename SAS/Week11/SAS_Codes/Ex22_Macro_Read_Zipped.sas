*Ex22_Macro_Read_Zipped.sas;
Options nocenter nodate nonumber symbolgen;
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
%readraw(first=2000, last=2005)
