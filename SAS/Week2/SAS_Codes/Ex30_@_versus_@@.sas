
/*
Source: ChatGPT

Example 1: Using @ (Single Trailing @)
Suppose you have a dataset where each record spans multiple fields
on a single line, and you want to read part of it, apply logic, 
then read the rest.

Goal:
Read ID, Name, and Age, but only output the record if Age > 30.

@ prevents SAS from moving to the next line after ID and Name.
SAS reads Age on the same line.
Only records where Age > 30 are output.
*/

DATA example1;
    INPUT ID $ Name $ @;          /* Holds the line after reading ID and Name */
    INPUT Age;                    /* Reads Age on the same line */
    IF Age > 30 THEN OUTPUT;      /* Outputs only if Age > 30 */
    PUT ID= Name= Age=;           /* Prints to log */
DATALINES;
101 John 28
102 Alice 35
103 Bob 40
;
RUN;



/*
Example 2: Using @@ (Double Trailing @@)
Now, imagine you have multiple records on a single line, and 
you wantto read all the values before moving to the next line.

Goal:
Read multiple records from a single line.
*/

DATA example2;
    INPUT ID $ Age @@;            /* Holds the line across iterations */
    PUT ID= Age=;                 /* Prints to log */
DATALINES;
101 28 102 35 103 40
201 22 202 45
;
RUN;

/*

Summary:
@: Reads one observation per iteration and holds the line for the next input statement.
@@: Reads as many observations as possible from a single line until the line is exhausted.


*/

* Another example for the @@ use;

data work.HAVE;
 input date: Anydtdte. name $ study_hours @@;
datalines;
27Aug2018 Doris 5.5 28Aug2018 Alice 4.0 
29Aug2018 Mike 2.0 29Aug2018 James 1.0 
30Jun2018 Doris 3.0 31Aug2018 Alice 3.0 
01Sep2018 Mike 3.0 
02Sep2018 James 1.0
;
proc print data=work.HAVE;
Format date mmddyy10.;
run;
