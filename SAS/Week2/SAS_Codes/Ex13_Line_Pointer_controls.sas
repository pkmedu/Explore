*Ex13_Line_Pointer_controls.sas (Part 1);

options nocenter ls=132 nodate nonumber;
data address1;
      input name  & $ 30.
          /subname  & $ 20.
	  /st_address1  & $ 30.
	  /st_address2  & $ 30.
          /phone $ 14.;
datalines;
Air Force Personnel Center
HQ AFPC/DPSSRP
550 C Street West
Randolph AFB, TX 78150
1-800-525-0102
Navy Personnel Command
(PERS-312E)
5720 Integrity Drive
Millington, TN 38055
901-874-4885
;
proc print data= address1 noobs; run;
*Ex13_Line_Pointer_controls.sas (Part 2);
*Multiple records per observation using the pound (#) sign;
data address2;
   infile datalines ;
   input name  & $ 30.
         #3 st_address1  & $ 30.
	 #4 st_address2  & $ 30. 
         #5 phone $ 14.;
datalines;
Air Force Personnel Center
HQ AFPC/DPSSRP
550 C Street West
Randolph AFB, TX 78150
1-800-525-0102
Navy Personnel Command
(PERS-312E)
5720 Integrity Drive
Millington, TN 38055
901-874-4885
;
proc print data= address2 noobs; run;
