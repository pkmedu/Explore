/*** SAS 9.3 Documentation ***/
*Ex19_count_repeated_rows.sas;
data Duplicates;
   input LastName $ FirstName $ City $ State $;
   datalines;
Smith John Richmond Virginia
Johnson Mary Miami Florida
Smith John Richmond Virginia
Reed Sam Portland Oregon
Davis Karen Chicago Illinois
Davis Karen Chicago Illinois
Thompson Jennifer Houston Texas
Smith John Richmond Virginia
Johnson Mary Miami Florida
;
proc sort data=duplicates; by LastName FirstName City State;
run;
proc print data=Duplicates;
  title 'Sample Data for Counting Duplicates';
run;
proc sql;
   title 'Duplicate Rows in DUPLICATES Table';
   select *, count(*) as Count
      from Duplicates
      group by LastName, FirstName, City, State
      having count(*) > 1;
 /*    
How It Works
This solution uses a query that performs the following:
selects all columns
counts all rows
groups all of the rows in the Duplicates table by matching rows
excludes the rows that have no duplicates
Note: You must include all of the columns in your table 
	  in the GROUP BY clause to find exact duplicates.
*/
proc sort data=duplicates noduprec out=singles; 
  by LastName FirstName City State;
run;

proc print data=singles; run;

