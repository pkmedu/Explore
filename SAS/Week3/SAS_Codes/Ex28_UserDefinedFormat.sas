*Ex28_UserDefinedFormat.sas;
options nocenter nodate nonumber;
/*SAS-L 11/9/2018
Ian Whitlock flatfile program*/
data class;
  format
      Name    $7.
      Sex     $1.
      Age     3.
      Height  5.1
      Weight  5.1;
  set sashelp.class (obs=7);
run;quit;
proc print data=class noobs; 
run;
