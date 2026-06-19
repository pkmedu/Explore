*Ex14_YRDIFF.sas;
options nocenter nonumber nodate;
 data _null_;
 SDATE= '10jan2013'd;
 EDATE='10jan2017'd;
 N_DAYS=EDATE-SDATE;
 Y30360=yrdif(SDATE, EDATE, '30/360');  
 YACTACT=yrdif(SDATE, EDATE, 'ACT/ACT'); 
 YACT360=yrdif(SDATE, EDATE, 'ACT/360'); 
 YACT365=yrdif(SDATE, EDATE, 'ACT/365'); 
  format SDATE EDATE date9.
        N_DAYS Y30360 YACTACT YACT360 YACT365
         best.;
putlog (_ALL_) (= / +2);
run;

