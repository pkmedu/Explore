data test;
  call streaminit(5);
  do Date='01jan2006'd to '31dec2013'd;
    j=RAND('Normal', 5000,1000);
       output;
    end;
run;
proc print data=test noobs; 
format date date9.;
where year(date)= 2006;
run;
* Code obtained from SAS Documentation;
proc format;
   value MYfmt
        /* Format dates prior to 31DEC2011 using only a year. */
        low-'31DEC2011'd=[year4.]

        /* Format 2012 dates using the month and year. */
        '01jan2012'd-'31DEC12'd=[monyy7.]

        /* Format dates 01JAN2013 and beyond using the day, month, and year. */
        '01JAN2013'd-high=[yyq6.]

        /* Catch missing values. */
        other='n/a';
run;
proc means data=test sum  maxdec=1;
      var j;
      class date;
      format date myfmt.;
run;

