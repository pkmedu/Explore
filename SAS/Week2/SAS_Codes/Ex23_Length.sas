*Ex23_Length.sas;
data temp;
length x 4 y 3 ;
     do x=9006 to 9010;
       output;
	 end;
proc print data=temp noobs; run;


/*
A variable's length (the number of bytes used to store it) is 
related to its type

- Character variables can be up to 32,767 bytes long.
- All numeric variables have a default length of 8 bytes.
  Numeric values (no matter how many digits they contain)
  are stored as floating numbers in 8 bytes.
*/
