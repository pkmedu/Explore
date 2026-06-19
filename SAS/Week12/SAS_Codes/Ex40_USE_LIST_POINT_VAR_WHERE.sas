*Ex40_USE_LIST_POINT_VAR_WHERE.sas;
OPTIONS nocenter ps=58 ls=72 nodate nonumber 
  FORMCHAR="|----|+|---+=|-/\<>*" ;
proc iml;
 use sashelp.class ;
 *list all;
 list point 3;
 list point {2 4};
 p= {1 3 5};
 v={name height weight};
 list point p var v;
 list all var v where (weight >=150);
quit;
