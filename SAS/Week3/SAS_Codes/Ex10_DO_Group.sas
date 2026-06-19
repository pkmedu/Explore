*Ex10_DO_Group.sas;
 data age_data;
  length age_group $14 xage_group $25;
  input age @@ ; 
   if age <=17 then 
       DO;
	     age_group ='<=17 Years';
	     xage_group= 'Infants-Young Adolesents';
       END;
  else if 18<=age<=34 then 
       DO;
         age_group= '18-34 Years';
		 xage_group= 'Young Adults'; 
	   END;

  else if 35<=age<=54 then 
       DO;
         age_group= '35-54 Years';
		 xage_group='Middle Aged Adults';
	   END;
  else if age>=55 then 
      DO;
	    age_group= '55+ Years';
	    xage_group= 'Older Adults';
      END; 
   datalines;
  0 5 10 17 40 48 50 59 62 81 99 100
  ; 
title1 'Listing of Multiple Variables Created with DO Group';
title2;
 proc print noobs; var age age_group xage_group; 
run;
