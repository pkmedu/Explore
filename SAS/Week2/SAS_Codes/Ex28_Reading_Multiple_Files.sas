*Ex28_Reading_Multiple_Files.sas;

*Reading multiple raw data files into a single SAS data set;
*Method 1; 
FILENAME test ('C:\SASCourse\Week2\testfile1.csv',
               'C:\SASCourse\Week2\testfile2.csv',
			   'C:\SASCourse\Week2\testfile3.csv');
data a; 
infile test DLM=','; 
input var1 $ var2 var3; 
run;
title 'Reading multiple raw data files into a single SAS data set (Method 1)';
proc print data=a noobs; run;

* Method 2;
FILENAME test 'C:\SASCourse\Week2\testfile*.csv'; 
data b; 
infile test DLM=','; 
input var1 $ var2 var3; 
run;
title 'Reading multiple raw data files into a single SAS data set (Method 2)';
proc print data= b noobs; run;

* Method 3;
/** Use an INFILE statement with the FILEVAR= option;
* FILEVAR=variable causes the INFILE statement 
   to close the current input file and open a new 
   input file whenever the value of variable changes
   (e.g., testfile1, testfile2, testfile3). */

/*END= option - 
 The LASTFILE is a variable. LASTFILE=0
 when  the current input data record is not the last 
 record in the input file.

 LASTFILE=1
 when  the current input data record is not the last 
 record in the input file.

*/
;
data c;
 do i=1 to 3;
    add= "C:\SASCourse\Week2\testfile" || put(i,1.)|| ".csv";
	  do until (lastfile);
	   infile dummy filevar=add end=lastfile DLM=',';
	    filename=add;
		  input var1 $ var2 var3;
		  output;
		end;
	   end;
   stop;
  run;
  title 'Reading multiple raw data files into a single SAS data set (Method 3)';
  proc print data=c noobs; run;
