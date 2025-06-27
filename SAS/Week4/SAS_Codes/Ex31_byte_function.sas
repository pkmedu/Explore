*Ex31_byte_function.sas;
options nocenter notes nodate nonumber source;
/*
Acknowledgements:
PharmaSUG 2013 - Paper CC30
Useful Tips for Handling and Creating Special Characters in SAS®
Bob Hull, SynteractHCR, Inc., Carlsbad, CA
Robert Howard, Veridical Solutions, Del Mar, CA 
*/

  data _null_;
 	do i=1 to 255;
 		byte=byte(i);
		put i +10 byte;
 	end;
  run; 
