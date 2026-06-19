
*Ex12_Dumping_Records.sas;

options nocenter;
FILENAME raw 'C:\SASCourse\Week2\SAS_Codes\pop2013_no_headers.txt';
DATA _NULL_;
INFILE raw FIRSTOBS=4 OBS=6;
INPUT;
PUT _INFILE_ //;
RUN; 
