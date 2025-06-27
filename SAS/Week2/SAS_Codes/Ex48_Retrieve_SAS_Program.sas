options nosymbolgen nomlogic nomprint;
%LET path =C:\SASCourse\Week2\SAS_Codes;
%put &=path;
Filename FN "&path\Log_File.TXT"; * File to read from ;

/* Code stolen from: How to remove log numbers? from https://communities.sas.com */
data _null_;
   infile FN;
   input @; 
   if _infile_ ne ' '; * not blank ;
   if '0' < substr(_infile_,1,1) <= '9'; * begins with number ;
   num_end = index(_infile_, ' '); * find blank ;
   _infile_ = substr(_infile_, num_end); * take rest of line ;

   file "&path\Retrieved_From_Log.sas";  * File to write to ;
   put _infile_;
run;
