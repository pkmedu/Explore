*Ex12_simulate.sas;
data x;
length uuid $ 5;
do i=1 to 100;
 uuid=compress(uuidgen(), ,'kd');
 output;
 end;
 run;
 proc print data=x; run;
