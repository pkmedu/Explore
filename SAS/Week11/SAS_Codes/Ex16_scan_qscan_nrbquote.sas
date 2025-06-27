
* Author: Scott Bass;
proc sql noprint;
 select catx("|",name,sex,age) 
   into :list separated by " " 
   from sashelp.class;
 quit;
 %put &list;

 %macro loop ;
 %let name=%scan(&list,1,|);
 %let sex=%scan(&list,2,|);
 %let age=%scan(&list,3,|);
 %put &=name &=sex &=age;
 %mend;
 %loop

 proc sql noprint;
 select catx("|",name,sex,age) 
   into :list separated by " " 
   from sashelp.class;
 quit;
 %put &list;

 %macro loop ;
 %let name=%scan(&list,1,|);
 %let sex=%scan(&list,2,|);
 %let age=%scan(&list,3,|);
 %put &=name &=sex &=age;
 %mend;
 %loop

proc sql noprint;
 select catx("&",name,sex,age) 
   into :list separated by " " 
   from sashelp.class;
 quit;
 %put %nrbquote(&list);

 %macro loop ;
 %let name=%qscan(&list,1, %nrstr(&));
 %let sex=%qscan(&list,2,%nrstr(&));
 %let age=%qscan(&list,3,%nrstr(&));
 %put &=name &=sex &=age;
 %mend;
 %loop



