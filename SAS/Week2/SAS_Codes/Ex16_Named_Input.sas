*Ex16_Named_Input.sas;

options nocenter nodate nonumber ls=132;
DATA TEST;
input name = & $ 30. address = & $ 30.
	  city_zip  = & $ 30. phone= $ 14.
      Num_employees = ;
	  FORMAT Num_employees comma7.;    
DATALINES;
name=Air Force Personnel Center /
address=550 C Street West /
city_zip=Randolph AFB, TX 78150 /
phone=1-800-525-0102 /
Num_employees=5876 
name= Navy Personnel Command /
address= 5720 Integrity Drive /
city_zip= Millington, TN 38055 /
phone= 901-874-4885 /
Num_employees=3987 
;
proc print data=TEST noobs; 
run; 

