*Ex34_put_putlog.sas (Part 1);
/*Use the PUT statement to write to an external file that is
specified in the FILE statement (DATA Step). */

data _null_;
  input;
   file "C:\SASCourse\Week2\SomeData.txt";
   put _INFILE_ ;
  datalines4;
Department of Statistics
Columbian College of Arts & Sciences
Rome Hall
801 22nd St NW, 7th Floor
Washington, DC, 20052
Phone: 202-994-6356 | Fax: 202-994-6917
;;;;

*Ex34_put_putlog.sas (Part 2);
/*Use the PUTLOG or PUT statement to write to the SAS log*/
data _null_;
  input;
  if _N_ =1 then putlog 'Address of the Stat Department:';
   putlog _INFILE_ ;
 datalines4;
Department of Statistics
Columbian College of Arts & Sciences
Rome Hall
801 22nd St NW, 7th Floor
Washington, DC, 20052
Phone: 202-994-6356 | Fax: 202-994-6917
;;;;
