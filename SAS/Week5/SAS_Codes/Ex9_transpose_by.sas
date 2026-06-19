*Ex9_transpose_by.sas (Part 1);
 options nodate nonumber ;
 proc format;
 value cat_fmt 1 = 'Water'
               2 = 'Phone'
		       3 = 'Electricity';
 data have;
  length year $4;
  input year Bill_type mean @@;
  format Bill_type cat_fmt.;
  label bill_type = 'Type of Bills'
        mean = 'Average Monthly Bill ($)';
  datalines;
  2010 1 256.3 2011 1 235.4 2012 1 215.5
  2013 1 210.7 2014 1 209.3 2010 2 145.5
  2011 2 150.8 2012 2 147.1 2013 2 180.8
  2014 2 142.9 2010 3 219.5 2011 3 245.8
  2012 3 242.0 2013 3 239.8 2014 3 223.8
  ;
  run;
 proc sort data=have; by Bill_type; run;
 title1 'Original data table  from a family';
 proc print data=have label noobs; run;

 *Ex9_transpose_by.sas (Part 2);
 proc transpose data= have out=have_t (drop=_NAME_);
           by Bill_type; 
		   id year;
		   idlabel year;
           var mean;
run;
title1 'Transposed data table (Average Monthly Bill of a family)';
proc print data=have_t (drop=_label_) noobs label; 
run;

