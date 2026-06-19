/*
In the code below, the use of the ‘Q’ modifier alone as the fourth 
argument causes the SCAN function to ignore the word delimiters
within quoted strings. The use of the ‘R’ modifier along with 
the ‘Q’ modifier enables you to correctly separate the words 
and removes the quotes from the two quoted words.  (Carpenter, 2012). 
*/

*Ex2_scan.sas (Part 1);
options nocenter nodate nonumber nonotes nosource;
data _Null_;
   var1 = 'United States, Washington DC';
   var2 ='Tim Johnson';
   var3 = " 'Silver Spring, MD 20906', 'Columbia, MD 19204'" ;
   get_country=scan(var1,1,',');
   get_city=scan(var1,2,',');
   get_LastName= scan(var2,2);
   get_CityZip1_qr = scan(var3,1, ',', 'qr'); 
putlog (_ALL_) (=//+2);
run;

*Ex2_scan.sas (Part 2);
options nocenter nodate nonumber;
data in_a;
input @1 string $char65.;
dbegin=scan(string,2,'.');
datalines;
'C:\My Files\GWU\SAS\.09202018.read_data.txt'
run;
;
proc print; run;

