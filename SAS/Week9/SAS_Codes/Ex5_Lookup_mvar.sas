*Ex5_Lookup_mvar.sas (Part 1);
Options nocenter nodate nonumber;
Title1 "Look-up using a data step variable";
Title2 "  ";
proc print data=sashelp.demographics;
var name pop;
where pop>200000000;
run;

*Ex5_Lookup_mvar.sas (Part 2);
Options nocenter nodate nonumber;
Title1 "Look-up using a macro variable"; 
Title2 "that contains a numeric value";
%let size=200000000;
proc print data=sashelp.demographics noobs;
var name pop;
where pop>&size;
run;
*Ex5_Lookup_mvar.sas (Part 3);
options Options nocenter nodate nonumber symbolgen;
Title1 "Look-up using a macro variable"; 
Title2 "that contains a character value";
%let c_name=QATAR;
proc print data=sashelp.demographics noobs;
var name pop;
where name = "&c_name";
run;

*Ex5_Lookup_mvar.sas (Part 4);
options nocenter nodate nonumber;
Title1 "Look-up using a macro variable"; 
Title2 "that contains a quoted character value";
%let c_name='QATAR';
proc print data=sashelp.demographics noobs;
var name pop;
where name = &c_name;
run;

/*List obseravtions having the country names that begin 
  with Q or Z in the the SASHELP.DEMOGRAPHICS data set.
  Using IN:( ) to Code Character Comparisons with
  Criteria Having Different Lengths  - Global Forum paper 
  by Paul Grant (2009)*/

*Ex5_Lookup_mvar.sas (Part 5);
options nocenter nodate nonumber symbolgen;
Title1 "Look-up using a macro variable"; 
Title2 "that contains character values";
%let name_QZ=('Q', 'Z');
proc print data=sashelp.demographics noobs;
var name pop;
where name in: &name_QZ;
run;



