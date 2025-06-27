* The following coding examples are obtained from SAS Documentation;
data firstlast;
   input String $60.;
   First_Word=scan(string, 1);
   Last_Word=scan(string, -1);
   datalines4;
Jack and Jill
& Bob & Carol & Ted & Alice &
Leonardo
! $ % & ( ) * + , - . / ;
;;;;
proc print data=firstlast;
run;

data all;
   length word $20;
   drop string;
   string=' The quick brown fox jumps over the lazy dog.   ';
   do until(word=' ');
      count+1;
      word=scan(string, count);
      output;
   end;
run;
proc print data=all noobs;
run;
