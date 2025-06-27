*Ex1_Generate_Random_Numbers.sas;
*Old Way;
Data Have1;
	do i = 1 to 10;
	x = rannor(12345);
	output;
	end;
run;

*New Way;
Data Have2;
/*The STREAMINIT subroutine is used to set the seed for the random number stream.*/
call streaminit(12345);
	do i = 1 to 10;
	x = rand("Normal",0,1);
	output;
	end;
run;
proc print data=Have2; run;

*Ex1_Generate_Random_Numbers.sas;

/*The following DATA step simulates 100 independent values from various distributions. 
The subsequent PROC PRINT step displays the first five observations.
*/
Data Have3 (drop=i);
call streaminit(789);
 do i = 1 to 100;
	Random_num = rand("Normal", 80, 9);
	Num_heads = rand("Binomial", .5,10);
	Head_Tail = rand("Bernoulli", .5);
	side_num1 = floorz(6*rand("Uniform")+1); 
	intv_0_100 = 100*rand("Uniform");
	intv_50_100 = 50*rand("Uniform")+100;
    intv_50_100_I = floorz(50*rand("Uniform")+100); 
	output;
 end;
run;
proc print data=Have3 (obs=5); run;







