*Ex10_Macro_Read_Zipped.sas;
Options nocenter nodate nonumber;
%Let Path = c:\SASCourse\Week10;
Libname mylib "&Path";
%macro readraw (first=, last=);
	Filename ZIPFILE SASZIPAM "&Path\names.zip";
	%do year=&first %to &last;
		DATA mylib.DSN&Year;
 		  INFILE ZIPFILE(yob&year..txt) DLM=',';
  		  INPUT gender $ name $ number;
	    RUN;
		title " Data File for &Year";
	    proc print data=mylib.DSN&Year(obs=5); 
        run;
     %end ;
%mend readraw;
%readraw(first=2000, last=2005)
