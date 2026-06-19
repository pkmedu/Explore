*Ex5_create_mvars_from_list.sas;
* You can use %BQUOTE() instead of %STR() below (line 5);
%macro loops(list) ;
     %local xcount i yr FY_;                                             
     %let xcount=%sysfunc(countw(&list, %STR(|))); /* Count the number of data sets*/
      %put &=xcount;
     %do i = 1 %to &xcount; /* Loop through the total # of the list */   
	     %let yr=%sysfunc(putn(%eval(&i-1),z2.)); /* Generate values from 00 to 15*/ 
		 %let ds = %scan(&list,&i,%str(|));
     %put &=yr &=i &=ds;
  %end;
%mend loops;
%loops(h50|h60|h70|h79|h89|h97|h105|h113|h121|h129|h138|h147|h155|h163|h171|h181)

