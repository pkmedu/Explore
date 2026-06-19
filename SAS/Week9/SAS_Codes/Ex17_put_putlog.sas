*Ex17_put_putlog.sas;
/*Use the PUTLOG statement to write informational 
message (including the debugging message) to the SAS log.  
Use the PUT statement to write to an external file that is
specified in the FILE statement. */

data _null_;
  input;
   file "C:\SASCourse\Week9\SomeData.txt";
  put _INFILE_ ;
  if _N_ =1 then putlog 'Address of the Stat Department:';
 datalines4;
Department of Statistics
Columbian College of Arts & Sciences
Rome Hall
801 22nd St NW, 7th Floor
Washington, DC, 20052
Phone: 202-994-6356 | Fax: 202-994-6917
;;;;

/*Use the PUTLOG or PUT statement to write to the SAS log; 
PUTLOG, PUT and FILE statements;*/
data _null_;
  input;
   putlog _INFILE_ ;
 datalines4;
Department of Statistics
Columbian College of Arts & Sciences
Rome Hall
801 22nd St NW, 7th Floor
Washington, DC, 20052
Phone: 202-994-6356 | Fax: 202-994-6917
;;;;
