
* Check whether RLANG is enabled;
proc options option=RLANG;
run;

* List a single system environmental variable (macro code);
%put %sysget(R_Home);

* List all system environmental variables and their values (DATA step code);
filename envlist pipe "set";
data env_vars;
    length varname $100 value $256;
    infile envlist dlm='=' missover;
    input varname $ value $;
run;

* Export the list of system environmental variables to an Excel file;
proc export 
  	data=env_vars 
  	dbms=xlsx 
  	outfile="C:\Data\Environment_Variables.xlsx"
  	replace;
run;

* List all filenames with the extension SAS from a folder;
PROC IML;
SUBMIT / R;
setwd ("C:/Data")
Sys.glob("*.sas")  # returns a sorted list of files
ENDSUBMIT;
QUIT;

* Show the content of the SASV9.CFG file ;
data _null_;    
 infile "!SASCFG\sasv9.cfg";    
 input;    
 put _infile_;
run; 

* Show the content of the SASV9.CFG file;
data _null_;    
 infile "C:\Program Files\SASHome\SASFoundation\9.4\nls\en\sasv9.cfg";    
 input;    
 put _infile_;
run; 







