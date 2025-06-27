*Ex9_Surveymeans_ODS_RTF.sas (Part 1);
ods graphics off;
data person_x;
  length age_grp $20;
  do varstr=1 to 5;
    do varpsu=1 to 3;
	    do i=1 to 1000;
           flu=scan('0,1', rantbl(0, .97, .3));
           totexp = 400+rannor(123);
           perwtf=10+ranuni(123);
		   if mod(_n_, 2) = 0 then do;
    sex='Female';
	age_grp = '18 years or older';
 end;
 else do;
    sex='Male';
    age_grp = '0-17 years';
end;
        output;
       end; 
    end; 
  end; 
run;

*Ex9_Surveymeans_ODS_RTF.sas (Part 2);
ods graphics off;
proc surveymeans data=person_x nobs mean ;
  			stratum varstr;
  			cluster varpsu;
  			weight perwtf ;
  			var TOTEXP;
			domain sex age_grp age_grp*sex('Male');
  			ods output Statistics=ALL domain=Male;
run; 

*Ex9_Surveymeans_ODS_RTF.sas (Part 3);
data new;
set ALL Male;
Label age_grp = 'Age Group'
      sex = 'Sex'
      mean= 'Weighted Annual Mean *Health Care Expenses ($)'
      StdErr= 'Standard Error';
run;
proc format;
value $sex_fmt .='Both Sexes';
run;
*Ex9_Surveymeans_ODS_RTF.sas (Part 4);
ods path (prepend) work.templat(update);
proc template;
     define style styles.test;
       parent=styles.journal;
      class HeadersAndFooters /
             font=(Arial,12pt);    
       class SystemTitle from TitlesAndFooters /
             font=(Arial,12pt);
      class SystemFooter/font=(Arial,12pt);
     end;
   run;
*Ex9_Surveymeans_ODS_RTF.sas (Part 5);
options nocenter nodate nonumber;
ods rtf file="C:\SASCourse\Week7\Surveymeans.rtf" 
           style=styles.test bodytitle;   
title 'Table 1: Average Health Care Expenses by Age and Sex' ;
proc print data=new noobs split='*'; 
  var age_grp SEX N  Mean  StdErr;
  format SEX $sex_fmt.  N  Mean comma7. StdErr 7.2;
run;
ods rtf close;


