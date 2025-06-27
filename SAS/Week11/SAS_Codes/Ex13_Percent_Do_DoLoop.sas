*Ex13_Percent_Do_DoLoop.sas;
*%Do Statement in a Macro;
%macro pdo;
     %local i;
     %do i=1 %to 5;
         %put i=&i;
     %end;
 %mend pdo;
 %pdo

  * Do Loop in a Data Step;
  data _Null_;
   do i = 1 to 5;
     output;
	 put (_All_) (=);
   end;
  run;


 
