*Ex4_CATX_IFC.sas;
options nocenter nodate nonumber;
data try ;
input (ID R SAS Python SPSS Stata) ($);
list = CatX(', ', 
               IfC( R = 'Yes' , 'R' , '' ),
               IfC( SAS = 'Yes', 'SAS' , '' ),
               IfC( Python = 'Yes' , 'Python' , '' ),
               IfC( SPSS = 'Yes' , 'SPSS' , ''),
	           IfC( Stata = 'Yes' , 'Stata' , '' ));
datalines;
ID01 Yes Yes No No No
ID02 No Yes No No Yes
ID03 No Yes Yes No No
ID04 Yes Yes Yes No No
;
proc print noobs ; run;
