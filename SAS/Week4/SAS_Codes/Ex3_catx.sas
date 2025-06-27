*Ex3_CATX.sas (Part 1);
data _null_;
  Length con: $12 v_catx $35; 
  con1 = 'Hypertension';
  con2 = 'Stroke';
  con3 = 'Diabetes';
  separator=','; 
   v_catx = CATX(separator, of con1-con3);
   put v_catx=;
run;

*Ex3_CATX.sas (Part 2);
*The Use of CATX and STRIP functions;
data work.HAVE1;
   INFILE datalines DLM=',';
   INPUT state_name  : $ 22. dayOfweek : $ 10. 
         Monthday : $15. year ;
         date_entry=catx(',', (dayofweek),
		                       (monthday),
                               (year)
                          );
   DATALINES;
     Delaware, Friday,  December 7, 1787
     Pennsylvania, Wednesday,  December 12, 1787
     New Jersey, Tuesday,  December 18, 1787
     South Carolina, Friday,  May 23, 1788
;
proc print data=work.HAVE1 noobs; 
run;
