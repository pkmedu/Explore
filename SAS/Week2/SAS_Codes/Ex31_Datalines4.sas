
/*
http://www.sascommunity.org/wiki/DATALINES4_statement
The DATALINES4 statement preceeds any lines of data that 
are going to be read into the DATA step. The lines of data, 
which may contain semicolons, that immediately follow 
this statement end when four consecutive semicolons are 
encountered on anew line. If the data itself does not 
contain any semicolons then the DATALINES statement 
can be used instead.

The DATALINES4 statement must be used at the end of 
a DATA Step after all the other statements in the 
data step but before the lines of data, 4 consecutive 
terminating semicolons on a new line and the RUN statement.

*/
*Ex31_Datalines4.sas;
data Have;
   input state_data $50. ;
   datalines4;
Alabama;  4833722; 77.0
    California;  38332521; 76.1
;;;;

  proc print data=work.HAVE noobs;
   run;
