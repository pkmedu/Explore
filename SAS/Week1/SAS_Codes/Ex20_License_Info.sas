/****************************************************************
Someone wants to know the SAS version and the operating system under 
which SAS executes on your end.

Run the two lines of code below to write the information to 
your SAS log.
*******************************************************************/

%put SAS Version: &SYSVLONG4;
%put Host Info:   &SYSHOSTINFOLONG;
