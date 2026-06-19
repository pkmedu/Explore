** Adapted from Sample 24722: 
*Ex7_simualte_randomID;
   Simple random sample without replacement;
data Have;
  format GPA 3.1;
  do Grade=9 to 12;
    do StudentID=1 to 100
              +int(201*ranuni(432098));
      GPA=2.0 + (2.1*ranuni(34280));
      output;
    end;
  end;
run;
proc print data=Have;
run;
