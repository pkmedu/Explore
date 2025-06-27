options nocenter nodate nonumber nonotes nosource;
*Ex1_substr.sas (Part 1);
data _Null_;
   var1 = 'Geology';
   new_var1 = SUBSTR(var1,1,3);
   new_var2=var1;
   SUBSTR(new_var2,1,3)='Zoo';
putlog (_ALL_) (=// +2);
 run;

*Ex1_substr.sas (Part 2);
 data _Null_;
   var1 = 'Stat4197';
   new_var1 = SUBSTR(var1,5);
   new_var3= SUBSTR(var1,5,5);
 putlog (_ALL_) (=// +2);
 run;
